class State {

  public var beakers: Array<Beaker>;

  public function new(?beakers: Array<Beaker>) {
    if (beakers == null) beakers = [];
    this.beakers = beakers;
  }

  public function toString() {
    var out = "";
    for (beaker in beakers) {
      if (out.length > 0) {
        out += ", ";
      }
      out += '$beaker';
    }
    return out;
  }
}
