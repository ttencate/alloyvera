import flixel.util.FlxColor;

class Alloy {

  public var amount(get, never): Float;
  public var color(get, never): FlxColor;

  // Using Map<Metal, Float> gives crashes:
  // Uncaught exception - Invalid operation (+)
  // Weird Haxe.
  private var metals: Array<Metal> = [];
  private var amounts: Array<Float> = [];

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
      amounts[j] += amount;
    }
    return this;
  }

  public function set(metal: Metal, amount: Float) {
    amounts[findOrAdd(metal)] = amount;
    return this;
  }

  public function take(amount: Float) {
    var f = amount / this.amount;
    var taken = new Alloy();
    for (i in 0...metals.length) {
      var metal = metals[i];
      var amount = amounts[i];
      var takeAmount = amount * f;
      taken.set(metal, takeAmount);
      amounts[i] -= takeAmount;
    }
    return taken;
  }

  public function equalsIgnoringAmount(other: Alloy) {
    var thisAmount = this.amount;
    var otherAmount = other.amount;
    trace('Comparing $this ($thisAmount) to $other ($otherAmount)');
    if (thisAmount < 1e-4 || otherAmount < 1e-4) {
      trace('FAIL on one is empty');
      return false;
    }
    for (i in 0...metals.length) {
      var metal = metals[i];
      if (!eq(other.getAmount(metal) / otherAmount, amounts[i] / thisAmount)) {
        trace('FAIL on $metal');
        return false;
      }
    }
    for (i in 0...other.metals.length) {
      var metal = other.metals[i];
      if (!eq(this.getAmount(metal) / thisAmount, other.amounts[i] / otherAmount)) {
        trace('FAIL on $metal');
        return false;
      }
    }
    return true;
  }

  private function eq(a: Float, b: Float) {
    return Math.abs(a - b) < 1e-4;
  }

  public function getAmount(metal: Metal) {
    for (i in 0...metals.length) {
      if (metals[i] == metal) return amounts[i];
    }
    return 0.0;
  }

  private function findOrAdd(metal: Metal) {
    for (i in 0...metals.length) {
      if (metals[i] == metal) return i;
    }
    metals.push(metal);
    amounts.push(0.0);
    return metals.length - 1;
  }

  private function get_amount() {
    var amount = 0.0;
    for (fraction in amounts) {
      amount += fraction;
    }
    return amount;
  }

  private function get_color() {
    var r = 0.0;
    var g = 0.0;
    var b = 0.0;
    var sum = 0.0;
    for (i in 0...metals.length) {
      var f = amounts[i];
      var c = metals[i].color;
      r += f * c.redFloat;
      g += f * c.greenFloat;
      b += f * c.blueFloat;
      sum += f;
    }
    if (sum > 0.0) {
      return FlxColor.fromRGBFloat(r / sum, g / sum, b / sum);
    } else {
      return FlxColor.TRANSPARENT;
    }
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
