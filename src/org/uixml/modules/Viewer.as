package org.uixml.modules
{
	import org.uixml.core.Uixml;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Viewer extends Uixml
	{
		public function Viewer()
		{
			super();
		
		}
		
		override protected function createUI():void
		{
			uixml = "library/uixml/modules/viewer.ui.xml";
			//uixml.willAllowResize = false;
			//willAllowResize = false;
		}
	}
}