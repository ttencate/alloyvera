class Goal {
  public var beakerIndex(default, null): Int;
  public var alloy(default, null): Alloy;

  public function new(beakerIndex: Int, alloy: Alloy) {
    this.beakerIndex = beakerIndex;
    this.alloy = alloy;
  }

  public function isComplete(state: State) {
    return state.beakers[beakerIndex].content.equals(alloy);
  }
}
