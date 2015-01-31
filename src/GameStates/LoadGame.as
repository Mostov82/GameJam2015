package GameStates{
	
	import Assets.Assets;
	
	import Interfaces.IGameState;
	
	import UI.ProgressBar;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;

	public class LoadGame extends Sprite implements IGameState{
		
		private var _game:Game;
		private var _progBar:UI.ProgressBar;
		
		public function LoadGame(g:Game){
			trace("State - Load : LoadGame");
			_game = g;
		
	//~--===<|	
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}private function onAddedToStage():void{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	//~--===<|
		
		//placeLoadingScreen();
		
		_progBar = new ProgressBar(0,0,530, 70,Color.GREEN,Color.RED);
		_progBar.x = 250;
		_progBar.y = 350;
		addChild(_progBar);
		
		trace("\nloadingGame\n");
		
		var assets:Assets = Assets.Assets.getInstance();
		
		assets.addEventListener("LoadingProgress",assetsProgres);
		assets.addEventListener("LoadingComplete",assetsLoaded);
		}	
		
		
		private function assetsProgres(event:Event, ratio:Number):void{
			
			Starling.msg = "Loading assets, progress : "+ratio
			_progBar.ratio = ratio;
		}
		
		
		private function assetsLoaded():void{
			_progBar.removeFromParent(true);
			_progBar = null;
			
			
			
				
			_game.changeState(Game.STATE_GAME_OPN);
			
			
		}
		
		
		public function update():void {}
		public function destroy():void {}
		
		/*
		[Embed(source="/AssetsClass/Backgrounds/Loading_ref.png")]
		public static const backGroundImage:Class;
		
		private function placeLoadingScreen():void{
			var bitmap:Bitmap = new backGroundImage();
			var texture:Texture = Texture.fromBitmap(new backGroundImage());
			var image:Image = new Image(texture);
			Utils.centerImg(image);
			addChild(image);
		}
		*/
		
//----------------------		
}}//--- EOF ---
//----------------------