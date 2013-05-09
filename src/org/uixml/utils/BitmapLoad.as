package org.uixml.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class BitmapLoad extends Sprite
	{
		public static var BITMAP_COMPLETE:String = "bitmap_complete";
		
		private var _bitmapWidth:Number;
		private var _bitmapHeight:Number;
		private var _loader:Loader;
		
		public function BitmapLoad(path:String, w:Number, h:Number)
		{
			bitmapWidth = w;
			bitmapHeight = h;
			
			_loader = new Loader();
			
			try
			{
				_loader.load(new URLRequest(path));
			}
			catch (error:Error)
			{
				
			}
			
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			var mc:MovieClip = new MovieClip();
			var bitmap:Bitmap = new Bitmap(new BitmapData(1, 1, true, 0));
			mc.addChild(bitmap);
			if (bitmapWidth > 0)
			{
				mc.width = bitmapWidth;
			}
			if (bitmapHeight > 0)
			{
				mc.height = bitmapHeight;
			}
			
			this.addChild(mc);
			mc.content = bitmap;
			dispatchEvent(new Event(BITMAP_COMPLETE, true));
		}
		
		private function loaderComplete(event:Event):void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loaderComplete);
			
			var bitmap:Bitmap = _loader.content as Bitmap;
			bitmap.smoothing = true;
			
			if (bitmapWidth > 0)
			{
				_loader.width = bitmapWidth;
			}
			if (bitmapHeight > 0)
			{
				_loader.height = bitmapHeight;
			}
			
			this.addChild(_loader);
			dispatchEvent(new Event(BITMAP_COMPLETE, true));
		}
		
		public function get loader():Loader
		{
			return _loader;
		}
		
		public function get bitmapWidth():Number
		{
			return _bitmapWidth;
		}
		
		public function set bitmapWidth(value:Number):void
		{
			_bitmapWidth = value;
		}
		
		public function get bitmapHeight():Number
		{
			return _bitmapHeight;
		}
		
		public function set bitmapHeight(value:Number):void
		{
			_bitmapHeight = value;
		}
	}

}