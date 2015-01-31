package Utils{
	import starling.core.Starling;
	import starling.display.Image;
	
	
	public class Utils
	{
		public function Utils(){}
		
		
		//***** Math *****
		
		// including Min, and including Max !!
		public static function randomInRange(minNum:Number, maxNum:Number):Number
		{return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);}
		
	
		//***** Layers *****
		public static function sendToBack (mc:Object):void {mc.parent.setChildIndex(mc, 0);}
		
		public static function bringToFront (mc:Object):void {
			try{mc.parent.setChildIndex(mc, mc.parent.numChildren-1);}
			catch(e:Error){trace("Misc.Utils.Err",e.message);}}
		
		public static function centerImg(img:Image,bufferX:int = 0,bufferY:int = 0):void{
			img.alignPivot();
			img.x = Starling.current.stage.stageWidth	/2 + bufferX;
			img.y = Starling.current.stage.stageHeight	/2 + bufferY;
		}
		
		
		
	
	
	
	
	
		
		//************************************************************************************************************************************************************************
		//														*************************** DEBUG ********* S T A R T ****************
		//************************************************************************************************************************************************************************
		/*
		public static function setupDebugButtons(_game:Game,currLevel:int,maxLevels:int,container:DisplayObjectContainer):void{
				
			
			//#H => /** Creates a new Statistics Box. *//*
			
			Starling.
			//*************************************************************
			var debugBtnA:Button = new Button(
				Texture.fromColor(36,36,0xFFFFcdff),//up
				"A",//text
				Texture.fromColor(36,36,0xFFffcdaa),//down
				Texture.fromColor(36,36,0xFFfffdff),//over
				Texture.fromColor(36,36,0xFFffffff));//disabled
			debugBtnA.x = 1024-(36*1);
			debugBtnA.addEventListener(Event.TRIGGERED,
				function nextTouched():void{
					Starling.msg = "Debug Btn 1";
				}
			);
			container.addChild(debugBtnA);
			//*************************************************************
		
		
			
		}
		
		private static function createButton(letter:String):Button{
			var btn:Button = new Button(
				Texture.fromColor(36,36,0xFFFFffcd),//up
				letter,//text
				Texture.fromColor(36,36,0xFFffaacd),//down
				Texture.fromColor(36,36,0xFFfffffd),//over
				Texture.fromColor(36,36,0xFFffffff)	//disabled
			);
			
			return (btn)
		}
		
		//************************************************************************************************************************************************************************
		//														*************************** DEBUG *********** E N D ***************
		//************************************************************************************************************************************************************************
	
		
		*/
}}//======================== E N D ========= O F =========== F I L E =====================================================================================================