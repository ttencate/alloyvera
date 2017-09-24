import flixel.FlxSprite;

class Bubble extends FlxSprite {

  public var speed: Float = 20.0;
  public var amplitude: Float = 2.0;
  public var period: Float = 1.0;
  public var baseX: Float = 0.0;

  private var time: Float = 0.0;

  public function new() {
    super(AssetPaths.bubble__png);
  }

  override public function revive() {
    super.revive();
    time = 0;
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);
    time += elapsed;
    x = baseX + amplitude * Math.sin(time * 2 * Math.PI / period);
    y -= elapsed * speed;
  }
}
