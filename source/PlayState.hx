import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.ui.FlxUIButton;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PlayState extends FlxState {

  public static var currentLevel = 0;

  private static inline var BEAKER_BOTTOM_Y = 300 - 54;
  private static inline var BEAKER_SEPARATION = 8;

  private var level: Level;

  private var state: State;
  private var beakerSprites: FlxTypedGroup<BeakerSprite>;
  private var selectedBeaker: BeakerSprite;
  private var pouring = false;
  private var over = false;

  private var musicButton: FlxUIButton;

  override public function create() {
    super.create();

    level = Levels.ALL[currentLevel];
    state = level.startState.clone();

    add(new FlxSprite(AssetPaths.background__png));

    var instructions = new FlxText(level.instructions);
    instructions.setFormat(AssetPaths.PixeligCursief__ttf, 10, FlxColor.WHITE);
    instructions.x = (FlxG.width - instructions.width) / 2;
    instructions.y = 0;
    add(instructions);

    add(beakerSprites = new FlxTypedGroup<BeakerSprite>());
    addBeakerSprites(state.beakers);

    var uiGroup = new FlxGroup();
    add(uiGroup);

    var restartButton = new FlxUIButton(0, 0, "Restart", restart, true);
    restartButton.x = 0.5 * (FlxG.width - restartButton.width);
    restartButton.y = FlxG.height - restartButton.height - 4;
    uiGroup.add(restartButton);

    musicButton = new FlxUIButton(0, 0, "Music", toggleMusic, true);
    musicButton.x = FlxG.width - musicButton.width - 4;
    musicButton.y = FlxG.height - musicButton.height - 4;
    musicButton.has_toggle = true;
    musicButton.toggled = !FlxG.sound.muted;
    uiGroup.add(musicButton);
  }

  private function toggleMusic() {
    FlxG.sound.toggleMuted();
    musicButton.toggled = !FlxG.sound.muted;
    FlxG.save.data.music = musicButton.toggled;
    FlxG.save.flush();
  }

  private function restart() {
    FlxG.switchState(new PlayState());
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
      if (contains && !pouring && !over) {
        hovered = beakerSprite;
      }
    }

    if (FlxG.mouse.justPressed && hovered != null && !pouring) {
      if (selectedBeaker == null) {
        selectedBeaker = hovered;
        selectedBeaker.selected = true;
      } else {
        if (hovered == selectedBeaker) {
          selectedBeaker.selected = false;
          selectedBeaker = null;
        } else {
          pour(selectedBeaker, hovered);
          selectedBeaker.selected = false;
          selectedBeaker = null;
        }
      }
    }

    if (over && FlxG.mouse.justPressed) {
      if (currentLevel + 1 < Levels.COUNT) {
        currentLevel++;
        FlxG.switchState(new PlayState());
      }
    }
  }

  private function pour(from: BeakerSprite, to: BeakerSprite) {
    if (from.pour(to, endPour)) {
      pouring = true;
    }
  }

  private function endPour() {
    pouring = false;
    checkWin();
  }

  private function checkWin() {
    trace(state);
    if (!level.goal.isComplete(state)) {
      return;
    }
    trace('Won level $currentLevel');
    over = true;

    var beaker = beakerSprites.members[level.goal.beakerIndex(state)];
    beaker.poof();

    add(new Book(level.completionText, 1.0));

    var item = new FlxSprite();
    item.loadGraphic(AssetPaths.items__png, true, 16, 16);
    item.animation.add("item", [level.itemIndex]);
    item.animation.play("item");
    item.scale.set(4, 4);
    item.x = beaker.x + beaker.width / 2 - item.scale.x * item.width / 2;
    item.y = beaker.y + beaker.height / 2 - item.scale.y * item.height / 2;
    FlxTween.tween(item, {
          x: FlxG.width / 2 - 20 - 110 / 2 - item.width / 2,
          y: FlxG.height / 2 - item.height / 2
        }, 2.0, {
          ease: FlxEase.quadInOut,
        });
    item.scale.set(1, 1);
    FlxTween.tween(item.scale, {x: 4, y: 4}, 2.0, {ease: FlxEase.backOut});
    add(item);

    var overlay = new FlxSprite();
    overlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE, true);
    FlxTween.tween(overlay, {alpha: 0}, 0.3, {
      ease: FlxEase.quadOut,
      onComplete: function(_) {
        remove(overlay);
        overlay.destroy();
      },
    });
    add(overlay);
  }
}
