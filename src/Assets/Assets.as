package Assets{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class Assets extends Sprite{
		
		private var className:String = 'AssetsLoader';
		
		private static var instance				: Assets;
		private static var allowInstantiation	: Boolean;
		public var mngr:AssetManager = new AssetManager();
		
		public static function getInstance():Assets {
			if (instance == null) {
				allowInstantiation = true;
				
				instance = new Assets();
				
				allowInstantiation = false;
			}
			return instance;
		}
		
		public function Assets() {
			if (!allowInstantiation) {
				throw new Error("Error: Instantiation failed: Use Assets.getInstance() instead of new.");
			} else {
				startLoading();
			}
		}
		
		public function startLoading():void{
			
			this.name = "Assets";
			trace("Initializing Assets. stage["+Starling.current.stage.stageWidth+","+Starling.current.stage.stageHeight,"]");
			trace("\n");
			mngr.verbose = true;
			mngr.enqueue(EmbeddedAssets);
			load();
			
		}
		
		public function load():void{
			mngr.loadQueue(function(ratio:Number):void
			{
				
				
				//trace("Loading assets, progress:", ratio);
				dispatchEventWith("LoadingProgress",true,ratio);
				// -> When the ratio equals '1', we are finished.
				if (ratio == 1.0){
					trace("____________________________________________________");
					trace("****************************************************");
					trace("\tEventDispatched - LoadingComplete");
					trace("****************************************************");
					dispatchEventWith("LoadingComplete",true);
				}
			});
			
			
		}
		
		

	
	
//------ EOF ------	
}}