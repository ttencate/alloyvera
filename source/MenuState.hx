import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

class MenuState extends FlxState {

  private var alloy: Alloy;
  private var beaker: Beaker;
  private var mixium = new Metal("MIXIUM", 0xffff0000);
  private var beakerSprite: BeakerSprite;
  private var hue: Float = 0.0;

  override public function create() {
    super.create();

    add(new FlxSprite(AssetPaths.background__png));

    alloy = new Alloy().set(mixium, 1e-3);
    beaker = new Beaker(15, alloy);
    beakerSprite = new BeakerSprite(beaker);
    beakerSprite.x = (FlxG.width - beakerSprite.width) / 2;
    beakerSprite.y = (FlxG.height - beakerSprite.height) / 2;
    beakerSprite.scaleLabel(2);
    add(beakerSprite);

    FlxTween.tween(beakerSprite, {fillFraction: 1}, 5.0, {ease: FlxEase.sineInOut});

    var text = new FlxText("A game by @frozenfractal for the 1st Alakajam! Solo competition");
    text.setFormat(AssetPaths.PixeligCursief__ttf, 10, FlxColor.WHITE);
    text.alpha = 0.5;
    text.x = (FlxG.width - text.width) / 2;
    text.y = FlxG.height - text.height - 8;
    add(text);
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);

    hue += 45 * elapsed;
    beakerSprite.color = FlxColor.fromHSB(hue % 360, 1.0, 1.0);

    if (FlxG.mouse.justPressed && beakerSprite.containsPoint(FlxG.mouse.x, FlxG.mouse.y)) {
      FlxG.switchState(new PlayState());
    }
  }
}
