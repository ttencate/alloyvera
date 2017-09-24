import flixel.FlxG;
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

  private static inline var SELECTED_OFFSET_Y = 8;

  private static inline var PADDING_TOP = 8;
  private static inline var PADDING_BOTTOM = 1;
  private static inline var PADDING_SIDE = 1;

  public var beaker(default, null): Beaker;
  public var width(default, null): Float;
  public var height(default, null): Float;
  public var x(default, set): Float;
  public var y(default, set): Float;
  public var hovered(default, set): Bool = false;
  public var selected(default, set): Bool = false;
  public var fillFraction(default, set): Float = 0.0;
  public var color(get, set): FlxColor;

  private var contentMask: FlxSprite;

  private var content: FlxSprite;
  private var glass: FlxSprite;
  private var bubbles: FlxTypedGroup<Bubble>;
  private var labelGroup: FlxGroup;
  private var label: FlxSprite;
  private var text: FlxText;

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

    add(bubbles = new FlxTypedGroup<Bubble>());

    add(labelGroup = new FlxGroup());
    drawLabel();
  }

  private function drawContentMask() {
    var inputSprite = new FlxSprite(AssetPaths.content_mask__png);
    ninePatch(inputSprite.graphic.bitmap, contentMask.graphic.bitmap);
    contentMask.drawRect(16, 16, width - 32, height - 32, FlxColor.WHITE);
  }

  private function drawContent() {
    var y = Math.round(PADDING_TOP + (height - PADDING_TOP - PADDING_BOTTOM) * (1 - fillFraction));
    content.graphic.bitmap.fillRect(new Rectangle(0, 0, width, height), FlxColor.TRANSPARENT);
    content.graphic.bitmap.copyPixels(contentMask.graphic.bitmap, new Rectangle(0, y, width, height - y), new Point(0, y));
  }

  private function drawGlass() {
    var inputSprite = new FlxSprite(AssetPaths.beaker__png);
    ninePatch(inputSprite.graphic.bitmap, glass.graphic.bitmap);

    var text = new FlxText('${beaker.size}', 8);
    text.setFormat(AssetPaths.PixeligCursief__ttf, 10);
    glass.stamp(text, Math.round(0.5 * (glass.width - text.width)), 6);
    text.destroy();
  }

  private function drawLabel() {
    var pureMetal = beaker.content.pureMetal();
    if (pureMetal != null) {
      text = new FlxText(pureMetal.name, 8);
      text.setFormat(AssetPaths.PixeligCursief__ttf, 10);
      text.text = pureMetal.name;
      text.color = FlxColor.BLACK;
      var w = Std.int(text.width - 2);
      var h = Std.int(text.height);
      text.offset.x = -0.5 * (glass.width - w);
      text.offset.y = -0.5 * (glass.height - h);

      label = new FlxSprite(text.x, text.y);
      label.makeGraphic(w, h, FlxColor.WHITE);
      label.offset.x = text.offset.x;
      label.offset.y = text.offset.y;

      labelGroup.add(label);
      labelGroup.add(text);
    }
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

  public function poof() {
    var numParticles = Math.round(beaker.content.amount * 10);
    for (i in 0...numParticles) {
      var particle = new FlxSprite();
      particle.loadGraphic(AssetPaths.poof__png, true, 15, 15);
      particle.x = FlxG.random.float(x + PADDING_SIDE, x + width - particle.width - PADDING_SIDE);
      particle.y = FlxG.random.float(y + PADDING_TOP + (height - PADDING_TOP - PADDING_BOTTOM) * (1 - fillFraction), y + height - PADDING_BOTTOM - particle.height);
      particle.velocity.x = FlxG.random.float(-50, 50);
      particle.velocity.y = FlxG.random.float(-50, 50);
      particle.animation.add("poof", [0, 1, 2, 3], 3, false);
      particle.animation.play("poof");
      particle.animation.finishCallback = function(_) {
        remove(particle);
        particle.destroy();
      };
      add(particle);
    }
    fillFraction = 0;
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);

    var desiredBubbles = Math.round(beaker.content.amount * 5);
    if (bubbles.countLiving() < desiredBubbles && FlxG.random.bool(10)) {
      addBubble();
    }
    bubbles.forEachAlive(function(bubble) {
      if (bubble.y < y + PADDING_TOP + (height - PADDING_TOP - PADDING_BOTTOM) * (1 - fillFraction) - bubble.height / 2 + 1) {
        bubble.kill();
      }
    });
  }

  private function addBubble() {
    var bubble = bubbles.getFirstDead();
    if (bubble == null) {
      bubble = new Bubble();
      bubbles.add(bubble);
    } else {
      bubble.revive();
    }

    bubble.speed = FlxG.random.float(15, 30);
    bubble.amplitude = FlxG.random.float(0, 3);
    bubble.baseX = FlxG.random.float(x + PADDING_SIDE + bubble.width + bubble.amplitude, x + width - PADDING_SIDE - bubble.width - bubble.amplitude);
    bubble.y = FlxG.random.float(y + PADDING_TOP + (height - PADDING_TOP - PADDING_BOTTOM) * (1 - fillFraction), y + height - PADDING_BOTTOM - bubble.height);
    bubble.update(0);
    bubble.alpha = 0;
    FlxTween.tween(bubble, {alpha: 0.5}, 0.2);
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

  private function set_x(x: Float): Float {
    this.x = x;
    updateX();
    return x;
  }

  private function set_y(y: Float): Float {
    this.y = y;
    updateY();
    return y;
  }

  private var tween: FlxTween;

  private function set_hovered(hovered: Bool): Bool {
    return this.hovered = hovered;
  }

  private function set_selected(selected: Bool): Bool {
    if (this.selected != selected) {
      var y = selected ? -SELECTED_OFFSET_Y : 0;
      if (tween != null) tween.cancel();
      tween = FlxTween.tween(this, {offsetY: y}, 0.2, {ease: FlxEase.quadOut});
    }
    return this.selected = selected;
  }

  public var offsetY(default, set): Float = 0.0;

  private function set_offsetY(offsetY: Float) {
    this.offsetY = offsetY;
    updateY();
    return offsetY;
  }

  private function updateX() {
    if (label != null) label.x = x;
    if (text != null) text.x = x;
    glass.x = content.x = x;
  }

  private function updateY() {
    glass.y = y + offsetY;
    content.y = y + offsetY;
    if (label != null) label.y = y + offsetY;
    if (text != null) text.y = y + offsetY;
  }

  private function set_fillFraction(fillFraction: Float) {
    this.fillFraction = fillFraction;
    drawContent();
    return fillFraction;
  }

  private function get_color() { return content.color; }

  private function set_color(color: FlxColor) { return content.color = color; }
}
