class Goal {
  public var alloy(default, null): Alloy;

  public function new(alloy: Alloy) {
    this.alloy = alloy;
  }

  public function isComplete(state: State) {
    return beakerIndex(state) >= 0;
  }

  public function beakerIndex(state: State): Int {
    for (i in 0...state.beakers.length) {
      var beaker = state.beakers[i];
      if (beaker.content.amount > 1e-4 && beaker.content.equalsIgnoringAmount(alloy)) {
        return i;
      }
    }
    return -1;
  }

  public function toString() {
    return alloy.toLines();
  }
}
