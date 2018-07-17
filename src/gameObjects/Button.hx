package gameObjects;
import flixel.ui.FlxButton;

/**
 * ...
 * @author 
 */
class Button 
{
	public var btn:FlxButton;
	public var image:String;
	public var imageHover:String;
	public var imageClicked:String;
	

	public function new(posX:Int, posY:Int, img:String, imgHover:String, imgClicked:String) 
	{
		this.image = img;
		this.imageHover = imgHover;
		this.imageClicked = imgClicked;
		this.btn = new FlxButton(posX, posY);
		this.btn.loadGraphic(img);
		this.btn.onOver.callback = btnHover;
		this.btn.onOut.callback = btnOnOut;
		this.btn.onDown.callback = btnClicked;
	}
	
	private function btnHover():Void
	{
		this.btn.loadGraphic(imageHover);
	}
	
	private function btnOnOut():Void
	{
		this.btn.loadGraphic(image);
	}
	
	private function btnClicked():Void
	{
		this.btn.loadGraphic(imageClicked);
	}
}