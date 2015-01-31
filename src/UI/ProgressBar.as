package UI{
	
    import flash.display.BitmapData;
    import flash.display.Shape;
    
    import starling.core.Starling;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.textures.Texture;
    

    public class ProgressBar extends Sprite
    {
        private var mBar:Quad;
        private var mBackground:Image;

        public function ProgressBar(locX:int,locY:int,width:int, height:int,bkColor:uint,barColor:uint) {
			init(locX,locY,width, height,bkColor,barColor);
		}
        
        private function init(locX:int,locY:int,width:int, height:int,bkColor:uint,barColor:uint):void {
			
			
            var scale:Number = Starling.contentScaleFactor;
            var padding:Number = height * 0.2;
            var cornerRadius:Number = padding * scale * 2;
            
            // create black rounded box for background
            var bgShape:Shape = new Shape();
            bgShape.graphics.beginFill(bkColor, 0.7);
            bgShape.graphics.drawRoundRect(0, 0, width*scale, height*scale, cornerRadius, cornerRadius);
            bgShape.graphics.endFill();

            var bgBitmapData:BitmapData = new BitmapData(width*scale, height*scale, true,bkColor);
            bgBitmapData.draw(bgShape);

            var bgTexture:Texture = Texture.fromBitmapData(bgBitmapData, false, false, scale);
            mBackground = new Image(bgTexture);
			
			mBackground.x = locX;
			mBackground.y = locY;
			
			
            addChild(mBackground);
			
			
			  // create progress bar quad
            mBar = new Quad(width - 2*padding, height - 2*padding, 0xeeeeee);
            mBar.setVertexColor(2, barColor);
            mBar.setVertexColor(3, barColor);
            
			mBar.x = locX +padding;
			mBar.y = locY +padding;
            mBar.scaleX = 0;
			addChild(mBar);
			
			
        }
        
        public function get ratio():Number { 
			return mBar.scaleX; 
		}
		
        public function set ratio(value:Number):void { 
			//trace("ratio = ",value);
          	mBar.scaleX = Math.max(0.0, Math.min(1.0, value));
		}
		
    }
}
