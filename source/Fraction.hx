abstract Fraction(Impl) {

  public function new(numerator: Int, denominator: Int = 1) {
    this = new Impl(numerator, denominator);
  }

  public function add(other: Fraction) {
    var a = cast(this, Impl);
    var b = cast(other, Impl);
    return new Fraction(a.numerator * b.denominator + a.numerator * b.denominator, a.denominator * b.denominator);
  }

  public function toString() {
    if (this.denominator == 1) {
      return '${this.numerator}';
    } else {
      return '${this.numerator}/${this.denominator}';
    }
  }
}

private class Impl {

  public var numerator(default, null): Int;
  public var denominator(default, null): Int;

  public function new(numerator: Int, denominator: Int = 1) {
    this.numerator = numerator;
    this.denominator = denominator;
    simplify();
  }

  private function simplify() {
    var a = numerator;
    var b = denominator;
    while (b != 0) {
      var t = b;
      b = a % b;
      a = t;
    }
    var gcd = a;

    numerator = Std.int(numerator / gcd);
    denominator = Std.int(denominator / gcd);
  }

}
