package umbrellatoolkit.level;

import umbrellatoolkit.helpers.Point;
import kha.math.Vector2;
import umbrellatoolkit.GameObject;
import umbrellatoolkit.Scene;

@:expose
class AssetsManagment
{
	private var _GameObjectsList:Map<String, AssetObject> = new Map<String, AssetObject>();
	
	public function new(){}

	public function add(type:Class<GameObject>, tag:String, layer:LayersScene):Void{
		var asset:AssetObject = new AssetObject();
		asset.gameObject = type;
		asset.layer = layer;

		this._GameObjectsList.set(tag, asset);
	}

	public function addEntityOnSene(tag:String, scene:Scene, position:Vector2, ?size:Point, ?values:Dynamic):Void{
		if(this._GameObjectsList.exists(tag)){
			var asset:AssetObject = this._GameObjectsList[tag];
			var gameObject:GameObject = Type.createInstance(asset.gameObject, []);
			gameObject.Position = position;
			if(size != null) gameObject.size = size;
			if(values != null) gameObject.valeus = values;

			switch (asset.layer){
				case PLAYER:
					gameObject.scene = scene;
					gameObject.start();
					scene.Player.push(gameObject);
				case MIDDLEGROUND:
					gameObject.scene = scene;
					gameObject.start();
					scene.MiddleGround.push(gameObject);
				default:
					trace("not found");
			}
		}
	}
}

class AssetObject{
	public var gameObject:Class<GameObject>;
	public var layer:LayersScene;
	public function new(){}
}