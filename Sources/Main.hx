package;
import kha.WindowOptions;
import kha.Window;
import kha.WindowMode;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static function update(): Void {
		
	}

	static function render(frames: Array<Framebuffer>): Void {

	}

	static var Game:GameManagment = new GameManagment();
	public static function main() {
		var WindowSettins = new WindowOptions();
		WindowSettins.mode = Fullscreen;
		System.start({title: "Simple 2d", width: 1920, height: 1080, window: WindowSettins}, function (_) {
			Scheduler.addTimeTask(function () { Game.update(); }, 0, 1 / 60);
			System.notifyOnFrames(function (frames) { Game.render(frames[0]); });
		});
	}
}
