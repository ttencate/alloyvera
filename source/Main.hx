import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import openfl.display.Sprite;

class Main extends Sprite {
  public function new() {
    super();

#if neko
    var level = Std.parseInt(Sys.environment()["level"]);
    if (level > 0 && level <= Levels.ALL.length) {
      PlayState.currentLevel = level - 1;
    }
#end

    addChild(new FlxGame(320, 200, PlayState, true));
    FlxG.scaleMode = new PixelPerfectScaleMode();
#if neko
    FlxG.plugins.add(new DebugKeys());
#end
  }
}

private class DebugKeys extends FlxBasic {
  override public function update(elapsed: Float) {
    super.update(elapsed);

    if (FlxG.keys.pressed.ESCAPE) {
      Sys.exit(0);
    }
  }
}
