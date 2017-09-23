import flixel.util.FlxColor;

class Alloy {

  public var amount(get, never): Fraction;
  public var color(get, never): FlxColor;

  // Using Map<Metal, Fraction> gives crashes:
  // Uncaught exception - Invalid operation (+)
  // Weird Haxe.
  private var metals: Array<Metal> = [];
  private var amounts: Array<Fraction> = [];

  public function new() {
  }

  public function clone() {
    return new Alloy().add(this);
  }

  public function add(other: Alloy) {
    for (i in 0...other.metals.length) {
      var metal = other.metals[i];
      var amount = other.amounts[i];
      var j = findOrAdd(metal);
      amounts[j] = amounts[j].add(amount);
    }
    return this;
  }

  public function set(metal: Metal, amount: Int) {
    return setFraction(metal, new Fraction(amount));
  }

  public function setFraction(metal: Metal, amount: Fraction) {
    amounts[findOrAdd(metal)] = amount;
    return this;
  }

  public function take(amount: Fraction) {
    var f = amount.div(this.amount);
    var taken = new Alloy();
    for (i in 0...metals.length) {
      var metal = metals[i];
      var amount = amounts[i];
      var takeAmount = amount.mul(f);
      taken.setFraction(metal, takeAmount);
      amounts[i] = amounts[i].sub(takeAmount);
    }
    return taken;
  }

  private function findOrAdd(metal: Metal) {
    for (i in 0...metals.length) {
      if (metals[i] == metal) return i;
    }
    metals.push(metal);
    amounts.push(new Fraction(0));
    return metals.length - 1;
  }

  private function get_amount() {
    var amount = new Fraction(0);
    for (fraction in amounts) {
      amount = amount.add(fraction);
    }
    return amount;
  }

  private function get_color() {
    var r = 0.0;
    var g = 0.0;
    var b = 0.0;
    var sum = 0.0;
    for (i in 0...metals.length) {
      var f = amounts[i].toFloat();
      var c = metals[i].color;
      r += f * c.redFloat;
      g += f * c.greenFloat;
      b += f * c.blueFloat;
      sum += f;
    }
    return FlxColor.fromRGBFloat(r / sum, g / sum, b / sum);
  }

  public function toString() {
    var out = "";
    for (i in 0...metals.length) {
      if (out.length > 0) {
        out += ", ";
      }
      out += '${amounts[i]} ${metals[i]}';
    }
    return out;
  }
}
