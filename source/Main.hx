import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite {
  public function new() {
    super();
    addChild(new FlxGame(320, 200, PlayState, true));
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
