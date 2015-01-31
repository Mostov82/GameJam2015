package GameStates{
	import Assets.Assets;
	
	import Interfaces.IGameState;
	
	import Utils.Utils;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	public class GameOpenning extends Sprite implements IGameState{
		
		private var _game:Game;
		
		
		public function GameOpenning(g:Game){
			
			_game = g;
			
		
			//~--===<|
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}private function onAddedToStage():void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			//~--===<|

			var opening:Image = new Image(Assets.Assets.getInstance().mngr.getTexture("Scene1_Sky"));
			opening.alpha = 0;
			Utils.Utils.centerImg(opening);
			addChild(opening);
			
			var scleOpening:Tween = new Tween (opening,0.5);
			var alphaOpening:Tween = new Tween (opening,0.5);
			
			
			scleOpening.scaleTo(5);
			alphaOpening.fadeTo(1);
			
			Starling.juggler.add(scleOpening);
			Starling.juggler.add(alphaOpening);
			
			
			
			Starling.juggler.delayCall(
				function endOpening():void{
					_game.changeState(Game.STATE_LEVEL_1);				}
				,1);
			
		}
		
		

		public function update():void{}
		public function destroy():void{}
		
//------------------------
}}//--- EOF ---
//------------------------