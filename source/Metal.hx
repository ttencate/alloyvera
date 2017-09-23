import flixel.util.FlxColor;

class Metal {

  public static var IRON = new Metal("iron", FlxColor.RED);
  public static var ZINC = new Metal("zinc", FlxColor.GREEN);
  public static var COPPER = new Metal("copper", FlxColor.YELLOW);

  public var name(default, null): String;
  public var color(default, null): FlxColor;

  private function new(name: String, color: FlxColor) {
    this.name = name;
    this.color = color;
  }

  public function toString() {
    return name;
  }
}
