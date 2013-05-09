package org.uixml.elements
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	dynamic public class Config extends Sprite
	{
		private var _id:String;
		
		public function Config()
		{
			super();
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
	
	}

}