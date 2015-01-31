package Assets.PhysShapes
{
	import com.reyco1.physinjector.PhysInjector;
	import com.reyco1.physinjector.data.PhysicsObject;
	
	import flash.utils.Dictionary;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	public class PhysicsData extends Object
	{
		// ptm ratio
		public var ptm_ratio:Number = PhysInjector.WORLD_SCALE;//32;
		
		// the physcis data 
		public var dict:Dictionary;
		
		//
		// bodytype:
		//  b2_staticBody
		//  b2_kinematicBody
		//  b2_dynamicBody
		
		public function createBody(name:String, world:b2World, bodyType:uint, userData:*):b2Body
		{
			var fixtures:Array = dict[name];
			
			var body:b2Body;
			var f:Number;
			
			// prepare body def
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.type = bodyType;
			bodyDef.userData = userData;
			
			// create the body
			body = world.CreateBody(bodyDef);
			
			// prepare fixtures
			for(f=0; f<fixtures.length; f++)
			{
				var fixture:Array = fixtures[f];
				
				var fixtureDef:b2FixtureDef = new b2FixtureDef();
				
				fixtureDef.density=fixture[0];
				fixtureDef.friction=fixture[1];
				fixtureDef.restitution=fixture[2];
				
				fixtureDef.filter.categoryBits = fixture[3];
				fixtureDef.filter.maskBits = fixture[4];
				fixtureDef.filter.groupIndex = fixture[5];
				fixtureDef.isSensor = fixture[6];
				
				if(fixture[7] == "POLYGON")
				{                    
					var p:Number;
					var polygons:Array = fixture[8];
					for(p=0; p<polygons.length; p++)
					{
						var polygonShape:b2PolygonShape = new b2PolygonShape();
						polygonShape.SetAsArray(polygons[p], polygons[p].length);
						fixtureDef.shape=polygonShape;
						
						body.CreateFixture(fixtureDef);
					}
				}
				else if(fixture[7] == "CIRCLE")
				{
					var circleShape:b2CircleShape = new b2CircleShape(fixture[9]);                    
					circleShape.SetLocalPosition(fixture[8]);
					fixtureDef.shape=circleShape;
					body.CreateFixture(fixtureDef);                    
				}                
			}
			
			return body;
		}
		
		
		public function PhysicsData(): void
		{
			dict = new Dictionary();
			
			
			dict["Scene1_ground"] = [
				
				[
					// density, friction, restitution
					2, 0, 0,
					// categoryBits, maskBits, groupIndex, isSensor
					1, 65535, 0, false,
					'POLYGON',
					
					// vertexes of decomposed polygons
					[
						
						[   new b2Vec2(1026/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(755/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(827/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(1026/ptm_ratio, 320/ptm_ratio)  ] ,
						[   new b2Vec2(530/ptm_ratio, 467/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 510/ptm_ratio)  ,  new b2Vec2(606/ptm_ratio, 534/ptm_ratio)  ,  new b2Vec2(532/ptm_ratio, 533/ptm_ratio)  ] ,
						[   new b2Vec2(746/ptm_ratio, 231/ptm_ratio)  ,  new b2Vec2(754/ptm_ratio, 511/ptm_ratio)  ,  new b2Vec2(682/ptm_ratio, 279/ptm_ratio)  ,  new b2Vec2(682/ptm_ratio, 227/ptm_ratio)  ] ,
						[   new b2Vec2(827/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(755/ptm_ratio, 531/ptm_ratio)  ,  new b2Vec2(745/ptm_ratio, 186/ptm_ratio)  ,  new b2Vec2(828/ptm_ratio, 185/ptm_ratio)  ] ,
						[   new b2Vec2(194/ptm_ratio, 486/ptm_ratio)  ,  new b2Vec2(257/ptm_ratio, 448/ptm_ratio)  ,  new b2Vec2(254/ptm_ratio, 486/ptm_ratio)  ] ,
						[   new b2Vec2(2/ptm_ratio, 727/ptm_ratio)  ,  new b2Vec2(30/ptm_ratio, 651/ptm_ratio)  ,  new b2Vec2(26/ptm_ratio, 727/ptm_ratio)  ] ,
						[   new b2Vec2(52/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(194/ptm_ratio, 486/ptm_ratio)  ,  new b2Vec2(194/ptm_ratio, 516/ptm_ratio)  ] ,
						[   new b2Vec2(530/ptm_ratio, 467/ptm_ratio)  ,  new b2Vec2(454/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(682/ptm_ratio, 279/ptm_ratio)  ,  new b2Vec2(754/ptm_ratio, 511/ptm_ratio)  ,  new b2Vec2(608/ptm_ratio, 510/ptm_ratio)  ] ,
						[   new b2Vec2(318/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(257/ptm_ratio, 448/ptm_ratio)  ,  new b2Vec2(194/ptm_ratio, 486/ptm_ratio)  ,  new b2Vec2(52/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 258/ptm_ratio)  ,  new b2Vec2(322/ptm_ratio, 267/ptm_ratio)  ] ,
						[   new b2Vec2(682/ptm_ratio, 279/ptm_ratio)  ,  new b2Vec2(454/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(455/ptm_ratio, 287/ptm_ratio)  ] ,
						[   new b2Vec2(30/ptm_ratio, 651/ptm_ratio)  ,  new b2Vec2(52/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(49/ptm_ratio, 652/ptm_ratio)  ] ,
						[   new b2Vec2(376/ptm_ratio, 451/ptm_ratio)  ,  new b2Vec2(454/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(530/ptm_ratio, 467/ptm_ratio)  ,  new b2Vec2(381/ptm_ratio, 463/ptm_ratio)  ] ,
						[   new b2Vec2(2/ptm_ratio, 727/ptm_ratio)  ,  new b2Vec2(21/ptm_ratio, 258/ptm_ratio)  ,  new b2Vec2(52/ptm_ratio, 516/ptm_ratio)  ,  new b2Vec2(30/ptm_ratio, 651/ptm_ratio)  ] ,
						[   new b2Vec2(21/ptm_ratio, 258/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 727/ptm_ratio)  ,  new b2Vec2(2/ptm_ratio, 31/ptm_ratio)  ,  new b2Vec2(14/ptm_ratio, 31/ptm_ratio)  ] ,
						[   new b2Vec2(318/ptm_ratio, 322/ptm_ratio)  ,  new b2Vec2(454/ptm_ratio, 323/ptm_ratio)  ,  new b2Vec2(376/ptm_ratio, 451/ptm_ratio)  ,  new b2Vec2(257/ptm_ratio, 448/ptm_ratio)  ]
					]
					
				]
				
			];
			
		}
	}
}
import Box2D.Collision.Shapes.b2CircleShape;
import Box2D.Collision.Shapes.b2PolygonShape;
import Box2D.Common.Math.b2Vec2;
import Box2D.Dynamics.b2Body;
import Box2D.Dynamics.b2BodyDef;
import Box2D.Dynamics.b2FixtureDef;
import Box2D.Dynamics.b2World;

