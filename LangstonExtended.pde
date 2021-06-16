import controlP5.*;
import java.util.Collections;
import java.util.BitSet;

//Implementation of Langston's Ant
//http://mathworld.wolfram.com/LangtonsAnt.html
boolean record = false;
int states_w = 10;
int states_h = 10;
int zoom = 25;
int ControlFrame_w = 640;
int ControlFrame_h = 800;
int GUILocationX = 0;
int GUILocationY = 0;

int screen_x = ControlFrame_w;
int screen_y = 0;
int screen_width = states_w * zoom;
int screen_height = states_h * zoom;

//these are used by the GUI and associated objects
int guiObjectSize = 40;
int guiObjectWidth = 600;
int guiBufferSize = 10;
int gridSize = guiObjectSize + guiBufferSize;
int gridOffset = guiBufferSize;

color backgroundColor = color(15);
color guiGroupBackground = color(30);
color guiBackground = color(60);
color guiForeground = color(120);
color guiActive=color(150);


int[][] states;
ArrayList<Integer> mapping;
color[] colors;

ArrayList<Colony> colonies;
int ruleDepth = 4; // minimum rule set is 2
int steps = 1;
int qty_ants=2;
int qty_colonies = 2;

//GUI
//ControlFrame GUI;

void setup() {
  size(1, 1, P3D);
  surface.setSize(states_w*zoom, states_h*zoom);
  colorMode(HSB, 1, 1, 1);

  colonies = new ArrayList<Colony>();

  for (int i = 0; i < qty_colonies; i++) {
    colonies.add(new Colony(qty_ants, ruleDepth));
  }

  initStates();
  initMapping();
  colors = new color[ruleDepth];
  randomizeColors();

  welcomeMessage();
}

void draw() {
  for(int i = 0 ; i < steps; i++){
  for (Colony c : colonies) {
    c.update(states);
  }
  }
  image(renderStates(), 0, 0);
}

void initMapping() {
  mapping = new ArrayList<Integer>();
  for (int i = 0; i < ruleDepth; i++) {
    println((i+1)%ruleDepth);
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
    colors[i] = color(random(0, 1), random(.5, 1), random(.5, 1));
  }
}

void initStates() {
  states = new int[states_w][states_h];
}

void keyPressed() {
  switch(key) {
  case 'r':
    for (Colony c : colonies) {
      c.randomizeRules();
    }
    break;
  case 'm':
    randomizeMapping();
    break;
  case 's':
    shuffleMapping();
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



PGraphics renderStates() {
  PGraphics output = createGraphics(width, height);
  PImage save = createImage(states_w, states_h, RGB);
  output.beginDraw();
  output.noStroke();
  for (int y = 0; y < states_h; y++ ) {
    for (int x =0; x < states_w; x++) {
      output.fill(colors[states[x][y]]);
      output.rect(x*zoom, y*zoom, zoom, zoom);
      save.pixels[x+states_w*y] = colors[states[x][y]];
    }
  }
  if (record) {
    if ( frameCount <= 1000) {
      save.save("/Users/phillipstearns/Dropbox/Projects/NFTs/H=N/smol4/smolAnt_005/smolAnt_005"+nfs(frameCount, 4)+".png");
    } else {
      exit();
    }
  }
  output.endDraw();
  return output;
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
