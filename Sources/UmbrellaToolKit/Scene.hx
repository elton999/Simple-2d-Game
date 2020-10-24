package umbrellatoolkit;

import umbrellatoolkit.GameObject;
import umbrellatoolkit.helpers.Point;
import umbrellatoolkit.level.TileSet;
import umbrellatoolkit.level.TileMap;
import kha.Scaler;
import kha.Image;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.Blob;
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

	public var SceneReady:Bool = false;

	public function new (){
	}


	public var TileSet:TileSet;
	public var TileMap:TileMap;
	private var TileSetString:String;
	private var TileMapString:String;
	
	public function LoadLevel(tileSet:String, level:String){
		this.TileSetString = tileSet;
		this.TileMapString = level;
		Assets.loadBlob(tileSet, function (done:kha.Blob.Blob){
			this.TileSet = new TileSet(done.toString());
			Assets.loadBlob(level, function(done:Kha.Blob.Blob)){

			}
		});
	}

	public function UloadLevel(){
		
	}

	public function update(deltaTime:Float) : Void{
		for(gameObeject in this.Background) gameObeject.update(deltaTime);
		for(gameObeject in this.MiddleGround) gameObeject.update(deltaTime);
		for(gameObeject in this.Enemies) gameObeject.update(deltaTime);
		for(gameObeject in this.Player) gameObeject.update(deltaTime);
		for(gameObeject in this.Forenground) gameObeject.update(deltaTime);
		for(gameObeject in this.UI) gameObeject.update(deltaTime);
	}


	public function render(framebuffer: Framebuffer): Void{

		this._BackBuffer = Image.createRenderTarget(this.ScreemSize.x, this.ScreemSize.y);
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