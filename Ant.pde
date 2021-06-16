/*
 Ant checks the color(state) of the states where it is
 sets direction
 advances one square in that direction
 changes the square to another state
 */

public class Colony {

  public ArrayList<Ant> ants;
  public BitSet rules;

  public Colony(int _ruleDepth) {
    this.initAnts(0);
    this.rules = new BitSet(_ruleDepth);
    this.randomizeRules();
  }

  public  Colony(int _qty_ants, int _ruleDepth) {
    this.initAnts(_qty_ants);
    this.rules = new BitSet(_ruleDepth);
    this.randomizeRules();
  }
  
  public void randomizeRules() {
    for (int i = 0; i < ruleDepth; i++) {
      if (random(0, 1) < 0.5) {
        this.rules.set(i, false);
      } else {
        this.rules.set(i, true);
      }
    }
  }

  public ArrayList<Ant> update(int[][] _states) {
    for (Ant a : this.ants) { 
      _states[a.getX()][a.getY()] += 1;
      _states[a.getX()][a.getY()] %= ruleDepth;
      a.update(_states, rules);
    }
    return this.ants;
  }

  public ArrayList<Ant> initAnts(int _qty_ants) {
    this.ants = new ArrayList<Ant>();
    for (int i = 0; i < _qty_ants; i++) {
      this.ants.add(new Ant());
    }
    return this.ants;
  }

  public Ant get(int _which_ant) {
    if (_which_ant < 0 || _which_ant >= this.ants.size()) {
      print("[!] Requested ant: "+_which_ant+" when there are only "+this.ants.size()+" ants.");
      return null;
    } else {
      return this.ants.get(_which_ant);
    }
  }

  public int size() {
    return this.ants.size();
  }

  public ArrayList<Ant> replace(int _which_ant, Ant _ant) {
    if (_which_ant < 0 || _which_ant >= this.ants.size()) {
      print("[!] Requested ant: "+_which_ant+" when there are only "+this.ants.size()+" ants.");
    } else {
      this.ants.add(_ant);
    }
    return this.ants;
  }

  public ArrayList<Ant> reset(int _which_ant) {
    if (_which_ant < 0 || _which_ant >= this.ants.size()) {
      print("[!] Requested ant: "+_which_ant+" when there are only "+this.ants.size()+" ants.");
    } else {
      this.ants.add(new Ant());
    }
    return this.ants;
  }

  public ArrayList<Ant> add(int _qty_ants) {
    for (int i = 0; i < _qty_ants; i++) {
      this.ants.add(new Ant());
    }
    return this.ants;
  }

  public ArrayList<Ant> add(Ant _ant) {
    this.ants.add(_ant);
    return this.ants;
  }

  public ArrayList<Ant> remove(int _qty_ants) {
    int ants_to_remove=0;
    if (_qty_ants > this.ants.size() ) {
      ants_to_remove=this.ants.size();
    } else {
      ants_to_remove = _qty_ants;
    }
    for (int i = this.ants.size()-1; i >= this.ants.size()-ants_to_remove; i--) {
      this.ants.remove(new Ant());
    }
    return this.ants;
  }

  public ArrayList<Ant> remove(Ant _which_ant) {
    this.ants.remove(_which_ant);
    return this.ants;
  }

  public ArrayList<Ant> remove() {
    if (this.ants.size() > 0) this.ants.remove(this.ants.size()-1);
    return this.ants;
  }
}

public class Ant { 
  private int x;
  private int y;
  private int orientation; // 0 = UP, 1 = RIGHT, 2 = DOWN, 3 = LEFT

  public Ant (int _x, int _y, int _orientation) {
    this.x = _x;
    this.y = _y;  
    this.orientation = _orientation;
  }

  public Ant (int _x, int _y) {
    this.x = _x;
    this.y = _y;  
    this.orientation = 0;
  }

  public Ant () {
    this.x = int(random(states_w));
    this.y = int(random(states_h));  
    this.orientation = int(random(4));
  }

  public void update(int[][] _states, BitSet _rules) {

    int direction = int(_rules.get(_states[this.x][this.y]));

    if (direction == 1) {
      this.orientation++;
    } else {
      this.orientation--;
    }

    this.orientation = (this.orientation + 4) % 4;

    switch(this.orientation) {
    case 0:
      this.y--;
      break;
    case 1:
      this.x++;
      break;
    case 2:
      this.y++;
      break;
    case 3:
      this.x--;
      break;
    }

    // wrap around
    this.x = (this.x + _states.length) % _states.length;
    this.y = (this.y + _states[0].length) % _states[0].length;
  }

  public int getX() {
    return this.x;
  }

  public int getY() {
    return this.y;
  }

  public int getOrientation() {
    return this.orientation;
  }

  public void setX(int _x) {
    this.x = _x;
  }

  public void setY(int _y) {
    this.y = _y;
  }

  public void setOrientation(int _orientation) {
    this.orientation = _orientation;
  }
}
