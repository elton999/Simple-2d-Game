package umbrellatoolkit.collision;

import umbrellatoolkit.GameObject;
import umbrellatoolkit.helpers.Point;
import umbrellatoolkit.collision.Solid;
import kha.math.Vector2;

class Actor extends GameObject{
	public override function updateData(DeltaTime:Float){
		this.gravity(DeltaTime);
	}

	public function Right():Int{
		return Std.int(this.Position.x + this.size.x);
	}

	public function Left():Int{
		return Std.int(this.Position.x);
	}

	public var velocity:Vector2 = new Vector2(0, -350);
	public function gravity(DeltaTime:Float){
		if(this.velocity.x != 0)
			this.moveX(-(this.velocity.x* DeltaTime), OnCollide);
		if(this.velocity.y != 0)
			this.moveY(-(this.velocity.y* DeltaTime), OnCollide);
	}
	
	var xRemainder:Float = 0;
	public function moveX(amount:Float, onCollideFunction:() -> Void = null):Void{
		xRemainder += amount;
  		var move:Int = Math.round(xRemainder);
		if (move != 0) 
		{ 
			xRemainder -= move; 
			var sign:Int = sign(move); 
			while (move != 0) 
			{
				var _position:Vector2 = new Vector2(this.Position.x+ sign, this.Position.y);
				if (!collideAt(this.scene.AllSolids, _position))
				{ 
					this.Position.x += sign; 
					move -= sign; 
				} 
				else 
				{
					if(onCollideFunction != null)
						onCollideFunction();
					break; 
				} 
			} 
		} 
	}

	var yRemainder:Float = 0;
	public function moveY(amount:Float, onCollideFunction:() -> Void = null):Void{
		yRemainder += amount;
  		var move:Int = Math.round(yRemainder);

		if (move != 0) 
		{ 
			yRemainder -= move; 
			var sign:Int = sign(move); 
			while (move != 0) 
			{
				var _position:Vector2 = new Vector2(this.Position.x, this.Position.y+ sign);
				if (!collideAt(this.scene.AllSolids, _position))
				{ 
					this.Position.y += sign; 
					move -= sign; 
				} 
				else 
				{ 
					if(onCollideFunction != null)
						onCollideFunction();
					break; 
				} 
			} 
		} 
	}

	private function collideAt(solids:Array<Solid>, position:Vector2):Bool{
		var rt:Bool = false;
		for(solid in solids){
			if(solid.check(this.size, position)){
				rt = true;
			}
		}
		return rt;
	}

	public function OnCollide():Void{}

	public function isRiding(solid:Solid):Bool{
		if(solid.check(this.size,  new Vector2(this.Position.x, this.Position.y + 1)))
			return true;
		return false;
	}

	public function squish():Void{}

	private function sign(v:Int):Int{
		if(v>0)
			return 1;
		else if(v<0)
			return -1;
		else
			return 0;
	}
}