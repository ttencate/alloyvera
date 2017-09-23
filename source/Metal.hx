import flixel.util.FlxColor;

class Metal {

  public static var CRIMSIUM = new Metal("crimsium", 0xff990000);
  public static var LIMIUM = new Metal("limium", 0xffbfff00);
  public static var AMBERIUM = new Metal("amberium", 0xffffbf00);
  public static var BYZANTIUM = new Metal("byzantium", 0xff702963);
  public static var CANARIUM = new Metal("canarium", 0xffffef00);
  public static var CARROTIUM = new Metal("carrotium", 0xffed9121);
  public static var CELESTIUM = new Metal("celestium", 0xff4997d0);
  public static var CYANIUM = new Metal("cyanium", 0xff00ffff);
  public static var FUCHSIUM = new Metal("fuchsium", 0xfff400a1);
  public static var FERRARIUM = new Metal("ferrarium", 0xffff2800);

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
