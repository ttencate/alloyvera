class Fraction {

  public var numerator(default, null): Int;
  public var denominator(default, null): Int;

  public function new(numerator: Int, denominator: Int = 1) {
    this.numerator = numerator;
    this.denominator = denominator;
    simplify();
  }

  public function add(other: Fraction) {
    return new Fraction(this.numerator * other.denominator + other.numerator * this.denominator, this.denominator * other.denominator);
  }

  public function sub(other: Fraction) {
    return new Fraction(this.numerator * other.denominator - other.numerator * this.denominator, this.denominator * other.denominator);
  }

  public function mul(other: Fraction) {
    return new Fraction(this.numerator * other.numerator, this.denominator * other.denominator);
  }

  public function div(other: Fraction) {
    return new Fraction(this.numerator * other.denominator, this.denominator * other.numerator);
  }

  public function min(other: Fraction) {
    return lessThan(other) ? this : other;
  }

  public function lessThan(other: Fraction) {
    return this.numerator * other.denominator < other.numerator * this.denominator;
  }

  public function toFloat() {
    return numerator / denominator;
  }

  public function toString() {
    if (denominator == 1) {
      return '${numerator}';
    } else {
      return '${numerator}/${denominator}';
    }
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
