import flixel.util.FlxColor;

class Metal {

  public var name(default, null): String;
  public var color(default, null): FlxColor;

  public function new(name: String, color: FlxColor) {
    this.name = name;
    this.color = color;
  }

  public function toString() {
    return name;
  }
}
