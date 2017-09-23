class Goal {
  public var alloy(default, null): Alloy;

  public function new(alloy: Alloy) {
    this.alloy = alloy;
  }

  public function isComplete(state: State) {
    for (beaker in state.beakers) {
      if (beaker.content.amount > 1e-4 && beaker.content.equalsIgnoringAmount(alloy)) {
        return true;
      }
    }
    return false;
  }
}
