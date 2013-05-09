package org.uixml.utils
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class UixmlLoader extends URLLoader
	{
		private var _index:int;
		private var _path:String;
		
		public function UixmlLoader(request:URLRequest = null)
		{
			super(request);
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		public function get path():String
		{
			return _path;
		}
		
		public function set path(value:String):void
		{
			_path = value;
		}
	}
}