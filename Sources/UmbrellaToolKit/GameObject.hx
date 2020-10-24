package umbrellatoolkit;

import umbrellatoolkit.helpers.Position;
import umbrellatoolkit.helpers.BoxSprite;
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
	public var Position:Position = new Position(0,0);
	public var BoxSprite:BoxSprite;

	public function Update(DeltaTime:Float) : Void{}
	public function render(g2:kha.graphics2.Graphics): Void{
		
	}
}