import controlP5.*;
import java.util.Collections;
import java.util.BitSet;

//Implementation of Langston's Ant
//http://mathworld.wolfram.com/LangtonsAnt.html

ArrayList<Ant> ants;

int[] states;
BitSet rules;
ArrayList<Integer> mapping;
color[] colors;

int qtyAnts = 5;
int ruleDepth = 4; // minimum rule set is 2
int steps = 1000;

PImage output;

//GUI
//ControlFrame GUI;

void setup() {
  size(768, 1000);

  output = createImage(width, height, RGB);

  initAnts();

  initMapping();
  
  rules = new BitSet(ruleDepth);
  randomizeRules();
  
  colors = new color[ruleDepth];
  randomizeColors();

  states = new int[width*height];
  initStates();

  welcomeMessage();
}

void randomizeRules() {
  for (int i = 0; i < ruleDepth; i++) {
    if (random(0, 1) < 0.5) {
      rules.set(i, false);
    } else {
      rules.set(i, true);
    }
  }
}

void initAnts(){
  ants = new ArrayList<Ant>();
  for (int i = 0; i < qtyAnts; i++) {
    ants.add(new Ant());
  }
}

void initMapping() {
  mapping = new ArrayList<Integer>();
  for (int i = 0; i < ruleDepth; i++) {
    mapping.add((i+1)%ruleDepth);
  }
}

void randomizeMapping() {
  for (int i = 0; i < mapping.size(); i++) {
    mapping.set(i, int(random(ruleDepth)));
  }
}

void shuffleMapping() {
  Collections.shuffle(mapping);
}

void sortMapping() {
  Collections.sort(mapping);
}

void reverseMapping() {
  Collections.reverse(mapping);
}

void randomizeColors() {
  for (int i = 0; i < colors.length; i++) {
    colors[i] = int(random(0xFFFFFF));
  }
}

void initStates() {
  for (int i = 0; i < width*height; i++) {
    states[i] = 0; //initialize states to all false
  }
}

void keyPressed() {
  switch(key) {
  case 'r':
    randomizeRules();
    break;
  case 'm':
    randomizeMapping();
    break;
  case 's':
    sortMapping();
    break;
  case 'i':
    initMapping();
    break;
  case 'v':
    reverseMapping();
    break;
  case 'c':
    randomizeColors();
    break;
  case 'e':
    initStates();
    break;
  }
}

void draw() {

  for (int i = 0; i < steps; i++) {
    for (Ant a : ants) { 
      states[a.getPosition()] = mapping.get(states[a.getPosition()]);
      a.update(states, rules);
    }
  }

  output=renderStates();

  image(output, 0, 0);
}

PImage renderStates() {
  PImage image = createImage(width, height, RGB);
  image.loadPixels();
  for (int i = 0; i < output.pixels.length; i++ ) {
    image.pixels[i] = colors[states[i]];
  }
  image.updatePixels();
  return image;
}

void welcomeMessage() {
  println("INSTRUNCTIONS:");
  println("");
  println("Key:    Action:");
  println("--------------------");
  println("r       randomize rules governing Ant motion");
  println("c       randomize Ant color palette");
  println("e       reinitialize Ant states");
}
