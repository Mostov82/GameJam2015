package GameStates
{
	import IO.MovmentListener;
	
	import Interfaces.IGameState;
	
	import starling.display.Sprite;
	import starling.events.Event;

	public class EndGame extends Sprite implements IGameState
	{
		private var _game:Game;
		
		public function EndGame(g:Game)
		{
			_game = g;
			
			//~--===<|	
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}private function onAddedToStage():void{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//~--===<|
			
			var l:MovmentListener = new MovmentListener();
			l.addEventListener("HeroMovement",handleHero);
			
			EndLevel();
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
			trace("Fin");
		}
		
		public function update():void{}
		public function destroy():void{}
	}
}