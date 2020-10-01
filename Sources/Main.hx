package;
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
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { Game.update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { Game.render(frames); });
			});
		});
	}
}
