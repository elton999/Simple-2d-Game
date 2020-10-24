package;
import kha.WindowMode;
import kha.Window;
import umbrellatoolkit.Scene;
import umbrellatoolkit.helpers.Timer;
import umbrellatoolkit.helpers.Point;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class GameManagment {
	public var CurrentScene: Scene;
	public var FullScreem:Bool = true;
	private var DeltaTime:Timer;

	public function new (){
		this.CurrentScene = new Scene();
		this.DeltaTime = new Timer();
	}

	public function update(): Void {
		this.DeltaTime.update();
		this.CurrentScene.Update(this.DeltaTime.delta);
	}

	public function render(framebuffer: Framebuffer): Void {
		this.CurrentScene.render(framebuffer);
		
	}
}