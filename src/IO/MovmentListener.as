package IO
{
	import Assets.Assets;
	
	import Interfaces.IGameState;
	
	import Utils.Utils;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	

	public class MovmentListener extends Sprite implements IGameState
	{
		private var p1toRight:Boolean = new Boolean ;
		private var p1jumping:Boolean = new Boolean ;
		private var p1toLeft:Boolean = new Boolean ;
		private var p1playerInteract:Boolean = new Boolean ;
		private var p2toRight:Boolean = new Boolean ;
		private var p2jumping:Boolean = new Boolean ;
		private var p2toLeft:Boolean = new Boolean ;
		private var p2playerInteract:Boolean = new Boolean ;
		private var move:int = 10;
		private var state:String = "";
		
		public function MovmentListener()
		{
			//trace ("in MovmentListener");
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			
			Starling.current.stage.addEventListener(Event.ENTER_FRAME, myEnterFrame);
			
			
			
			
		}
		
		
		
		public function update():void
		{
			
		}
		
			public function myEnterFrame(e:EnterFrameEvent):void
			{
				
				
				if(state == "next"){
					dispatchEventWith("HeroMovement",true,state);
					state = "null";
					return;
				}
				state = "";
				
				if(p1toRight){
					//trace ("->");
					state += ">";
					
				}
				if(p1toLeft){
					//trace ("<-");
					state += "<";
				}
				if(p1jumping){
					//trace ("^");
					state += "^";
				}
				
				if(p1playerInteract){
					//trace ("using");
					state += "U";
				}
				
				state += "_";
				
				if(p2toRight){
					//trace ("->");
					state += ">";
					
				}
				if(p2toLeft){
					//trace ("<-");
					state += "<";
				}
				if(p2jumping){
					//trace ("^");
					state += "^";
				}
				
				if(p2playerInteract){
					//trace ("using");
					state += "U";
				}
				
				
				dispatchEventWith("HeroMovement",true,state);
			
				
				//trace(state);
			}
			
			
		
		public function destroy():void{
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			Starling.current.stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			
			Starling.current.stage.removeEventListener(Event.ENTER_FRAME, myEnterFrame);
		}
		
		public function handleKeyDown(e:KeyboardEvent):void
		{
			if(e.keyCode == 49){
				state = "next";
			}
			if(e.keyCode == 39 && !p1toRight && !p1toLeft){
				p1toRight = true;
				//trace ("pressed right");
				
			}
			if(e.keyCode == 38 && !p1jumping){
				p1jumping = true;
				//trace ("pressed jump");
			}
			if(e.keyCode == 40 && !p1playerInteract){
				p1playerInteract = true;
				//trace ("interaction started");
			}
			if(e.keyCode == 37 && !p1toLeft && !p1toRight){
				p1toLeft = true;
				//trace ("pressed left");
			}
			
			//Player 2
			
			if(e.keyCode == 68 && !p2toRight && !p2toLeft){
				p2toRight = true;
				//trace ("pressed right");
			}
			if(e.keyCode == 87 && !p2jumping){
				p2jumping = true;
				//trace ("pressed jump");
			}
			if(e.keyCode == 83 && !p2playerInteract){
				p2playerInteract = true;
				//trace ("interaction started");
			}
			if(e.keyCode == 65 && !p2toLeft && !p2toRight){
				p2toLeft = true;
				//trace ("pressed left");
			}
		
		}
		
		public function handleKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode == 39 && p1toRight){
				p1toRight = false;
				//trace ("stopped pressing right");
			}
			if(e.keyCode == 38 && p1jumping){
				p1jumping = false;
				//trace ("stopped pressing jump");
			}
			if(e.keyCode == 40 && p1playerInteract){
				p1playerInteract = false;
				//trace ("interaction ended");
			}
			if(e.keyCode == 37 && p1toLeft){
				p1toLeft = false;
				//trace ("stopped pressing left");
			}
			
			//Player 2
			if(e.keyCode == 68 && p2toRight){
				p2toRight = false;
				//trace ("pressed right");
			}
			if(e.keyCode == 87 && p2jumping){
				p2jumping = false;
				//trace ("pressed jump");
			}
			if(e.keyCode == 83 && p2playerInteract){
				p2playerInteract = false;
				//trace ("interaction started");
			}
			if(e.keyCode == 65 && p2toLeft){
				p2toLeft = false;
				//trace ("pressed left");
			}
		}
		
		
		
		
		
		/*
		private function checkInput(event:KeyboardEvent):void
		{
			//trace(event.keyCode);
			
			switch (event.keyCode) {
				//---------- player 1---------
				case 38 :
					trace (event.keyCode, "player 1 jumps");
					break;
				case 39:
					trace (event.keyCode, "player 1 goes right");
					break;
				case 40:
					trace (event.keyCode, "player 1 down / interacts");
					break;
				case 37:
					trace (event.keyCode, "player 1 goes left");
					break;
				
				//---------- player 2---------
				case 87 :
					trace (event.keyCode, "player 2 jumps");
					break;
				case 68:
					trace (event.keyCode, "player 2 goes right");
					break;
				case 83:
					trace (event.keyCode, "player 2 down / interacts");
					break;
				case 65:
					trace (event.keyCode, "player 2 goes left");
					break;
				
			}
			
			
			
				
					
			
			
		}*/
	}
}