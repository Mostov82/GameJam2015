package GameStates
{
	import IO.MovmentListener;
	
	import Interfaces.IGameState;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class Level3 extends Sprite implements IGameState
	{
		
		private var _game:Game;
		
		public function Level3(g:Game)
		{
			
			_game = g;
			
			//~--===<|	
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}private function onAddedToStage():void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//~--===<|
			
			var l:MovmentListener = new MovmentListener();
			l.addEventListener("HeroMovement",handleHero);
			trace("Level 3");
		}
		
		private function handleHero(e:Event, data:String):void{
			if(data == "next"){
				EndLevel();
			}
			else{
				//trace(data);
			}
		}
		
		private function EndLevel():void{
			_game.changeState(Game.STATE_LEVEL_4);
		}
		
		public function update():void{}
		public function destroy():void{}
	}
}