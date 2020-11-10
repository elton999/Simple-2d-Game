package;
import umbrellatoolkit.Scene;
import umbrellatoolkit.helpers.Timer;
import kha.Framebuffer;

class GameManagment {
	public var Scene: Scene;
	public var FullScreem:Bool = true;
	private var DeltaTime:Timer;

	public function new (){
		this.Scene = new Scene();
		this.DeltaTime = new Timer();
	}

	private var LoadScene:Bool = false;
	public function update(): Void {
		if(!this.LoadScene){
			this.Scene.scene = new Scene();
			this.Scene.scene.LoadLevel("Content_Game2d_ogmo", "Content_level1_json");
			this.LoadScene = true;
		}

		if(this.Scene.scene != null){
			this.DeltaTime.update();
			this.Scene.scene.update(this.DeltaTime.delta);
		}
	}

	public function render(framebuffer: Framebuffer): Void {
		if(this.Scene.scene != null){
			this.Scene.scene.render(framebuffer);
		}
	}
}