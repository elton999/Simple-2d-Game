package umbrellatoolkit;

import umbrellatoolkit.GameObject;
import umbrellatoolkit.helpers.Point;
import kha.Scaler;
import kha.Image;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Color;

@:expose
class Scene {

	public var UI:Array<GameObject> = new Array();
	public var Forenground:Array<GameObject> = new Array();
	public var Player:Array<GameObject> = new Array();
	public var Enemies:Array<GameObject> = new Array();
	public var MiddleGround:Array<GameObject> = new Array();
	public var Background:Array<GameObject> = new Array();
	
	public var BackgroundColor:Color = Color.Blue;
	public var ScreemSize:Point = new Point(960, 540);

	public var _BackBuffer:Image;

	public function new (){
		
	}

	public function Update(deltaTime:Float) : Void{
		for(gameObeject in this.Background) gameObeject.Update(deltaTime);
		for(gameObeject in this.MiddleGround) gameObeject.Update(deltaTime);
		for(gameObeject in this.Enemies) gameObeject.Update(deltaTime);
		for(gameObeject in this.Player) gameObeject.Update(deltaTime);
		for(gameObeject in this.Forenground) gameObeject.Update(deltaTime);
		for(gameObeject in this.UI) gameObeject.Update(deltaTime);
	}


	public function render(framebuffer: Framebuffer): Void{

		this._BackBuffer = Image.createRenderTarget(this.ScreemSize.X, this.ScreemSize.Y);
		var graphics = this._BackBuffer.g2;
		graphics.begin(this.BackgroundColor);
			for(gameObeject in this.Background) gameObeject.render(graphics);
			for(gameObeject in this.MiddleGround) gameObeject.render(graphics);
			for(gameObeject in this.Enemies) gameObeject.render(graphics);
			for(gameObeject in this.Player) gameObeject.render(graphics);
			for(gameObeject in this.Forenground) gameObeject.render(graphics);
			for(gameObeject in this.UI) gameObeject.render(graphics);
		graphics.end();

		framebuffer.g2.begin();
			Scaler.scale(this._BackBuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}