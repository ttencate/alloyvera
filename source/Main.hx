import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.scaleModes.PixelPerfectScaleMode;
import openfl.display.Sprite;

class Main extends Sprite {
  public function new() {
    super();

    Levels.init();

#if neko
    var level = Std.parseInt(Sys.environment()["level"]);
    if (level > 0 && level <= Levels.ALL.length) {
      PlayState.currentLevel = level - 1;
    }
#end

    addChild(new FlxGame(480, 300, null, true));
    FlxG.scaleMode = new PixelPerfectScaleMode();
    FlxG.signals.stateSwitched.add(function() {
      FlxG.camera.pixelPerfectRender = true;
    });
    FlxG.autoPause = false;
    loadSettings();
#if neko
    FlxG.plugins.add(new DebugKeys());
#end
    FlxG.switchState(new PlayState());
    FlxG.sound.playMusic(AssetPaths.AlloyVera__ogg, 0.2);
  }

  private function loadSettings() {
    FlxG.sound.muted = (FlxG.save.data.music == false);
  }
}

#if neko
private class DebugKeys extends FlxBasic {
  override public function update(elapsed: Float) {
    super.update(elapsed);

    if (FlxG.keys.pressed.ESCAPE) {
      Sys.exit(0);
    }
    if (FlxG.keys.pressed.UP && PlayState.currentLevel + 1 < Levels.COUNT) {
      PlayState.currentLevel++;
      FlxG.switchState(new PlayState());
    }
    if (FlxG.keys.pressed.DOWN && PlayState.currentLevel > 0) {
      PlayState.currentLevel--;
      FlxG.switchState(new PlayState());
    }
  }
}
#end
