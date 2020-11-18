package entities.solids;

import kha.math.Vector2;
import kha.Color;
import kha.graphics2.Graphics;
import umbrellatoolkit.collision.Solid;

@:expose
class MovePlatform extends Solid{

	public var intialPosition:Vector2;
	public override function start() {
		super.start();
		this.tag = "movePlatform";
		this.add(this.size, this.Position);
		this.scene.AllSolids.push(this);


		this.intialPosition = this.positions[0];
	}

	private var back:Bool = false;
	public override function updateData(DeltaTime:Float) {
		super.updateData(DeltaTime);
		if(this.valeus.move){
			if(this.positions[0].x == this.intialPosition.x + 20 && !this.back)
			this.back = true;
			else if(this.positions[0].x == this.intialPosition.x && this.back)
				this.back = false;

			if(!this.back)
				this.move(1,0);
			else
				this.move(-1,0);
		}
	}


	public override  function render(g2:Graphics) {
		super.render(g2);

		g2.color = Color.Blue;
		g2.fillRect(this.positions[0].x, this.positions[0].y, this.sizes[0].x, this.sizes[0].y);
		g2.color = Color.White;
	}

}