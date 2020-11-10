package umbrellatoolkit.level;

import kha.graphics2.Graphics;
import umbrellatoolkit.GameObject;

class Layer extends GameObject{
	private var Items:Array<GameObject> = new Array();

	public function addGameObject(gameObject:GameObject):Void{
		this.Items.push(gameObject);
	}

	public override function render(g2:Graphics) {
		super.render(g2);
		for(item in this.Items) item.render(g2);
	}
}