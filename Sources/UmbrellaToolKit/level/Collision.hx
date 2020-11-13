package umbrellatoolkit.level;

import kha.math.Vector2;

class Collision {
	
	public function new(){}
	
	public var tag:String;
	private var positions:Array<Vector2> = new Array<Vector2>();
	private var sizes:Array<Vector2> = new Array<Vector2>();
	
	public function add(size:Vector2, position:Vector2) : Void{
		this.sizes.push(size);
		this.positions.push(position);
	}

	public function check(size:Vector2, position:Vector2) : Bool{
		var i:Int = 0;
		while(i < this.positions.length){
			var x_overlaps:Bool = false;
			var y_overlaps:Bool = false;

			var x_width:Float = this.positions[i].x + this.sizes[i].x;
			var y_height:Float = this.positions[i].y + this.sizes[i].y;
			
			x_overlaps = (
				(position.x + size.x > this.positions[i].x && position.x + size.x < x_width) ||
				(position.x > this.positions[i].x && position.x < x_width) ||
				(this.positions[i].x > position.x && x_width < position.x + size.x)
			);

			y_overlaps = (
				(position.y + size.y > this.positions[i].y && position.y + size.y < y_height) ||
				(position.y > y_height && position.y < this.positions[i].y) ||
				(this.positions[i].y > position.y && y_height < position.y + size.y)
			);	

			i++;
			if(x_overlaps && y_overlaps)
				return true;
		}
		return false;
	}
}