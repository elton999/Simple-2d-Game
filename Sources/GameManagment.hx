package;
import entities.Player;
import entities.solids.MovePlatform;
import umbrellatoolkit.Scene;
import umbrellatoolkit.level.AssetsManagment;
import umbrellatoolkit.helpers.Timer;
import kha.Framebuffer;

class GameManagment {
	public var Scene: Scene;
	private var AssetsManagment:AssetsManagment = new AssetsManagment();

	public var FullScreem:Bool = true;
	private var DeltaTime:Timer;

	public function new (){
		this.Scene = new Scene();
		this.DeltaTime = new Timer();

		// Set Assets
		this.AssetsManagment.add(Player, "Player", LayersScene.PLAYER);
		this.AssetsManagment.add(MovePlatform, "Plataforma", LayersScene.MIDDLEGROUND);
	}

	private var LoadScene:Bool = false;
	public function update(): Void {
		if(!this.LoadScene){
			this.Scene.scene = new Scene();
			this.Scene.scene.cameraLerpSpeed = 1;
			this.Scene.scene.LoadLevel("Content_Game2d_ogmo", "Content_level1_json", this.AssetsManagment);
			this.LoadScene = true;
		}

		if(this.Scene.scene != null){
			this.DeltaTime.update();
			this.Scene.scene.update(this.DeltaTime.delta);
		}
	}

	public function updateData():Void{
		if(this.Scene.scene != null){
			this.DeltaTime.update();
			this.Scene.scene.updateData(this.DeltaTime.delta);
		}
	}

	public function render(framebuffer: Framebuffer): Void {
		if(this.Scene.scene != null){
			this.Scene.scene.render(framebuffer);
		}
	}
}