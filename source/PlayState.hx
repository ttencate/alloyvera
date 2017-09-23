import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState {

  public static var currentLevel = 0;

  private static inline var BEAKER_BOTTOM_Y = 184;
  private static inline var BEAKER_SEPARATION = 8;

  private var level: Level;
  private var beakerSprites: FlxTypedGroup<BeakerSprite>;

  override public function create() {
    super.create();

    level = Levels.ALL[currentLevel];

    add(beakerSprites = new FlxTypedGroup<BeakerSprite>());
    addBeakerSprites(level.startState.beakers);
  }

  private function addBeakerSprites(beakers: Array<Beaker>) {
    var numBeakers = beakers.length;
    var totalWidth = 0.0;
    for (beaker in beakers) {
      var sprite = new BeakerSprite(beaker);
      beakerSprites.add(sprite);
      totalWidth += sprite.width;
    }

    var x = Math.round((FlxG.width - (numBeakers - 1) * BEAKER_SEPARATION - totalWidth) / 2) + 0.0;
    for (beakerSprite in beakerSprites) {
      beakerSprite.x = x;
      beakerSprite.y = BEAKER_BOTTOM_Y - beakerSprite.height;
      x += beakerSprite.width + BEAKER_SEPARATION;
    }
  }

  override public function update(elapsed: Float) {
    super.update(elapsed);
  }
}
