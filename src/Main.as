package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import org.uixml.modules.Viewer;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			var viewer:Viewer = new Viewer();
			addChild(viewer);
		}
		
	}
	
}