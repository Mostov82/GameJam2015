package{
	import GameStates.EndGame;
	import GameStates.GameOpenning;
	import GameStates.Level1;
	import GameStates.Level2;
	import GameStates.Level3;
	import GameStates.Level4;
	import GameStates.LoadGame;
	import GameStates.Test;
	
	import Interfaces.IGameState;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	
	public class Game extends Sprite{
		
		
		//-- GameStates --//
			public static const STATE_GAME_LOAD		: int = 0;
			public static const STATE_GAME_OPN		: int = 1;
			public static const STATE_GAME_RL		: int = 2;
			
			
			public static const STATE_MENU			: int = 3;
			public static const STATE_LEVEL_LOAD	: int = 6;
			public static const STATE_LEVEL_SELECT	: int = 9;
			public static const STATE_LEVEL_PLAY	: int = 12;
			public static const STATE_UPGRADE		: int = 15;
			
			
			public static const STATE_LEVEL_1		: int = 21;
			public static const STATE_LEVEL_2		: int = 22;
			public static const STATE_LEVEL_3		: int = 23;
			public static const STATE_LEVEL_4		: int = 24;
			public static const END_GAME			: int = 25;
			
			public static const STATE_GAME_OVER		: int = -1;
			public static const STATE_LEVEL_OVER	: int = -3;
			
			public static const STATE_TEST			: int = 99;
		//-- GameStates --//
		
		
		
		
		public var currentState:IGameState;
		//public var assets:Assets;
		public function Game(){
			super();
			trace("hello world");
		
			
	//~--===<|
		addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}private function onAddedToStage():void{
		removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
	//~--===<|

		
		//Set inital State
			changeState(STATE_GAME_LOAD);
		//Add listener
			_addUpdateListener();
			
		}
		
		
		
		/*** Updates the current state */
		private function update():void {currentState.update();}
		/*** Adds update listener */
		private function _addUpdateListener():void {addEventListener(Event.ENTER_FRAME, update);}
		/*** Removes update listener */
		private function _removeUpdateListener():void {removeEventListener(Event.ENTER_FRAME, update);}
		
		public function changeState(state:int):void {
			
			traceGameState(state);
			
			var removed:Boolean = false;
			
			if(currentState != null) {
				_removeUpdateListener();
				currentState.destroy();
				removeChild(Sprite(currentState));
				currentState = null;
				removed = true;	
			}
			
			switch(state) {
				case STATE_GAME_LOAD:		currentState = new LoadGame(this);		break;
				case STATE_GAME_OPN:		currentState = new GameOpenning(this);	break;
				//case STATE_GAME_RL:		currentState = new RightieLeftie(this);	break;
				//case STATE_MENU:			currentState = new Menu(this);			break;
				//case STATE_LEVEL_LOAD:	currentState = new LoadLevel(this);		break;
				//case STATE_LEVEL_SELECT:	currentState = new LevelSelect(this);	break;
				//case STATE_LEVEL_PLAY:	currentState = new PlayGame(this);		break;
				//case STATE_UPGRADE:		currentState = new Upgrades(this);		break;
				//case STATE_GAME_OVER:		currentState = new GameOver(this);		break;
				//case STATE_LEVEL_OVER:	currentState = new LevelOver(this);		break;
				
				case STATE_LEVEL_1:			currentState = new Level1(this);		break;
				case STATE_LEVEL_2:			currentState = new Level2(this);		break;
				case STATE_LEVEL_3:			currentState = new Level3(this);		break;
				case STATE_LEVEL_4:			currentState = new Level4(this);		break;
				case END_GAME:				currentState = new EndGame(this);		break;
				case STATE_TEST:			currentState = new Test(this);			break;
			}
			
			
			addChild(Sprite(currentState));
			
			if(removed) {
				// Add update listeners back
				_addUpdateListener();
				removed = false;
			}
		}


		//------ Utils ------
		
		private function traceGameState(state:int):void{
			
			var stateName:String = "ERROR";
			var stateMark:String = " <========> ";
			
			switch(state){
				case 0	 :{stateName = "STATE_GAME_LOAD";	}break;
				case 1	 :{stateName = "STATE_GAME_OPN";	}break;
				case 2	 :{stateName = "STATE_GAME_RL";		}break;
				case 3	 :{stateName = "STATE_MENU";		}break;
				case 6	 :{stateName = "STATE_LEVEL_LOAD";	}break;
				case 9	 :{stateName = "STATE_LEVEL_SELECT";}break;
				case 12	 :{stateName = "STATE_LEVEL_PLAY";	}break;
				case 15	 :{stateName = "STATE_UPGRADE";		}break;
				case (-1):{stateName = "STATE_GAME_OVER";	}break;
				case (-3):{stateName = "STATE_LEVEL_OVER";	}break;
				case 99	 :{stateName = "STATE_TEST";		}break;
				
				case 21	 :{stateName = "STATE_LEVEL_1";		}break;
				case 22	 :{stateName = "STATE_LEVEL_2";		}break;
				case 23	 :{stateName = "STATE_LEVEL_3";		}break;
				case 24	 :{stateName = "STATE_LEVEL_4";		}break;
				case 25	 :{stateName = "STATE_END_GAME";	}break;
				
				
			}
			
			var msg:String = "\n"+stateMark+stateName+stateMark+"\n";
			trace(msg);
			Starling.msg = stateName;
		}
		
//--------------------
}}//--- EOF ---
//--------------------




/*










}}



/*

//http://forum.starling-framework.org/topic/drawing-plain-boxes-with-a-border

public static function getBoxWithBorder( ww:int, hh:int, plainColor:int = 0xFFFFFF, borderColor:int = 0x000000, borderThickness:int = 1):QuadBatch {
// create batch
var result : QuadBatch = new QuadBatch();

// create plain color
var center : Quad = new Quad(ww, hh, plainColor);

// create borders
var left : Quad = new Quad(borderThickness, hh, borderColor);
var right : Quad = new Quad(borderThickness, hh, borderColor);

var top : Quad = new Quad(ww, borderThickness, borderColor);
var down : Quad = new Quad(ww, borderThickness, borderColor);

// placing elements (top and left already placed)
right.x = ww - borderThickness;
down.y = hh - borderThickness;

// build box
result.addQuad(center);
result.addQuad(left);
result.addQuad(top);
result.addQuad(right);
result.addQuad(down);	

return result;
}
*/


