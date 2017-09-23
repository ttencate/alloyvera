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

  public function add(metal: Metal, amount: Fraction) {
    var i = findOrAdd(metal);
    amounts[i] = amounts[i].add(amount);
    return this;
  }

  public function set(metal: Metal, amount: Int) {
    amounts[findOrAdd(metal)] = new Fraction(amount);
    return this;
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
