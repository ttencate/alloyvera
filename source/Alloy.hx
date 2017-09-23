class Alloy {

  // Using Map<Metal, Fraction> gives crashes:
  // Uncaught exception - Invalid operation (+)
  // Weird Haxe.
  private var metals: Array<Metal> = [];
  private var fractions: Array<Fraction> = [];

  public function new() {
  }

  public function add(metal: Metal, amount: Fraction) {
    var i = findOrAdd(metal);
    fractions[i] = fractions[i].add(amount);
    return this;
  }

  public function set(metal: Metal, amount: Int) {
    fractions[findOrAdd(metal)] = new Fraction(amount);
    return this;
  }

  private function findOrAdd(metal: Metal) {
    for (i in 0...metals.length) {
      if (metals[i] == metal) return i;
    }
    metals.push(metal);
    fractions.push(new Fraction(0));
    return metals.length - 1;
  }

  public function toString() {
    var out = "";
    for (i in 0...metals.length) {
      if (out.length > 0) {
        out += ", ";
      }
      out += '${fractions[i]} ${metals[i]}';
    }
    return out;
  }
}
