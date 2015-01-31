package Utils
{
	
	import com.reyco1.physinjector.PhysInjector;
	import com.reyco1.physinjector.data.PhysicsObject;
	import com.reyco1.physinjector.data.PhysicsProperties;
	import com.reyco1.physinjector.factory.JointFactory;
	
	import flash.display.MovieClip;
	import flash.display3D.textures.Texture;
	import flash.geom.Point;
	
	import Assets.Assets;
	
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2WeldJoint;
	
	import Interfaces.IGameState;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class PhysMngr extends Sprite implements IGameState {
	
		
		
		public function PhysMngr(){}
		
		public function update():void{}
		public function destroy():void{}
		
		
		
	//********************* CREATING FLOOR ******************************
		private static function create_FloorQuad(parentContainer:DisplayObjectContainer = null,middle:Boolean= false):Quad{
			
			var floor:Quad= new Quad(Starling.current.nativeStage.fullScreenWidth,50,Color.GRAY);
			floor.x = 0;
			
			if (!middle){floor.y = Starling.current.nativeStage.fullScreenHeight - floor.height;}
			else{floor.y = (Starling.current.nativeStage.fullScreenHeight /2) - (floor.height/2);}
			
			
			if (parentContainer){parentContainer.addChild(floor);}
			
			return(floor);
		}
		
		private static function create_MeridianQuad(parentContainer:DisplayObjectContainer = null,middle:Boolean= false):Quad{
			
			var meridian:Quad= new Quad(Starling.current.nativeStage.fullScreenWidth,50,Color.GRAY);
			meridian.x = 0;
			
			if (!middle){meridian.y = Starling.current.nativeStage.fullScreenHeight - meridian.height;}
			else{meridian.y = (Starling.current.nativeStage.fullScreenHeight /2) - (meridian.height/2);}
			
			
			if (parentContainer){parentContainer.addChild(meridian);}
			
			return(meridian);
		}
		
		public static function create_Floor(physics:PhysInjector,parent:DisplayObjectContainer,middle:Boolean= false):PhysicsObject{
			var floorShape	:Quad = create_FloorQuad(parent,middle);
			var floorProps	:PhysicsProperties = props_Quad("floor","floors",false);
			var floorPhysObj:PhysicsObject = injector(physics,floorShape,PhysInjector.SQUARE,floorProps) 
			return(floorPhysObj);
		}
		
		public static function create_Meridian(physics:PhysInjector,parent:DisplayObjectContainer,middle:Boolean= false):PhysicsObject{
			var meridianShape	:Quad = create_FloorQuad(parent,middle);
			var meridianProps	:PhysicsProperties = props_Meridian();
			var meridianPhysObj:PhysicsObject = injector(physics,meridianShape,PhysInjector.SQUARE,meridianProps) 
			return(meridianPhysObj);
		}
		
	//********************* CREATING WALLS ******************************
		
		private static function create_Quad(
			sizeW:int,sizeH:int,
			startingLocation:Point, rotation:Number = 0,
			color:uint = Color.GRAY,alpha:Number = 1,
			parentContainer:DisplayObjectContainer = null
		):Quad{
			
			
			var wall:Quad = new Quad(sizeW,sizeH,color);
			wall.alpha = alpha
				
				
			wall.x = startingLocation.x - wall.width * 0.5;
			wall.y = startingLocation.y;
			wall.rotation = rotation;
			if (parentContainer){parentContainer.addChild(wall);}
			
			return(wall);
		}
		private static function props_Quad(objName:String = "floor",contactGroupName:String = "floors",dynamic:Boolean = false):PhysicsProperties{
			var props:PhysicsProperties = new PhysicsProperties();
			props.isDynamic 	= dynamic;
			props.isDraggable	= true;
			props.friction 		= 1;
			props.restitution 	= 0;
			props.name			= objName;
			props.contactGroup 	= contactGroupName;
			return(props);
		}
		
		private static function props_Meridian():PhysicsProperties{
			var props:PhysicsProperties = new PhysicsProperties();
			props.isDynamic 	= false;
			props.isDraggable	= false;
			props.friction 		= 1;
			props.restitution 	= 0;
			props.allowSleep	= false;
			props.density		= 50000;
			props.isSensor		= false;
			props.name			= "meridian";
			props.contactGroup 	= "meridians";
			return(props);
		}
		
		
		public static function create_Square(
			physics:PhysInjector,parent:DisplayObjectContainer,
			sizeW:int,sizeH:int,
			startingLocation:Point, rotation:Number = 0,
			color:uint = Color.GRAY,alpha:Number = 1,
			objName:String = "plank",contactGroupName:String = "planks",
			dynamic:Boolean = false
		):PhysicsObject{
			
			var squareShape	 :Quad 				= create_Quad(sizeW,sizeH,startingLocation, rotation,color,alpha,parent);
			var squareProps	 :PhysicsProperties = props_Quad(objName,contactGroupName,dynamic);
			var squarePhysObj:PhysicsObject 	= injector(physics,squareShape,PhysInjector.SQUARE,squareProps) 
			
			return(squarePhysObj);
			
		}
		
		//********************* CREATING Joints ******************************
		
		public static function addJoint_Revolution(
			physObj1:PhysicsObject,physObj2:PhysicsObject,
			motorSpeed:Number
		):b2RevoluteJoint{
			
			

			
			var body1:PhysicsObject = physObj1;
			var body2:PhysicsObject = physObj2;
			var anchor1:Point = body1.getDisplayObjectCenterPoint();
			
			var joint:b2RevoluteJoint = JointFactory.createRevoluteJoint(body1.body, body2.body, anchor1, false, false, 0, 360);
			
			joint.SetMaxMotorTorque( motorSpeed+1 );
			joint.SetMotorSpeed(motorSpeed);
			joint.EnableMotor( true );
			
			return(joint);
		}
		
		public static function addJoint_Distance(physObj1:PhysicsObject,physObj2:PhysicsObject):b2DistanceJoint{
			
			var body1:PhysicsObject = physObj1;
			var body2:PhysicsObject = physObj2;
			
			var anchor1:Point = body1.getDisplayObjectCenterPoint();
			var anchor2:Point = body2.getDisplayObjectCenterPoint();
			
			var joint:b2DistanceJoint = JointFactory.createDistanceJoint(body1.body, body2.body, anchor1, anchor2, false);
			return(joint);
		}
		
		public static function addJoint_Weld(physObj1:PhysicsObject,physObj2:PhysicsObject):b2WeldJoint{
			var body1:PhysicsObject = physObj1;
			var body2:PhysicsObject = physObj2;
			
			var joint:b2WeldJoint = JointFactory.createWeldJoint(body1.body, body2.body);
			return(joint);
			
		}
		
		
		public static function addJoint_prismatic(physObj1:PhysicsObject,transPoint:Point,speed:Number):b2PrismaticJoint{
			var dot:PhysicsObject = physObj1;
			
			var anchor:Point = new Point(dot.displayObject.x + 25, dot.displayObject.y + 25 );
			var axis:Point = new Point( 1.0, 0.0 );
			
			var joint:b2PrismaticJoint = JointFactory.createPrismaticJoint(
				PhysInjector.WORLD.GetGroundBody(),//body1.body, 
				dot.body, 
				anchor, 
				axis, 
				transPoint.x,
				transPoint.y,
				false, true, true);
			
			
			
			joint.EnableLimit( true );
			joint.SetMaxMotorForce( speed+1 );
			joint.SetMotorSpeed( speed );
			
			
			return(joint);
		}
		
	//**************************** create BLOCKER *********************************************
		private static function create_BlockerImage(texture:String,startingLocation:Point,parent:DisplayObjectContainer = null):Image{
			var coreBlocker:Image = new Image(Assets.Assets.getInstance().mngr.getTexture(texture));
			coreBlocker.x = startingLocation.x - (coreBlocker.width * 0.5);
			coreBlocker.y = startingLocation.y - (coreBlocker.height * 0.5);
			
			if (parent){parent.addChild( coreBlocker );}
			return(coreBlocker);
		}
		private static function props_Blocker(objName:String = "blocker",contactGroupName:String = "blockers",dynamic:Boolean = true):PhysicsProperties{
			var props:PhysicsProperties = new PhysicsProperties();
			props.isDynamic		= dynamic;
			props.isSensor		= true;
			props.friction		= 0; 
			props.restitution	= 0;
			props.name			= objName;
			props.contactGroup	= contactGroupName;
			props.isBullet		= true;
			return(props);
		}
		
		
		
		public static function create_Blocker(
			physics:PhysInjector,parent:DisplayObjectContainer,
			texture:String,startingLocation:Point,
			static:Boolean = false,
			objName:String = "blocker",contactGroupName:String = "blockers"
		):PhysicsObject{
			
			var coreBlockerImage	:Image = PhysMngr.create_BlockerImage(texture,startingLocation,parent);
			var coreBlockerProps	:PhysicsProperties = props_Blocker(objName,contactGroupName,!static);
			
			var coreBlockerPhysObj	:PhysicsObject = injector(physics,coreBlockerImage,PhysInjector.CIRCLE,coreBlockerProps);
			return(coreBlockerPhysObj);
		}
		
	//--- General functions ---
		private static function injector(physics:PhysInjector,obj:DisplayObject,shape:int,props:PhysicsProperties):PhysicsObject{
			if (obj){return (physics.injectPhysics(obj, shape, props))}else{return(null);}
		}
		
		
		//************** Create Atom **************************
		
		
		private static var JointPrismatc :b2PrismaticJoint; 
		private static var JointRevolute :b2RevoluteJoint;
		
		public static function create_Orbital(
			physics:PhysInjector,parent:DisplayObjectContainer,
			coreTexture	:String, coreStartingPoint	:Point,
			orbitTexture:String, orbitStartingPoint	:Point,
			transLine:Point,transSpeed:Number,
			orbitalSpeed:Number,
			reverse:Boolean = false,
			coreName:String = "core",orbitalName:String = "orbital"
		):b2PrismaticJoint{
			
			var core	:PhysicsObject = PhysMngr.create_Blocker(physics,parent,coreTexture,coreStartingPoint,false,coreName);
			var orbital	:PhysicsObject = PhysMngr.create_Blocker(physics,parent,orbitTexture,orbitStartingPoint,false,orbitalName);
			
			JointPrismatc = PhysMngr.addJoint_prismatic(core,transLine,transSpeed);
			JointRevolute = PhysMngr.addJoint_Revolution(core,orbital,orbitalSpeed);
			
			
			if (reverse){
				core.x		= transLine.y;
				orbital.x 	= transLine.y;
				
				JointPrismatc.SetMotorSpeed(-transSpeed);
			}
			
			JointPrismatc.EnableMotor(true);
			
			
			return(JointPrismatc)
		}
		
		public static function create_Linear(
			physics:PhysInjector,parent:DisplayObjectContainer,
			coreTexture	:String, coreStartingPoint	:Point,
			transLine:Point,transSpeed:Number,
			reverse:Boolean = false,
			coreName:String = "core"
		):b2PrismaticJoint{
			
			var core	:PhysicsObject = PhysMngr.create_Blocker(physics,parent,coreTexture,coreStartingPoint,false,coreName);
			
			JointPrismatc = PhysMngr.addJoint_prismatic(core,transLine,transSpeed);
			
			if (reverse){
				core.x		= transLine.y;
				
				JointPrismatc.SetMotorSpeed(-transSpeed);
			}
			
			JointPrismatc.EnableMotor(true);
			
			
			return(JointPrismatc)
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//----------------------------------- GAME JAM 2015 -------------------------//
		
		
		
		private static function create_heroImage(texture:String,startingLocation:Point,parent:DisplayObjectContainer = null):starling.display.MovieClip{
			var hero:starling.display.MovieClip = new starling.display.MovieClip(Assets.Assets.getInstance().mngr.getTextures(texture),30);
			hero.x = startingLocation.x - (hero.width * 0.5);
			hero.y = startingLocation.y - (hero.height * 0.5);
			
			Starling.juggler.add(hero);
			hero.stop();
			if (parent){parent.addChild( hero );}
			return(hero);
		}
		
		public static function update_heroImage(clip:starling.display.MovieClip,texture:String,startingLocation:Point,parent:DisplayObjectContainer = null):void{
			while(clip.numFrames > 1){
				clip.removeFrameAt(0);
			}
			
			var newTextures:Vector.<starling.textures.Texture> = Assets.Assets.getInstance().mngr.getTextures(texture);
			
			for each (var currtexture:starling.textures.Texture in newTextures) 
			{
				clip.addFrame(currtexture);
			}
			
			clip.removeFrameAt(0);
			
			
			
			clip.play();
			
			
		}
		
		
		
		
		
		private static function props_Hero(objName:String = "hero",contactGroupName:String = "heroes",dynamic:Boolean = true):PhysicsProperties{
			var props:PhysicsProperties = new PhysicsProperties();
			props.isDynamic 	= dynamic;
			props.isDraggable	= true;
			props.isSensor		= false;
			props.friction 		= 1;
			props.restitution 	= 0;
			props.rotationFixed = true;
			props.name			= objName;
			props.contactGroup 	= contactGroupName;
			return(props);
		}
		
		public static function create_Hero(
			physics:PhysInjector,parent:DisplayObjectContainer,
			texture:String,startingLocation:Point,
			static:Boolean = false,
			objName:String = "hero",contactGroupName:String = "heroes"
		):PhysicsObject{
			
			var heroImage	:starling.display.MovieClip = PhysMngr.create_heroImage(texture,startingLocation,parent);
			var heroProps	:PhysicsProperties = props_Hero(objName,contactGroupName);
			
			var heroPhysObj	:PhysicsObject = injector(physics,heroImage,PhysInjector.SQUARE,heroProps);
			return(heroPhysObj);
		}
		
		
		
}}























