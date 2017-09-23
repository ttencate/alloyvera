import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class BeakerSprite extends FlxGroup {

  private static inline var LITER_WIDTH = 32;
  private static inline var LITER_HEIGHT = 32;

  private static inline var HOVER_OFFSET_Y = 4;

  public var beaker(default, null): Beaker;
  public var width(default, null): Float;
  public var height(default, null): Float;
  public var x(get, set): Float;
  public var y(get, set): Float;
  public var hovered(default, set): Bool = false;

  private var content: FlxSprite;
  private var glass: FlxSprite;

  public function new(beaker: Beaker) {
    super();
    this.beaker = beaker;
    computeSize();

    add(content = new FlxSprite());
    content.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
    drawContent();

    add(glass = new FlxSprite());
    glass.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
    drawGlass();
  }

  private function drawContent() {
    content.graphic.bitmap.fillRect(new openfl.geom.Rectangle(0, 0, width, height), FlxColor.TRANSPARENT);
    var h = Math.round(content.height * beaker.content.amount / beaker.size);
    content.drawRect(0, content.height - h, content.width, h, beaker.content.color);
  }

  private function drawGlass() {
    glass.drawRect(0.5, 0.5, width - 1.5, height - 1.5, FlxColor.TRANSPARENT, {thickness: 1, color: FlxColor.WHITE});
  }

  public function containsPoint(x: Float, y: Float) {
    return x >= this.x && x < this.x + this.width && y >= this.y && y < this.y + this.height;
  }

  public function redraw() {
    drawContent();
  }

  private function computeSize() {
    var size = beaker.size;
    for (w in 1...(size + 1)) {
      if (w * w > size) {
        break;
      }
      if (size % w == 0) {
        width = LITER_WIDTH * w;
        height = LITER_HEIGHT * Std.int(size / w);
      }
    }
  }

  private function get_x(): Float { return glass.x; }

  private function get_y(): Float { return glass.y; }

  private function set_x(x: Float): Float {
    return glass.x = content.x = x;
  }

  private function set_y(y: Float): Float {
    return glass.y = content.y = y;
  }

  private function set_hovered(hovered: Bool): Bool {
    if (this.hovered != hovered) {
      var y = hovered ? HOVER_OFFSET_Y : 0;
      FlxTween.tween(glass.offset, {y: y}, 0.2, {ease: FlxEase.quadOut});
      FlxTween.tween(content.offset, {y: y}, 0.2, {ease: FlxEase.quadOut});
    }
    return this.hovered = hovered;
  }
}
