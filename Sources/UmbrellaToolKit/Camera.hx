package umbrellatoolkit;

import umbrellatoolkit.Scene;
import umbrellatoolkit.helpers.Point;
import kha.math.Vector2;
import umbrellatoolkit.GameObject;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

@:expose
class Camera {
	public var position:Vector2 = new  Vector2(0,0);
	public var trans:FastMatrix3;

	public var follow:umbrellatoolkit.GameObject;
	public var scene:Scene;

	public function new(){
		trans = FastMatrix3.identity();
	}

	public function update(){
		if(this.follow != null){
			this.position.x = this.lerp(this.position.x , this.follow.Position.x, this.scene.cameraLerpSpeed);
			this.position.y = this.lerp(this.position.y, this.follow.Position.y, this.scene.cameraLerpSpeed);
		}
	}

	public function lerp(min:Float, max:Float, value:Float) : Float{
		return return min + (max - min) * value;
	}

	public function begin(graphics:Graphics){
		graphics.transformation = trans;
		graphics.translate(-this.position.x + (this.scene.ScreemSize.x / 2), -this.position.y + (this.scene.ScreemSize.y / 2));
	}

	public function end(graphics:Graphics){
		graphics.popTransformation();
	}
}