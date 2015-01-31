package GameStates{
	import com.reyco1.physinjector.PhysInjector;
	import com.reyco1.physinjector.data.PhysicsObject;
	import com.reyco1.physinjector.data.PhysicsProperties;
	
	import flash.geom.Point;
	
	import Assets.Assets;
	import Assets.PhysShapes.PhysicsData;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	
	import IO.MovmentListener;
	
	import Interfaces.IGameState;
	
	import Utils.PhysMngr;
	import Utils.Utils;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	
	public class Level1 extends Sprite implements IGameState{
		
		private var _game:Game;
		
		private var physics:PhysInjector;
		private var meridian:PhysicsObject;
		private var heroUp:PhysicsObject;
		private var heroDown:PhysicsObject;
		
		public function Level1(g:Game){
			
			_game = g;
			
	//~--===<|	
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}private function onAddedToStage():void{
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	//~--===<|
			
		var opening:Image = new Image(Assets.Assets.getInstance().mngr.getTexture("Scene1_Sky"));
		opening.scaleX = opening.scaleY = 5;
		Utils.Utils.centerImg(opening);
		addChild(opening); 
		
		initPhysics();
		
		
		keyListener = new MovmentListener();
		keyListener.addEventListener("HeroMovement",handleHero);
			trace("level 1");
			
			
			
		}
		private var keyListener:MovmentListener;
		private function handleHero(e:Event, data:String):void{
			(heroUp.displayObject as MovieClip).pause();
			(heroDown.displayObject as MovieClip).pause();
			if(data == "next"){
				trace("btn pressed");
				EndLevel();
			}
			else{
				var arr:Array = data.split("_");
				var direction:b2Vec2;
				var time:Number = Assets.Assets.getInstance().mngr.getSound("walk_left_ft").length / 1000;
				if(arr[0] != ""){
					if(HeroUpIdle){
						PhysMngr.update_heroImage(heroUp.displayObject, "player_up_run_", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
					}
					HeroUpIdle = false;
					
					if(String(arr[0]).indexOf("<") != -1 || String(arr[0]).indexOf(">") != -1){
						runSwitch = false;
						if(String(arr[0]).indexOf("<") != -1){
							direction = new b2Vec2(-5,heroUp.body.GetLinearVelocity().y);
							HeroUpDirection = 1;
							(heroUp.displayObject as MovieClip).play();
							(heroUp.displayObject as MovieClip).scaleX = -1;
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
							direction = new b2Vec2(5,heroUp.body.GetLinearVelocity().y);
							HeroUpDirection = -1;
							(heroUp.displayObject as MovieClip).scaleX = 1;
							(heroUp.displayObject as MovieClip).play();
							/*if(!playingSound){
								playingSound = true;
								
								Assets.Assets.getInstance().mngr.getSound("walk_left_ft").play();
								Starling.juggler.delayCall(function reset():void{
									Assets.Assets.getInstance().mngr.getSound("walk_right_ft").play();
								}, time/2);
								Starling.juggler.delayCall(function reset():void{playingSound = false}, time);
							}*/
						}
						
						heroUp.body.SetLinearVelocity(direction);
					}
					else{
						direction = new b2Vec2(0,0);
					}
					
					
					
					if(String(arr[0]).indexOf("^") != -1){
						direction = new b2Vec2(0,40);
						heroUp.body.ApplyImpulse(direction,getBodyCenter(heroUp));
						HeroUpJumping = true;
					}
					
				}
				else{
					if (!runSwitch){
						runSwitch = true;
						heroUp.body.ApplyImpulse(new b2Vec2(5 * HeroUpDirection,0),getBodyCenter(heroUp));
						
						PhysMngr.update_heroImage(heroUp.displayObject, "player_up_idle", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
						
						HeroUpIdle = true;
					}
					
					if(HeroUpIdle){
						(heroUp.displayObject as MovieClip).play();
						
					}
				}
				
				if(HeroUpJumping){
					if(heroUp.body.GetLinearVelocity().y > 0){
						PhysMngr.update_heroImage(heroUp.displayObject, "player_up_jump_up", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
						(heroUp.displayObject as MovieClip).fps = 6;
					}
					if(heroUp.body.GetLinearVelocity().y == 0){
						
						if(heroUpDescending){
							PhysMngr.update_heroImage(heroUp.displayObject, "player_up_idle", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
							(heroUp.displayObject as MovieClip).fps = 30;
							runSwitch = true;
							HeroUpIdle = true;
							HeroUpJumping = false;
						}
						else{
							PhysMngr.update_heroImage(heroUp.displayObject, "player_up_jump_middle", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
							(heroUp.displayObject as MovieClip).fps = 3;
						}
					}
					if(heroUp.body.GetLinearVelocity().y < 0){
						PhysMngr.update_heroImage(heroUp.displayObject, "player_up_jump_down", new Point(heroUp.body.GetPosition().x, heroUp.body.GetPosition().y));
						(heroUp.displayObject as MovieClip).fps = 6;
						heroUpDescending = true;
					}
				}
				
				if(arr[1] != ""){
					
					if(String(arr[1]).indexOf("<") != -1 || String(arr[1]).indexOf(">") != -1){
						runSwitch2 = false;
						if(String(arr[1]).indexOf("<") != -1){
							direction = new b2Vec2(-5,heroDown.body.GetLinearVelocity().y);
							(heroDown.displayObject as MovieClip).play();
							(heroDown.displayObject as MovieClip).scaleX = -1;
							HeroDownDirection = 1;
							if(!playingSound){
								playingSound = true;
								
								Assets.Assets.getInstance().mngr.getSound("walk_left_ft").play();
								Starling.juggler.delayCall(function reset():void{
									Assets.Assets.getInstance().mngr.getSound("walk_right_ft").play();
								}, time/2);
								Starling.juggler.delayCall(function reset():void{playingSound = false}, time);
							}
						}
						else{
							direction = new b2Vec2(5,heroDown.body.GetLinearVelocity().y);
							(heroDown.displayObject as MovieClip).scaleX = 1;
							(heroDown.displayObject as MovieClip).play();
							HeroDownDirection = -1;
							if(!playingSound){
								playingSound = true;
								
								Assets.Assets.getInstance().mngr.getSound("walk_left_ft").play();
								Starling.juggler.delayCall(function reset():void{
									Assets.Assets.getInstance().mngr.getSound("walk_right_ft").play();
								}, time/2);
								Starling.juggler.delayCall(function reset():void{playingSound = false}, time);
							}
						}
					}
					else{
						direction = new b2Vec2(0,0);
					}
					
					heroDown.body.SetLinearVelocity(direction);
					
					if(String(arr[1]).indexOf("^") != -1){
						direction = new b2Vec2(0,20);
						heroDown.body.ApplyImpulse(direction,getBodyCenter(heroDown));
						
					}
					
				}
				else{
					if (!runSwitch2){
						runSwitch2 = true;
						heroDown.body.ApplyImpulse(new b2Vec2(5 * HeroDownDirection,0),getBodyCenter(heroDown));
						heroDown.body.SetLinearVelocity(new b2Vec2(0,0));
					}
				}
				
			}
		}
		
		private var runSwitch:Boolean = true;
		private var runSwitch2:Boolean = false;
		private var HeroUpDirection:int = 1;
		private var HeroDownDirection:int = 1;
		private var HeroUpIdle:Boolean = false;
		private var HeroUpJumping:Boolean = false;
		private var playingSound:Boolean = false;
		private var heroUpDescending:Boolean = false;
		private function EndLevel():void{
			_game.changeState(Game.STATE_LEVEL_2);
		}
		
		
		public function update():void{
			physics.update();
			
			
			if (worldA && worldB){
				
				for each (var worldA_Body:PhysicsObject in worldA){
					worldA_Body.body.ApplyForce(worldA_Gravity,getBodyCenter(worldA_Body)); 
				}
				for each (var worldB_Body:PhysicsObject in worldB){
					worldB_Body.body.ApplyForce(worldB_Gravity,getBodyCenter(worldB_Body));
					
				}	
			}
			
			
		}
		public function destroy():void{
		
		}
		
		
		public function initPhysics():void{
			
			addPhysicsWorld();
			meridian = PhysMngr.create_Meridian(physics,this,true);
			
			var floorImage:Image = new Image(Assets.Assets.getInstance().mngr.getTexture("Scene1_ground"));
			addChild(floorImage);
			
			var props:PhysicsProperties = new PhysicsProperties();
			props.friction = 0.2;
			props.restitution = 0.2;
			props.isDynamic =false;
			props.density = 2;
			props.physicsEditorClass = PhysicsData;
			props.physicsEditorName = "Scene1_ground";
			
			var floorBody:b2Body = physics.createFromPhysicsEditor(0,0,props);
			
			worldA = null;
			worldA = new Vector.<PhysicsObject>;
			worldB = null;
			worldB = new Vector.<PhysicsObject>;
			
			//worldA.push(PhysMngr.create_Square(physics,this,50,50,new Point(400,100),0,Color.GREEN,0.5,"box","boxs",true));
			//worldB.push(PhysMngr.create_Square(physics,this,50,50,new Point(400,668),0,Color.GREEN,0.5,"box","boxs",true));
			
			heroUp = PhysMngr.create_Hero(physics,this,"player_up_run_",new Point(400,100));
			heroDown = PhysMngr.create_Hero(physics,this,"player_down_run_",new Point(400,668));
			
			worldA.push(heroUp);
			worldB.push(heroDown);
			
			worldB[0].displayObject.scaleY = -1;
		}
		
		private var worldA:Vector.<PhysicsObject> = new Vector.<PhysicsObject>;
		private var worldB:Vector.<PhysicsObject> = new Vector.<PhysicsObject>;
		
		private static const worldA_Gravity:b2Vec2 = new b2Vec2(0,10);
		private static const worldB_Gravity:b2Vec2 = new b2Vec2(0,-10);
		
		private function addPhysicsWorld():void{				
			if(physics){physics.dispose();}
			if (!physics){
				PhysInjector.STARLING = true;
				physics = new PhysInjector(Starling.current.nativeStage, new b2Vec2(0, 0), false);
				physics.setGravity(0,0);
				physics.allowDrag = true;
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
		
//---------------------		
}}//--- EOF ---
//---------------------