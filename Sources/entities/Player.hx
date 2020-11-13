package entities;

import umbrellatoolkit.level.Collision;
import kha.Color;
import kha.input.*;
import kha.math.Vector2;
import kha.graphics2.Graphics;
import umbrellatoolkit.GameObject;

@:expose
class Player extends GameObject{

	public override function start() {
		Keyboard.get().notify(OnkeyDown, OnKeyUp);
	}

	public override function update(DeltaTime:Float) {
		super.update(DeltaTime);
	}

	public override function updateData(DeltaTime:Float){
		this.gravity(DeltaTime);
		this.move(DeltaTime);
	}

	public override function render(g2:Graphics) {
		super.render(g2);
		g2.color = Color.Red;
		g2.fillRect(this.Position.x, this.Position.y, 32, 32);
		g2.color = Color.White;
	}

	// move
	public var speed:Float = 150;

	public function move(DeltaTime:Float) : Void{
		var _position:Vector2;
		if(this.Left){
			var _position:Vector2 = new Vector2(this.Position.x - DeltaTime*this.speed, this.Position.y);
			if(!this.getCollisionLayer("1").check(this.size, _position))
				this.Position = _position;
		}
		if(this.Right){
			var _position:Vector2 = new Vector2(this.Position.x + DeltaTime*this.speed, this.Position.y);
			if(!this.getCollisionLayer("1").check(this.size, _position))
				this.Position = _position;
		}
	}
	// end move


	// physics
	public var velocity:Vector2 = new Vector2(0, -210);
	public var size:Vector2 = new Vector2(32,32);
	public function gravity(DeltaTime:Float){
		var _position:Vector2 = new Vector2(this.Position.x - this.velocity.x, this.Position.y - (this.velocity.y* DeltaTime));
		if(!this.getCollisionLayer("1").check(this.size, _position))
			this.Position = _position;
	}

	public function getCollisionLayer(tag:String):Collision{
		for(layer in this.scene.CollisionLayer){
			if(layer.tag == tag)
				return layer;
		}
		return null;
	}
	// end physics

	// Controllers
	public var Right:Bool = false;
	public var Left:Bool = false;
	public var Up:Bool = false;
	public var Down:Bool = false;
	
	private function OnkeyDown(key:kha.input.KeyCode):Void{
		switch (key){
			case Up:
				this.Up = true;
			case Down:
				this.Down = true;
			case Left:
				this.Left = true;
			case Right:
				this.Right = true;
			default:
				//none
		}
	}

	private function OnKeyUp(key:kha.input.KeyCode):Void{
		switch (key){
			case Up:
				this.Up = false;
			case Down:
				this.Down = false;
			case Left:
				this.Left = false;
			case Right:
				this.Right = false;
			default:
				//none
		}
	}
	// End Controllers

}