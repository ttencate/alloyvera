import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

import openfl.display.BitmapData;
import openfl.geom.Point;
import openfl.geom.Rectangle;

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
  public var selected(default, set): Bool = false;
  public var fillFraction(default, set): Float = 0.0;
  public var color(get, set): FlxColor;

  private var contentMask: FlxSprite;

  private var content: FlxSprite;
  private var glass: FlxSprite;

  public function new(beaker: Beaker) {
    super();
    this.beaker = beaker;
    computeSize();

    contentMask = new FlxSprite();
    contentMask.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
    drawContentMask();

    add(content = new FlxSprite());
    content.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);

    add(glass = new FlxSprite());
    glass.makeGraphic(Std.int(width), Std.int(height), FlxColor.TRANSPARENT, true);
    drawGlass();

    fillFraction = beaker.fillFraction;
    color = beaker.content.color;
    drawContent();
  }

  private function drawContentMask() {
    var inputSprite = new FlxSprite(AssetPaths.content_mask__png);
    ninePatch(inputSprite.graphic.bitmap, contentMask.graphic.bitmap);
    contentMask.drawRect(16, 16, width - 32, height - 32, FlxColor.WHITE);
  }

  private function drawContent() {
    var y = Math.round(8 + (height - 9) * (1 - fillFraction));
    content.graphic.bitmap.fillRect(new Rectangle(0, 0, width, height), FlxColor.TRANSPARENT);
    content.graphic.bitmap.copyPixels(contentMask.graphic.bitmap, new Rectangle(0, y, width, height - y), new Point(0, y));
  }

  private function drawGlass() {
    var inputSprite = new FlxSprite(AssetPaths.beaker__png);
    ninePatch(inputSprite.graphic.bitmap, glass.graphic.bitmap);

    var text = new FlxText('${beaker.size}', 8);
    text.setFormat(AssetPaths.PixeligCursief__ttf, 10);
    glass.stamp(text, Math.round(0.5 * (glass.width - text.width)), 6);

    var pureMetal = beaker.content.pureMetal();
    if (pureMetal != null) {
      text.text = pureMetal.name;
      text.color = FlxColor.BLACK;
      var x = Math.round(0.5 * (glass.width - text.width + 2));
      var y = Math.round(0.5 * (glass.height - text.height));
      glass.drawRect(x, y, text.width - 2, text.height, FlxColor.WHITE);
      glass.stamp(text, x, y);
    }

    text.destroy();
  }

  private function ninePatch(input: BitmapData, output: BitmapData) {
    var w = output.width;
    var h = output.height;
    output.copyPixels(input, new Rectangle(0, 0, 16, 16), new Point(0, 0));
    output.copyPixels(input, new Rectangle(48, 0, 16, 16), new Point(w - 16, 0));
    output.copyPixels(input, new Rectangle(0, 48, 16, 16), new Point(0, h - 16));
    output.copyPixels(input, new Rectangle(48, 48, 16, 16), new Point(w - 16, h - 16));
    for (x in 0...Std.int(width / LITER_WIDTH - 1)) {
      output.copyPixels(input, new Rectangle(16, 0, 32, 16), new Point(16 + x * 32, 0));
      output.copyPixels(input, new Rectangle(16, 48, 32, 16), new Point(16 + x * 32, h - 16));
    }
    for (y in 0...Std.int(height / LITER_HEIGHT - 1)) {
      output.copyPixels(input, new Rectangle(0, 16, 16, 32), new Point(0, 16 + y * 32));
      output.copyPixels(input, new Rectangle(48, 16, 16, 32), new Point(w - 16, 16 + y * 32));
    }
  }

  public function containsPoint(x: Float, y: Float) {
    return x >= this.x && x < this.x + this.width && y >= this.y && y < this.y + this.height;
  }

  public function pour(into: BeakerSprite, onComplete: Void -> Void) {
    if (!this.beaker.pour(into.beaker)) {
      return false;
    }
    this.animate(onComplete);
    into.animate();
    return true;
  }

  private function animate(?onComplete: Void -> Void) {
    var duration = 1.0;
    FlxTween.tween(this, {fillFraction: beaker.fillFraction}, duration, {
      ease: FlxEase.sineInOut,
      onComplete: onComplete == null ? null : function(_) { onComplete(); },
    });
    if (fillFraction == 0) {
      color = beaker.content.color;
    } else if (beaker.fillFraction != 0) {
      FlxTween.color(content, duration, content.color, beaker.content.color, {ease: FlxEase.sineInOut});
    }
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

  private var glassTween: FlxTween;
  private var contentTween: FlxTween;

  private function set_hovered(hovered: Bool): Bool {
    return this.hovered = hovered;
  }

  private function set_selected(selected: Bool): Bool {
    if (this.selected != selected) {
      var y = selected ? HOVER_OFFSET_Y : 0;
      if (glassTween != null) glassTween.cancel();
      if (contentTween != null) contentTween.cancel();
      glassTween = FlxTween.tween(glass.offset, {y: y}, 0.2, {ease: FlxEase.quadOut});
      contentTween = FlxTween.tween(content.offset, {y: y}, 0.2, {ease: FlxEase.quadOut});
    }
    return this.selected = selected;
  }

  private function set_fillFraction(fillFraction: Float) {
    this.fillFraction = fillFraction;
    drawContent();
    return fillFraction;
  }

  private function get_color() { return content.color; }

  private function set_color(color: FlxColor) { return content.color = color; }
}
