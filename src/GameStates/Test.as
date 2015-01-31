package GameStates{
	import com.reyco1.physinjector.PhysInjector;
	import com.reyco1.physinjector.data.PhysicsObject;
	
	import flash.geom.Point;
	
	
	import Box2D.Common.Math.b2Vec2;
	
	import Interfaces.IGameState;
	
	import Utils.PhysMngr;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.Color;
	
	
	public class Test extends Sprite implements IGameState{
		
		private var _game:Game;
		private var physics:PhysInjector;
		
		private var meridian:PhysicsObject;
		
		public function Test(g:Game){
			_game = g;
			
			
			
	//~--===<|	
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}private function onAddedToStage():void{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	//~--===<|
			
			Starling.msg = "__TEST_STATE__"
				
			addPhysicsWorld();
			
			meridian = PhysMngr.create_Meridian(physics,this,true);
			
			
			
			worldA = null;
			worldA = new Vector.<PhysicsObject>;
			worldB = null;
			worldB = new Vector.<PhysicsObject>;
			
			worldA.push(PhysMngr.create_Square(physics,this,50,50,new Point(400,100),0,Color.GREEN,0.5,"box","boxs",true));
			worldB.push(PhysMngr.create_Square(physics,this,50,50,new Point(400,668),0,Color.GREEN,0.5,"box","boxs",true));
			
		
		}
		
		
		private var worldA:Vector.<PhysicsObject> = new Vector.<PhysicsObject>;
		private var worldB:Vector.<PhysicsObject> = new Vector.<PhysicsObject>;
		
		private static const worldA_Gravity:b2Vec2 = new b2Vec2(0,60);
		private static const worldB_Gravity:b2Vec2 = new b2Vec2(0,-60);
		
		private function addPhysicsWorld():void{				
			if(physics){physics.dispose();}
			if (!physics){
				PhysInjector.STARLING = true;
				physics = new PhysInjector(Starling.current.nativeStage, new b2Vec2(0, 0), false);
				physics.setGravity(0,0);
				physics.allowDrag = true;
			}
		}
		
		public function update():void{
			physics.update();
		
		
			if (worldA && worldB){
				for each (var worldA_Body:PhysicsObject in worldA){
					worldA_Body.body.ApplyForce(worldA_Gravity,worldA_Body.body.GetWorldCenter()); 
				}
				for each (var worldB_Body:PhysicsObject in worldB){
					worldB_Body.body.ApplyForce(worldB_Gravity,worldB_Body.body.GetWorldCenter());
					
				}	
			}
		}
		public function destroy():void{}
		
//------------------	
}}//--- EOF ---
//------------------