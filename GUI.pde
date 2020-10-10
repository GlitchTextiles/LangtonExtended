////////////////////////////////////////////////
//// GUI
////////////////////////////////////////////////

//int GUIBuffer=10;
//int GUISize=30;

//public class ControlFrame extends PApplet {

//  controlP5.Label label;
//  int w, h, x, y;
//  PApplet parent;
//  ControlP5 cp5;
//  boolean shift = false;
//  float value = 0.0;

//  public ControlFrame(PApplet _parent, int _x, int _y, int _w, int _h) {
//    super();   
//    parent = _parent;
//    w=_w;
//    h=_h;
//    x=_x;
//    y=_y;
//    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
//  }

//  public void settings() {
//    size(w, h);
//  }

//  public void setup() {
//    surface.setSize(w, h);
//    surface.setLocation(x, y);
//    cp5 = new ControlP5(this);
//    frameRate(30);

//    //controls
//    cp5.addBang("quit")
//      .setPosition(grid(0), grid(0))
//      .setSize(GUISize, GUISize)
//      .setLabel("quit")
//      ;
//    label = cp5.getController("quit").getCaptionLabel();
//    label.align(ControlP5.RIGHT_OUTSIDE, CENTER);
//    label.getStyle().setPaddingLeft(5);

//    cp5.addBang("save")
//      .setPosition(grid(2), grid(0))
//      .setSize(GUISize, GUISize)
//      .setLabel("save")
//      ;
//    label = cp5.getController("save").getCaptionLabel();
//    label.align(ControlP5.RIGHT_OUTSIDE, CENTER);
//    label.getStyle().setPaddingLeft(5);



//    cp5.addToggle("direction")
//      .setPosition(grid(5)+5, grid(2))
//      .setSize(GUISize-10, GUISize-10)
//      .setLabel("^")
//      .setValue(0)
//      ;
//    label = cp5.getController("direction").getCaptionLabel();
//    label.align(ControlP5.RIGHT_OUTSIDE, CENTER);
//    label.getStyle().setPaddingLeft(5);

//    color_radio = cp5.addRadioButton("color_mode")
//      .setLabel("color mode")
//      .setPosition(grid(0), grid(3))
//      .setSize(GUISize, GUISize)
//      .setItemsPerRow(4)
//      .setSpacingColumn((GUISize+GUIBuffer)+GUIBuffer)
//      .setSpacingRow(GUIBuffer)
//      .addItem("RGB", 0)
//      .addItem("HSV", 1)
//      .addItem("AVG", 2)
//      .activate(0)
//      .setValue(0)
//      ;

//    cp5.addToggle("invert")
//      .setPosition(grid(0), grid(4))
//      .setSize(GUISize, GUISize)
//      .setLabel("invert")
//      .setValue(0)
//      ;
//    label = cp5.getController("invert").getCaptionLabel();
//    label.align(ControlP5.RIGHT_OUTSIDE, CENTER);
//    label.getStyle().setPaddingLeft(5);

//    mapping_radio = cp5.addRadioButton("mapping")
//      .setLabel("mapping")
//      .setPosition(grid(2), grid(4))
//      .setSize(GUISize, GUISize)
//      .setItemsPerRow(4)
//      .setSpacingColumn((GUISize+GUIBuffer)+GUIBuffer)
//      .setSpacingRow(GUIBuffer)
//      .addItem("GROUP", 0)
//      .addItem("INDEX", 1)
//      .activate(0)
//      .setValue(0)
//      ;

//    cp5.addSlider("order")
//      .setLabel ("order")
//      .setPosition(grid(6), grid(4))
//      .setRange(0, orders.length-1)
//      .setSize(120, GUISize)
//      .setNumberOfTickMarks(orders.length-1)
//      ;

//    cp5.addSlider("shift")
//      .setLabel ("shift")
//      .setPosition(grid(6), grid(5))
//      .setRange(0, palette.swatches.size()-64-1)
//      .setSize(120, GUISize)
//      .setNumberOfTickMarks(palette.swatches.size()-64)
//      .hide()
//      ;

//    sort_radio = cp5.addRadioButton("sort_mode")
//      .setLabel("sort_mode")
//      .setPosition(grid(0), grid(5))
//      .setSize(GUISize, GUISize)
//      .setItemsPerRow(3)
//      .setSpacingColumn((GUISize+GUIBuffer)+GUIBuffer)
//      .setSpacingRow(GUIBuffer)
//      .addItem("COLOR", 0)
//      .addItem("HUE", 1)
//      .addItem("SAT", 2)
//      .addItem("BRIGHT", 3)
//      .addItem("BR-SAT", 4)
//      .addItem("SAT-BR", 5)
//      .addItem("RAND", 6)
//      .activate(0)
//      .setValue(0)
//      .hide()
//      ;

//    cp5.addBang("generate")
//      .setPosition(grid(3), grid(7))
//      .setSize(GUISize, GUISize)
//      .setLabel("randomize")
//      .hide()
//      ;
//    label = cp5.getController("generate").getCaptionLabel();
//    label.align(ControlP5.RIGHT_OUTSIDE, CENTER);
//    label.getStyle().setPaddingLeft(5);

//    cp5.addButtonBar("layer")
//      .setLabel("layer")
//      .setPosition(grid(0), grid(8))
//      .setSize(9*GUISize+9*GUIBuffer, GUISize)
//      .addItems(split("1 2 3 4 5 6 7 8", " "))
//      .setValue(0)
//      ;

//    cp5.addScrollableList("select_sequence")
//      .setLabel("select sequence")
//      .setPosition(grid(4), grid(0))
//      .setSize(4*(GUISize+GUIBuffer), 5*GUISize)
//      .setBarHeight(GUISize)
//      .setItemHeight(GUISize)
//      .addItems(Arrays.asList(sequenceList))
//      .close()
//      ;
//  }

//  public void draw() {
//    background(0);
//  }

//  // helpers for positioning GUI elements

//  int grid(int offset) {
//    return offset*(GUISize+GUIBuffer)+GUIBuffer;
//  }

//  // GUI object fuctions

//  public void layer(int theValue) {
//    for ( int i = 0; i < shifters.length; ++i) {
//      shifters[i].hide();
//    }
//    shifters[theValue].show();
//  }

//  public void order(int theValue) {
//    order = theValue;
//    sequence = dataToSwatches(rawData);
//  }

//  public void shift(int theValue) {
//    order_shift = theValue;
//    sequence = dataToSwatches(rawData);
//  }

//  public void direction(int theValue) {
//    switch(theValue) {
//    case 0:
//      diagDir = "DOWN";
//      break;
//    case 1:
//      diagDir = "UP";
//      break;
//    }
//  }

//  public void quit() {
//    exit();
//  }

//  public void save() {
//    save_file();
//  }

//  void mouseReleased() {
//    parent.redraw();
//  }
//}
