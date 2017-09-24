import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Book extends FlxGroup {
  public function new(contents: String, startDelay: Float) {
    super();
    var book = new FlxSprite(AssetPaths.book__png);
    book.screenCenter();
    var targetY = book.y;
    book.y = FlxG.height;
    FlxTween.tween(book, {y: targetY}, 1.0, {startDelay: startDelay, ease: FlxEase.quadOut});
    add(book);

    var text = new FlxText(FlxG.width / 2 + 20, targetY + 30, 110, contents);
    text.setFormat(AssetPaths.PixeligCursief__ttf, 10, 0xff191713);
    text.alpha = 0;
    FlxTween.tween(text, {alpha: 1}, 1.0, {startDelay: startDelay + 1.0});
    add(text);
  }
}
