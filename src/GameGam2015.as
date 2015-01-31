package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.utils.Color;
	
	
	[SWF( frameRate="60", wmode='direct', backgroundColor="#000000")]
	public class GameGam2015 extends Sprite	{
		
		
		
		private var masterStarling:Starling;
		
		
		public function GameGam2015(){
			
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			trace("\n\n\n______________G_A_M_E_____G_A_M_______2_0_1_5________\n");
			trace("\t\tStage (",stage.stageWidth,",",stage.stageHeight,")");
			
			//Starling.multitouchEnabled = true; // call PRE creation
			
			var screenWidth:int  = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new Rectangle(0, 0, screenWidth, screenHeight)
			
			masterStarling = new Starling(Game, stage, viewPort);
			masterStarling.stage.stageWidth  = 1024;
			masterStarling.stage.stageHeight = 768;
			
			trace("\t\tScaling Ratio >|",masterStarling.contentScaleFactor); // -> 2
			
			masterStarling.showStats = true;
			//masterStarling.simulateMultitouch = true;
			
			
			masterStarling.stage.color = Color.OLIVE;
			masterStarling.start();
			
			trace("---------------------- MAIN END --------------------------------\n\n");
			
			
		
			
		}
		
		
		
		
		
		
		
//-------------------		
}}//--- EOF ---
//-------------------


/*
// support autoOrients
stage.align 	= StageAlign.TOP_LEFT;
stage.scaleMode = StageScaleMode.NO_SCALE;

}

}
}



*/
