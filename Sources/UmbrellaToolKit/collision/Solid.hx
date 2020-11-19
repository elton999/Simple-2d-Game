package umbrellatoolkit.collision;
import kha.math.Vector2;
import umbrellatoolkit.collision.Actor;
import umbrellatoolkit.collision.Solid;
import umbrellatoolkit.GameObject;
import umbrellatoolkit.helpers.Point;

class Solid extends GameObject {
	private var positions:Array<Vector2> = new Array<Vector2>();
	private var sizes:Array<Point> = new Array<Point>();
	public var tag:String;

	public var Collidable = true;

	private var xRemainder:Float = 0;
	private var yRemainder:Float = 0;

	public function add(size:Point, position:Vector2) : Void{
		this.sizes.push(size);
		this.positions.push(position);
	}

	public function Right():Int{
		return Std.int(this.positions[0].x + this.sizes[0].x);
	}

	public function Left():Int{
		return Std.int(this.positions[0].x);
	}

	public function Top():Int{
		return Std.int(this.positions[0].y);
	}

	public function Bottom():Int{
		return Std.int(this.positions[0].y + this.sizes[0].y);
	}

	
	public function move(x:Float, y:Float):Void{
		xRemainder += x; 
  		yRemainder += y;
		
		var moveX:Int = Math.round(xRemainder);
		var moveY:Int = Math.round(yRemainder);

		
		if (moveX != 0 || moveY != 0) 
  		{

			this.Collidable = false;
			var riding:Array<Actor> = this.GetAllRidingActors();

			if (moveX != 0) 
    		{
				xRemainder -= moveX;
				var i:Int = 0;
				while(i < this.positions.length){
					this.positions[i].x += moveX;
					i++;
				}

				if(moveX > 0){
					i = 0;
					while(i < this.scene.AllActors.length){
						if (overlapCheck(this.scene.AllActors[i])){
							// Push top
							this.scene.AllActors[i].moveX(this.Right() - this.scene.AllActors[i].Left(), this.scene.AllActors[i].squish);
						} else if(riding.indexOf(this.scene.AllActors[i]) != -1) {
							// Carry right
							this.scene.AllActors[i].moveX(moveX, null);
						}

						i++;
					}
					
				} else {
					while(i < this.scene.AllActors.length){
						if (overlapCheck(this.scene.AllActors[i])){
							// Push left
							this.scene.AllActors[i].moveX(this.Left() - this.scene.AllActors[i].Right(), this.scene.AllActors[i].squish);
						} else if(riding.indexOf(this.scene.AllActors[i]) != -1) {
							// Carry left
							this.scene.AllActors[i].moveX(moveX, null);
						}

						i++;
					}
				}
			} 

			if(moveY != 0){

				yRemainder -= moveY;
				var i:Int = 0;
				while(i < this.positions.length){
					this.positions[i].y += moveY;
					i++;
				}

				if(moveY > 0){
					i = 0;
					while(i < this.scene.AllActors.length){
						if (overlapCheck(this.scene.AllActors[i])){
							this.scene.AllActors[i].moveY(this.Bottom() - this.scene.AllActors[i].Top(), this.scene.AllActors[i].squish);
						} else if(riding.indexOf(this.scene.AllActors[i]) != -1) {
							this.scene.AllActors[i].moveY(moveY, null);
						}

						i++;
					}
					
				} else {
					i = 0;
					while(i < this.scene.AllActors.length){
						if (overlapCheck(this.scene.AllActors[i])){
							this.scene.AllActors[i].moveY(this.Top() - this.scene.AllActors[i].Bottom(), this.scene.AllActors[i].squish);
						} else if(riding.indexOf(this.scene.AllActors[i]) != -1) {
							this.scene.AllActors[i].moveY(moveY, null);
						}

						i++;
					}
				}

			} 
			this.Collidable = true; 
		}
	}

	public function overlapCheck(actor:Actor):Bool{

		var i:Int = 0;
		while(i < this.positions.length){
			var x_overlaps:Bool = false;
			var y_overlaps:Bool = false;

			var x_width:Int = Std.int(this.positions[i].x + this.sizes[i].x);
			var y_height:Int = Std.int(this.positions[i].y + this.sizes[i].y);
			
			x_overlaps = (
				(actor.Position.x + actor.size.x > this.positions[i].x && actor.Position.x + actor.size.x < x_width) ||
				(actor.Position.x > this.positions[i].x && actor.Position.x < x_width) ||
				(actor.Position.x <= this.positions[i].x && actor.Position.x + actor.size.x >= x_width)
			);

			y_overlaps = (
				(actor.Position.y + actor.size.y > this.positions[i].y && actor.Position.y + actor.size.y <= y_height) ||
				(actor.Position.y > this.positions[i].y && actor.Position.y < y_height) ||
				(actor.Position.y <= this.positions[i].y && actor.Position.y + actor.size.y >= y_height)
			);	

			i++;
			if(x_overlaps && y_overlaps)
				return true;
		}

		return false;
	}

	public function check(size:Point, position:Vector2) : Bool{
		var i:Int = 0;
		while(i < this.positions.length){
			var x_overlaps:Bool = false;
			var y_overlaps:Bool = false;

			var x_width:Int = Std.int(this.positions[i].x + this.sizes[i].x);
			var y_height:Int = Std.int(this.positions[i].y + this.sizes[i].y);
			
			x_overlaps = (
				(position.x + size.x > this.positions[i].x && position.x + size.x < x_width) ||
				(position.x > this.positions[i].x && position.x < x_width) ||
				(position.x <= this.positions[i].x && position.x + size.x >= x_width)
			);

			y_overlaps = (
				(position.y + size.y > this.positions[i].y && position.y + size.y <= y_height) ||
				(position.y > this.positions[i].y && position.y < y_height) ||
				(position.y <= this.positions[i].y && position.y + size.y >= y_height)
			);	

			i++;
			if(x_overlaps && y_overlaps)
				return true;
		}
		return false;
	
	}

	public function GetAllRidingActors():Array<Actor>{
		var rt:Array<Actor> = new Array<Actor>();
		var i:Int = 0;
		while(i< this.scene.AllActors.length){
			if(this.scene.AllActors[i].isRiding(this))
				rt.push(this.scene.AllActors[i]);
			i++;
		}

		return rt;
	}
}

