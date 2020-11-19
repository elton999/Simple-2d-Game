package;
import kha.WindowOptions;
import kha.Window;
import kha.WindowMode;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var Game:GameManagment = new GameManagment();
	
	public static function main() {
		var scale:Float = 2.0;
		var WindowSettins = new WindowOptions();
		WindowSettins.mode = Windowed;
		System.start({title: "Simple 2d", width: Std.int(1920 / scale), height: Std.int(1080 / scale), window: WindowSettins}, function (_) {
			Scheduler.addTimeTask(function () { Game.update(); }, 0, 1 / 60);
			Scheduler.addTimeTask(function () { Game.updateData(); }, 0, 1 / 30);
			System.notifyOnFrames(function (frames) { Game.render(frames[0]); });
		});
	}
}
