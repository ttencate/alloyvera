class Beaker {

  public var size(default, null): Int;
  public var content: Alloy;

  public var fillFraction(get, never): Float;

  public function new(size: Int, ?content: Alloy) {
    if (content == null) content = new Alloy();
    this.size = size;
    this.content = content;
  }

  public function clone() {
    return new Beaker(size, content.clone());
  }

  public function pour(into: Beaker) {
    var amount = Math.min(into.size - into.content.amount, this.content.amount);
    var alloy = content.take(amount);
    into.content.add(alloy);
  }

  public function toString() {
    return '$size($content)';
  }

  private function get_fillFraction() { return content.amount / size; }
}
