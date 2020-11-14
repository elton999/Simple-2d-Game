package umbrellatoolkit.level;
import kha.math.Vector2;
import umbrellatoolkit.Scene;
import haxe.Json;
import kha.Color;
import umbrellatoolkit.GameObject;
import umbrellatoolkit.level.Tile;
import umbrellatoolkit.level.TileSet;
import umbrellatoolkit.level.Layer;
import umbrellatoolkit.level.Collision;
import umbrellatoolkit.level.AssetsManagment;

@:expose
class TileMap{
	public var Data:Level;
	private var _TileSet:TileSet;
	private var _Scene:Scene;
	private var _Assets:AssetsManagment;

	public function new(dataString:String, tileSet:TileSet, scene:Scene, assets:AssetsManagment){
		this.Data = Json.parse(dataString);
		this._TileSet = tileSet;
		this._Scene = scene;
		this._Assets = assets;
	}

	public function CreateLevel(){
		var i:Int = 0;
		while (i < this.Data.layers.length){
			var layer = this.Data.layers[i];
			var layers:Layer = new Layer();

			// Grid
			if(layer.grid2D != null){
				for(layerD in this._TileSet.Data.layers){
					if(layer._eid == layerD.exportID){
						var x = 0;
						var y = 0;
						for (line in layer.grid2D){
							x = 0;
							for(row in line){
								// if isn't transparent create a tile color
								if(row != "0"){

									var tile:Tile = new Tile();
									tile.squareColor = Color.Yellow ;//Color.fromString(layerD.legend[Std.parseInt(row)].substring(0,7));
									tile.squareSize = new Vector2(layer.gridCellWidth, layer.gridCellHeight);
									tile.Position = new Vector2(layer.gridCellWidth*x, layer.gridCellHeight*y);

									this.addCollisionLayer(row, tile.squareSize, tile.Position);

									layers.addGameObject(tile);
								}
								x++;
							}
							y++;
						}
					}
				}

				// setting tiles colors on Scene
				this._Scene.Background.push(layers);
			}//End Grid
			
			// entities
			else if(layer.entities != null){
				for(entity in layer.entities){
					this._Assets.addEntityOnSene(entity.name, this._Scene, new Vector2(entity.x, entity.y));
				}
			}// End entities

			i++;
		}

		this._Scene.BackgroundColor = Color.fromString(this._TileSet.Data.backgroundColor.substring(0,7));
	}

	public function addCollisionLayer(tag:String, size:Vector2, position:Vector2){
		var _find:Bool = false;
		var i = 0;
		while(i < this._Scene.CollisionLayer.length){
			if(this._Scene.CollisionLayer[i].tag == tag){
				_find = true;
				this._Scene.CollisionLayer[i].add(size, position);
			}
			i++;
		}

		if(!_find){
			var _collision:Collision = new Collision();
			_collision.tag = tag;
			_collision.add(size, position);
			this._Scene.CollisionLayer.push(_collision);
		}
	}
}

typedef Level = {
	var width:Int;
	var height:Int;
	var offsetX: Int;
	var offsetY: Int;
	var layers:Array<LevelLayer>;
}

typedef LevelLayer = {
	var name:String;
	var _eid:String;
	var offsetX:Int;
	var offsetY:Int;
	var gridCellWidth:Int;
	var gridCellHeight:Int;
	var gridCellsX:Int;
	var gridCellsY:Int;
	var data2D:Array<Array<Int>>;
	var grid2D:Array<Array<String>>;
	var entities:Array<LevelLayerEntities>;
}

typedef LevelLayerEntities = {
	var name:String;
	var _eid:String;
	var x:Int;
	var y:Int;
	var originX:Int;
	var originY:Int;
}