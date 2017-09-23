class Beaker {

  public var size(default, null): Int;
  public var content: Alloy;

  public function new(size: Int, ?content: Alloy) {
    if (content == null) content = new Alloy();
    this.size = size;
    this.content = content;
  }

  public function clone() {
    return new Beaker(size, content.clone());
  }

  public function pour(into: Beaker) {
    var amount = new Fraction(into.size).sub(into.content.amount).min(this.content.amount);
    var alloy = content.take(amount);
    trace(amount, alloy);
    into.content.add(alloy);
  }

  public function toString() {
    return '$size($content)';
  }
}
