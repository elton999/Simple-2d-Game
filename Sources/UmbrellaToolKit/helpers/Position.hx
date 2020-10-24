package umbrellatoolkit.helpers;

@:expose 
class Position{

	public var X:Float;
	public var Y:Float;

	public function new (X:Float, Y:Float){
		this.X = X;
		this.Y = Y;
	}
}