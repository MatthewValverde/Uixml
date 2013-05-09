package org.uixml.elements
{
	import flash.display.Sprite;
	import org.uixml.utils.BitmapLoad;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Image extends UixmlSprite
	{
		private var _absolutePath:String;
		private var _isGameLibrary:Boolean;
		
		private var _colorTint:uint;
		private var _src:String;
		
		private var _center:Boolean;
		private var _scalePoint:Point;
		private var _scaleHeightTo:Number = 0;
		private var _scaleWidthTo:Number = 0;
		
		public function get src():String
		{
			return _src;
		}
		
		public function set src(value:String):void
		{
			if (value == "")
			{
				return;
			}
			
			_src = value;
			
			var bitmap:BitmapLoad = new BitmapLoad(src, width, height);
			addChild(bitmap);
			
			addEventListener(BitmapLoad.BITMAP_COMPLETE, bitmapComplete, true);
		}
		
		public function get absolutePath():String
		{
			return _absolutePath;
		}
		
		public function set absolutePath(value:String):void
		{
			_absolutePath = value;
		}
		
		public function get isGameLibrary():Boolean
		{
			return _isGameLibrary;
		}
		
		public function set isGameLibrary(value:Boolean):void
		{
			_isGameLibrary = value;
		}
		
		public function get colorTint():uint
		{
			return _colorTint;
		}
		
		public function set colorTint(value:uint):void
		{
			_colorTint = value;
			var thisTransform:ColorTransform = new ColorTransform();
			thisTransform.color = value;
			this.transform.colorTransform = thisTransform;
		}
		
		public function Image(width:Number = 0, height:Number = 0)
		{
			this.width = width;
			this.height = height;
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function bitmapComplete(event:Event):void
		{
			if (width == 0 && !scalePoint)
			{
				width = event.target.width;
			}
			if (height == 0 && !scalePoint)
			{
				height = event.target.height;
			}
			
			if (scalePoint && ((scalePoint.x < event.target.width) || (scalePoint.y < event.target.height)))
			{
				var scale:Number = (scalePoint.x / event.target.width) > (scalePoint.y / event.target.height) ? (scalePoint.y / event.target.height) : (scalePoint.x / event.target.width);
				
				event.target.scaleX = scale;
				event.target.scaleY = scale;
				
				width = event.target.width;
				height = event.target.height;
			}
			
			if (!center)
			{
				return;
			}
			
			event.target.x = 0 - (event.target.width / 2);
			event.target.y = 0 - (event.target.height / 2);
		}
		
		public function get center():Boolean
		{
			return _center;
		}
		
		public function set center(value:Boolean):void
		{
			_center = value;
		}
		
		public function get scalePoint():Point
		{
			return _scalePoint;
		}
		
		public function set scalePoint(value:Point):void
		{
			_scalePoint = value;
		}
		
		public function get scaleHeightTo():Number
		{
			return _scaleHeightTo;
		}
		
		public function set scaleHeightTo(value:Number):void
		{
			_scaleHeightTo = value;
			scaleTo(scaleWidthTo, scaleHeightTo);
		}
		
		public function get scaleWidthTo():Number
		{
			return _scaleWidthTo;
		}
		
		public function set scaleWidthTo(value:Number):void
		{
			_scaleWidthTo = value;
			scaleTo(scaleWidthTo, scaleHeightTo);
		}
		
		public function scaleTo(width:Number, height:Number):void
		{
			scalePoint = new Point(width, height);
		}
	}
}