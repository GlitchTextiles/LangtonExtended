//Implementation of Langston's Ant
//http://mathworld.wolfram.com/LangtonsAnt.html

Ant ant;
Ant[] ants;

int[] states;
int[] rules;
color[] colors;

int qtyAnts = 2;
int ruleDepth = 512; // minimum rule set is 2

PImage output;

void setup() {
  size(768, 1000);
  
  output = createImage(width, height, RGB);
  ant = new Ant(int(width/2), int(height/2), 0);
  ants = new Ant[qtyAnts];
  rules = new int[ruleDepth];
  colors = new color[ruleDepth];

  randomizeRules();
  randomizeColors();
  
  for (int i = 0; i < ants.length; i++) {
    ants[i] = new Ant();
  }

  states = new int[width*height];

  initStates();
  
  welcomeMessage();

}

void randomizeRules(){
  for(int i = 0 ; i < rules.length ; i++){
    //rule consists of two parts: state, turn direction
    //state is shifted left one bit, turn direction is the LSB
    rules[i] = (int(random(ruleDepth)) << 1) ^ (int(random(2)) & 1);
    println(binary(rules[i]));
  }
}

void randomizeColors(){
  for(int i = 0 ; i < colors.length ; i++){
    colors[i] = int(random(0xFFFFFF));
  }
}

void initStates(){
    for (int i = 0; i < width*height; i++) {
    states[i] = 0; //initialize states to all false 
  }
}


void keyPressed(){
  switch(key){
  case 'r':
    randomizeRules();
  break;
  case 'c':
    randomizeColors();
  break;
  case 'e':
    initStates();
  break;
  }
}

/*
ant checks the color (state) of the states
sets direction
advances one square in that direction
changes the square to another state
*/

void draw() {

  for (int i = 0; i < 1000; i++) {
    for (int j = 0; j < ants.length; j++) { 

      int[] positions = new int[ants.length];
      int position = width*ants[j].y + ants[j].x;
      boolean overlap = false;

      positions[j] = position;

      ants[j].update(states);

      for (int k = 0; k < j; k++) {
        if (positions[j] == positions[k]) {
          overlap = true;
        }
      }

      //if (!overlap) states[position] = (states[position] + 1) % (ruleDepth);
      states[position] = rules[states[position]] >> 1;
      //println(states[position]);
      //println(rules[states[position]]>>1);
    }
  }
  output.loadPixels();
  for(int i = 0 ; i < output.pixels.length ; i++ ){
    output.pixels[i] = colors[states[i]];
  }
  output.updatePixels();
  image(output, 0 , 0);
}

void welcomeMessage(){
  println("INSTRUNCTIONS:");
  println("");
  println("Key:    Action:");
  println("--------------------");
  println("r       randomize rules governing Ant motion");
  println("c       randomize Ant color palette");
  println("e       reinitialize Ant states");
}
