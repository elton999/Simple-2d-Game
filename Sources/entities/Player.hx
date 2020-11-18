package entities;

import kha.Color;
import kha.input.*;
import kha.math.Vector2;
import kha.graphics2.Graphics;
import umbrellatoolkit.GameObject;
import umbrellatoolkit.collision.Actor;
import umbrellatoolkit.collision.Solid;

@:expose
class Player extends Actor{

	public override function start() {
		this.scene.AllActors.push(this);
		Keyboard.get().notify(OnkeyDown, OnKeyUp);
	}

	public override function update(DeltaTime:Float) {
		if(this.scene.camera != null && this.scene.camera.follow == null)
			this.scene.camera.follow = this;
		super.update(DeltaTime);
	}

	public override function updateData(DeltaTime:Float){
		this.move(DeltaTime);
		super.updateData(DeltaTime);
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
		if(this.cLeft)
			this.moveX(-(DeltaTime*this.speed), null);
		if(this.cRight)
			this.moveX((DeltaTime*this.speed), null);
	}
	// end move


	// Controllers
	public var cRight:Bool = false;
	public var cLeft:Bool = false;
	public var cUp:Bool = false;
	public var cDown:Bool = false;
	
	private function OnkeyDown(key:kha.input.KeyCode):Void{
		switch (key){
			case Up:
				this.cUp = true;
			case Down:
				this.cDown = true;
			case Left:
				this.cLeft = true;
			case Right:
				this.cRight = true;
			default:
				//none
		}
	}

	private function OnKeyUp(key:kha.input.KeyCode):Void{
		switch (key){
			case Up:
				this.cUp = false;
			case Down:
				this.cDown = false;
			case Left:
				this.cLeft = false;
			case Right:
				this.cRight = false;
			default:
				//none
		}
	}
	// End Controllers

}