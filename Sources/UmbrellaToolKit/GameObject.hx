package umbrellatoolkit;

import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

@:expose
class GameObject {
	public function new (){}
	public function Update() : Void{}
	public function render(frames: Array<Framebuffer>): Void{}
}