package Assets
{

	public class EmbeddedAssets
	{
		
		/* PNG texture 
		[Embed(source="/textures/bird.png")]
		public static const bird:Class;
		*/
		/* ATF texture 
		[Embed(source = "textures/1x/atlas.atf", mimeType="application/octet-stream")]
		public static const atlas:Class;
		*/
		/* XML file 
		[Embed(source="textures/1x/atlas.xml", mimeType="application/octet-stream")]
		public static const atlas_xml:Class;
		*/
		/* MP3 sound 
		[Embed(source="/audio/explosion.mp3")]
		public static const explosion:Class;
		*/
		
		
		
		[Embed(source="/Assets/Heroes/player_up_runXml.xml", mimeType="application/octet-stream")]	public static const player_up_runXml:Class;
		[Embed(source="/Assets/Heroes/player_up_runSheet.png")]										public static const player_up_runSheet:Class;
		
	
		//-------------------------------paste in "EmbeddedAssets":-----------------------
		
		
		[Embed(source="/Assets/Sounds/Button_hover.mp3")] 					public static const Button_hover:Class;
		[Embed(source="/Assets/Sounds/Button_press.mp3")] 					public static const Button_press:Class;
		[Embed(source="/Assets/Sounds/Fountain_loop.mp3")] 					public static const Fountain_loop:Class;
		[Embed(source="/Assets/Sounds/leaves_rustle_loopable.mp3")] 		public static const leaves_rustle_loopable:Class;
		[Embed(source="/Assets/Sounds/rock_step.mp3")] 						public static const rock_step:Class;
		[Embed(source="/Assets/Sounds/rope_creak.mp3")] 					public static const rope_creak:Class;
		[Embed(source="/Assets/Sounds/walk_left_ft.mp3")] 					public static const walk_left_ft:Class;
		[Embed(source="/Assets/Sounds/walk_right_ft.mp3")] 					public static const walk_right_ft:Class;
		[Embed(source="/Assets/Sounds/Wind_loopable.mp3")] 					public static const Wind_loopable:Class;
		[Embed(source="/Assets/Sounds/wooden_gate_rising_long.mp3")] 		public static const wooden_gate_rising_long:Class;
		[Embed(source="/Assets/Sounds/wooden_gate_rising_short.mp3")] 		public static const wooden_gate_rising_short:Class;
		[Embed(source="/Assets/Sounds/wooden_rigging_creak.mp3")] 			public static const wooden_rigging_creak:Class;
		
		
		
		
		//-------------------------------play evample:-----------------------
		
		//Assets.Assets.getInstance().mngr.playSound("Button_hover");
		[Embed(source="/Assets/BackGrounds/Scene1_Sky.png")]	public static const Scene1_Sky:Class;
		[Embed(source="/Assets/PhysShapes/Scene1_ground.png")]		public static const Scene1_ground:Class;
	}
}

/*

, mimeType="application/octet-stream" means that you are about to embed file as a raw byte array, 
so with a new operator you will get this bytes rather than string, but you always can convert it to XML:

var bytes:ByteArray = new atlasXMLBytes();
trace( "bytes.length = ", bytes.length );

//read the whole file as UTF string and convert it to the XML
var xml:XML = new XML( bytes.readUTFBytes( bytes.bytesAvailable ) );
trace("xml= "+xml)

*/