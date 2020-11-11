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

enum LayersScene {
	UI;
	FORENGROUND;
	PLAYER;
	ENEMIES;
	MIDDLEGROUND;
	BACKGROUND;
}

@:expose
class Scene {

	public var UI:Array<GameObject> = new Array();
	public var Forenground:Array<GameObject> = new Array();
	public var Player:Array<GameObject> = new Array();
	public var Enemies:Array<GameObject> = new Array();
	public var MiddleGround:Array<GameObject> = new Array();
	public var Background:Array<GameObject> = new Array();
	
	public var BackgroundColor:Color = Color.Blue;
	public var ScreemSize:Point = new Point(426, 240);

	public var _BackBuffer:Image;

	public var SceneReady:Bool = false;

	public var scene:umbrellatoolkit.Scene;

	public function new (){}

	public function CreateScene(){
		if(this.scene != null)
			this.scene = new umbrellatoolkit.Scene();
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
			Assets.loadBlob(level, function(done:kha.Blob.Blob){
				this.TileMap = new TileMap(done.toString(), this.TileSet, this);
				this.TileMap.CreateLevel();

				this.SceneReady = true;
			});
		});
	}



	public function UloadLevel(){
		
	}

	public function update(deltaTime:Float) : Void{
		if(this.SceneReady){
			for(gameObject in this.Background) gameObject.update(deltaTime);
			for(gameObject in this.MiddleGround) gameObject.update(deltaTime);
			for(gameObject in this.Enemies) gameObject.update(deltaTime);
			for(gameObject in this.Player) gameObject.update(deltaTime);
			for(gameObject in this.Forenground) gameObject.update(deltaTime);
			for(gameObject in this.UI) gameObject.update(deltaTime);
		}
	}


	public function render(framebuffer: Framebuffer): Void{

		this._BackBuffer = Image.createRenderTarget(this.ScreemSize.x, this.ScreemSize.y);
		var graphics = this._BackBuffer.g2;
		graphics.begin(this.BackgroundColor);
			if(this.SceneReady){
				for(gameObject in this.Background) gameObject.render(graphics);
				for(gameObject in this.MiddleGround) gameObject.render(graphics);
				for(gameObject in this.Enemies) gameObject.render(graphics);
				for(gameObject in this.Player) gameObject.render(graphics);
				for(gameObject in this.Forenground) gameObject.render(graphics);
				for(gameObject in this.UI) gameObject.render(graphics);
			} else{
				graphics.fillRect(0,0 ,8,8);
			}
		graphics.end();

		framebuffer.g2.begin();
			Scaler.scale(this._BackBuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}