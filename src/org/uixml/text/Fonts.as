package org.uixml.text
{
	import flash.text.Font;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Fonts
	{
		// Arial
		[Embed(source="../../../../lib/fonts/ARIAL.TTF",fontName='ArialFont',fontFamily='font',fontWeight='normal',fontStyle='normal',mimeType='application/x-font-truetype',advancedAntiAliasing='true',embedAsCFF='false',unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public static var ArialFont:Class;
		Font.registerFont(ArialFont);
		
		// Trebuchet
		[Embed(source="../../../../lib/fonts/TREBUCBD.TTF",fontName='TrebuchetFont',fontFamily='font',fontWeight='normal',fontStyle='normal',mimeType='application/x-font-truetype',advancedAntiAliasing='true',embedAsCFF='false',unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public static var TrebuchetFont:Class;
		Font.registerFont(TrebuchetFont);
		
		// GaramondPro
		[Embed(source="../../../../lib/fonts/AGaramondPro-Bold.otf",fontName='GaramondProFont',fontFamily='font',fontWeight='normal',fontStyle='normal',mimeType='application/x-font-truetype',advancedAntiAliasing='true',embedAsCFF='false',unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public static var GaramondProFont:Class;
		Font.registerFont(GaramondProFont);
	}
}