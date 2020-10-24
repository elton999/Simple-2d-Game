package umbrellatoolkit;

import umbrellatoolkit.helpers.BoxSprite;
import kha.math.Vector2;
import kha.Image;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

@:expose
class GameObject {
	public function new (){}

	public var Sprite:Image;
	public var Scale:Float = 1.0;
	public var Position:Vector2 = new Vector2(0,0);
	public var BoxSprite:BoxSprite;

	public function update(DeltaTime:Float) : Void{}
	public function render(g2:kha.graphics2.Graphics): Void{
		
	}
}