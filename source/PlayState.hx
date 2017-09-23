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

  private var state: State;
  private var beakerSprites: FlxTypedGroup<BeakerSprite>;
  private var selectedBeaker: BeakerSprite;
  private var pouring = false;
  private var over = false;

  override public function create() {
    super.create();

    level = Levels.ALL[currentLevel];
    state = level.startState.clone();

    add(beakerSprites = new FlxTypedGroup<BeakerSprite>());
    addBeakerSprites(state.beakers);
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

    var hovered: BeakerSprite = null;
    for (beakerSprite in beakerSprites) {
      var contains = beakerSprite.containsPoint(FlxG.mouse.x, FlxG.mouse.y);
      beakerSprite.hovered = !pouring && !over && (beakerSprite == selectedBeaker || contains);
      if (contains) {
        hovered = beakerSprite;
      }
    }

    if (FlxG.mouse.justPressed && hovered != null && !pouring) {
      if (selectedBeaker == null) {
        selectedBeaker = hovered;
      } else {
        if (hovered == selectedBeaker) {
          selectedBeaker = null;
        } else {
          pour(selectedBeaker, hovered);
          selectedBeaker = null;
        }
      }
    }
  }

  private function pour(from: BeakerSprite, to: BeakerSprite) {
    pouring = true;
    trace("Before", state);
    from.beaker.pour(to.beaker);
    trace("After", state);
    from.redraw();
    to.redraw();
    endPour();
  }

  private function endPour() {
    pouring = false;
    checkWin();
  }

  private function checkWin() {
    trace(state.beakers[level.targetBeaker].content, level.targetAlloy);
    if (state.beakers[level.targetBeaker].content.equals(level.targetAlloy)) {
      trace("WIN");
      over = true;
    }
  }
}
