package umbrellatoolkit.level;

import Type.ValueType;
import kha.math.Vector2;
import umbrellatoolkit.GameObject;
import umbrellatoolkit.level.TileMap.LevelLayer;
import umbrellatoolkit.Scene;

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

	public function addEntityOnSene(tag:String, scene:Scene, position:Vector2):Void{
		var asset:AssetObject = this._GameObjectsList[tag];
		var gameObject:GameObject = Type.createInstance(asset.gameObject, []);
		gameObject.Position = position;
		
		switch (asset.layer){
			case PLAYER:
				scene.Player.push(gameObject);
			default:
				trace("not found");
		}
	}
}

class AssetObject{
	public var gameObject:Class<GameObject>;
	public var layer:LayersScene;
	public function new(){}
}