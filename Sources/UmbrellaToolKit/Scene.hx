package umbrellatoolkit;

import umbrellatoolkit.GameObject;
import umbrellatoolkit.Camera;
import umbrellatoolkit.helpers.Point;
import umbrellatoolkit.level.TileSet;
import umbrellatoolkit.level.TileMap;
import umbrellatoolkit.collision.Actor;
import umbrellatoolkit.collision.Solid;
import umbrellatoolkit.level.AssetsManagment;
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
	public var cameraLerpSpeed:Float = 0.06;

	public var _BackBuffer:Image;

	public var SceneReady:Bool = false;
	public var AllSolids:Array<Solid> = new Array<Solid>();
	public var AllActors:Array<Actor> = new Array<Actor>();

	public var scene:umbrellatoolkit.Scene;
	public var camera:Camera;

	public function new (){}

	public function CreateScene(){
		if(this.scene != null){
			this.scene = new umbrellatoolkit.Scene();
		}
	}


	public var TileSet:TileSet;
	public var TileMap:TileMap;
	private var TileSetString:String;
	private var TileMapString:String;
	
	public function LoadLevel(tileSet:String, level:String, assets:AssetsManagment){
		this.TileSetString = tileSet;
		this.TileMapString = level;
		Assets.loadBlob(tileSet, function (done:kha.Blob.Blob){
			this.TileSet = new TileSet(done.toString());
			done.unload();
			Assets.loadBlob(level, function(done:kha.Blob.Blob){
				this.TileMap = new TileMap(done.toString(), this.TileSet, this, assets);
				this.TileMap.CreateLevel();
				done.unload();
				this.SceneReady = true;
				this.camera = new Camera();
				this.camera.scene = this;
				//if(this.Player.length > 0) this.camera.follow = this.Player[0];
				
			});
		});
	}



	public function UloadLevel(){
		
	}

	public function update(deltaTime:Float) : Void{
		if(this.SceneReady){
			if(this.camera != null) this.camera.update();
			for(gameObject in this.Background) gameObject.update(deltaTime);
			for(gameObject in this.MiddleGround) gameObject.update(deltaTime);
			for(gameObject in this.Enemies) gameObject.update(deltaTime);
			for(gameObject in this.Player) gameObject.update(deltaTime);
			for(gameObject in this.Forenground) gameObject.update(deltaTime);
			for(gameObject in this.UI) gameObject.update(deltaTime);
		}
	}

	public function updateData(deltaTime:Float) : Void{
		if(this.SceneReady){
			for(gameObject in this.Background) gameObject.updateData(deltaTime);
			for(gameObject in this.MiddleGround) gameObject.updateData(deltaTime);
			for(gameObject in this.Enemies) gameObject.updateData(deltaTime);
			for(gameObject in this.Player) gameObject.updateData(deltaTime);
			for(gameObject in this.Forenground) gameObject.updateData(deltaTime);
			for(gameObject in this.UI) gameObject.updateData(deltaTime);
		}
	}

	public function render(framebuffer: Framebuffer): Void{

		this._BackBuffer = Image.createRenderTarget(this.ScreemSize.x, this.ScreemSize.y);
		var graphics = this._BackBuffer.g2;
		graphics.begin(this.BackgroundColor);
			if(this.SceneReady){
				if(this.camera != null) this.camera.begin(graphics);
				for(gameObject in this.Background) gameObject.render(graphics);
				for(gameObject in this.MiddleGround) gameObject.render(graphics);
				for(gameObject in this.Enemies) gameObject.render(graphics);
				for(gameObject in this.Player) gameObject.render(graphics);
				for(gameObject in this.Forenground) gameObject.render(graphics);
				for(gameObject in this.UI) gameObject.render(graphics);
				if(this.camera != null) this.camera.end(graphics);
			} else{
				graphics.fillRect(0,0 ,8,8);
			}
		graphics.end();

		framebuffer.g2.begin();
			Scaler.scale(this._BackBuffer, framebuffer, System.screenRotation);
		framebuffer.g2.end();
	}
}