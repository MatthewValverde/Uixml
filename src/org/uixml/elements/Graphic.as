package org.uixml.elements
{
	import flash.display.Sprite;
	import org.uixml.utils.BitmapLoad;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	dynamic public class Graphic extends UixmlSprite
	{
		private var _color:uint;
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			backAlpha = 1;
			updateUI();
		}
		
		private var _backAlpha:Number;
		
		public function get backAlpha():Number
		{
			return _backAlpha;
		}
		
		public function set backAlpha(value:Number):void
		{
			
			_backAlpha = value;
			
			updateUI();
		}
		
		public function Graphic()
		{
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
			
			updateUI();
		}
		
		override protected function updateUI():void
		{
			super.updateUI();
			
			graphics.clear();
			graphics.beginFill(color, backAlpha);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
	}
}