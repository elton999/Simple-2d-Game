package entities;

import kha.Color;
import kha.graphics2.Graphics;
import umbrellatoolkit.GameObject;

@:expose
class Player extends GameObject{

	public override function render(g2:Graphics) {
		super.render(g2);
		g2.color = Color.Red;
		g2.fillRect(this.Position.x, this.Position.y, 32, 32);
		g2.color = Color.White;
	}
}