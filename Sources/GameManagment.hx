package;
import umbrellatoolkit.Scene;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class GameManagment {
	public var CurrentScene: Scene;
	public function new (){
		this.CurrentScene = new Scene();
	}


	public function update(): Void {
		this.CurrentScene.Update();
	}

	public function render(frames: Array<Framebuffer>): Void {
		this.CurrentScene.render(frames);
	}
}