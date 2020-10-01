package umbrellatoolkit;

import umbrellatoolkit.GameObject;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

@:expose
class Scene {

	public var Forenground:Array<GameObject>;
	public var Player:Array<GameObject>;
	public var Enemies:Array<GameObject>;
	public var MiddleGround:Array<GameObject>;
	public var Background:Array<GameObject>;

	public function Update() : Void{}
	public function render(frames: Array<Framebuffer>): Void{}
}