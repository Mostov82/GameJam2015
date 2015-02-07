package Handlers
{
	import com.reyco1.physinjector.data.PhysicsObject;
	import com.reyco1.physinjector.data.PhysicsProperties;
	
	import flash.geom.Point;
	
	import Assets.Assets;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import Utils.PhysMngr;
	
	import starling.display.MovieClip;
	
	public class HeroObject
	{
		public var object:PhysicsObject;
		public var runSwitch:Boolean;
		private var facing:int = 1;
		private var isIdle:Boolean = false;
		private var isJumping:Boolean = false;
		private var runAnimIdentifier:String = "";
		private var idleAnimIdentifier:String = "";
		
		private var isDescending:Boolean = false;
		
		public function HeroObject(inner:PhysicsObject, runAnimationName:String, idleAnimationName:String)
		{
			object = inner;
			runAnimIdentifier = runAnimationName;
			idleAnimIdentifier = idleAnimationName;
		}
		
		public function move(input:String):void{
			var direction:b2Vec2;
			
			if(input != ""){
				if(isIdle){
					PhysMngr.update_heroImage(object.displayObject, runAnimIdentifier, new Point(object.body.GetPosition().x, object.body.GetPosition().y));
				}
				isIdle = false;
				
				if(String(input).indexOf("<") != -1 || String(input).indexOf(">") != -1){
					runSwitch = false;
					if(String(input).indexOf("<") != -1){
						direction = new b2Vec2(-5,object.body.GetLinearVelocity().y);
						facing = 1;
						(object.displayObject as MovieClip).play();
						(object.displayObject as MovieClip).scaleX = -1;
						/*if(!playingSound){
						playingSound = true;
						
						Assets.Assets.getInstance().mngr.getSound("walk_left_ft").play();
						Starling.juggler.delayCall(function reset():void{
						Assets.Assets.getInstance().mngr.getSound("walk_right_ft").play();
						}, time/2);
						Starling.juggler.delayCall(function reset():void{playingSound = false}, time);
						}*/
					}
					else{
						direction = new b2Vec2(5,object.body.GetLinearVelocity().y);
						facing = -1;
						(object.displayObject as MovieClip).scaleX = 1;
						(object.displayObject as MovieClip).play();
						/*if(!playingSound){
						playingSound = true;
						
						Assets.Assets.getInstance().mngr.getSound("walk_left_ft").play();
						Starling.juggler.delayCall(function reset():void{
						Assets.Assets.getInstance().mngr.getSound("walk_right_ft").play();
						}, time/2);
						Starling.juggler.delayCall(function reset():void{playingSound = false}, time);
						}*/
					}
					
					object.body.SetLinearVelocity(direction);
				}
				else{
					direction = new b2Vec2(0,0);
				}
				
				
				
				if(String(input).indexOf("^") != -1){
					direction = new b2Vec2(0,40);
					object.body.ApplyImpulse(direction,getBodyCenter(object));
					isJumping = true;
				}
				
			}
			else{
				if (!runSwitch){
					runSwitch = true;
					object.body.ApplyImpulse(new b2Vec2(5 * facing,0),getBodyCenter(object));
					
					PhysMngr.update_heroImage(object.displayObject, idleAnimIdentifier, new Point(object.body.GetPosition().x, object.body.GetPosition().y));
					
					isIdle = true;
				}
				
				if(isIdle){
					(object.displayObject as MovieClip).play();
					
				}
			}
		}
		
		private function getBodyCenter(obj:PhysicsObject):b2Vec2{
			var point:b2Vec2 = new b2Vec2(
				(obj.displayObject.width/2),
				(obj.displayObject.height/2)
			);
			
			var center:b2Vec2 = obj.body.GetWorldCenter();
			
			
			var point2:b2Vec2 = new b2Vec2(
				obj.x,obj.y
			);
			
			return(center);
		}
	}
}