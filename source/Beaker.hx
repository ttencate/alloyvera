class Beaker {

  public var size(default, null): Int;
  public var content: Alloy;

  public function new(size: Int, ?content: Alloy) {
    if (content == null) content = new Alloy();
    this.size = size;
    this.content = content;
  }

  public function toString() {
    return '$size($content)';
  }
}
