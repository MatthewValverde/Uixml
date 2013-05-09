package org.uixml.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.uixml.core.UixmlCore;
	import org.uixml.elements.UixmlSprite;
	import flash.filters.DropShadowFilter;
	import org.uixml.text.Fonts;
	Fonts;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class Uixml extends Sprite
	{
		private var _configPath:String;
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _uixml:*;
		private var _uixmlDisplayList:Array = new Array();
		private var _displayCount:int;
		private var _widthDifference:Number;
		private var _heightDifference:Number;
		private var _widthOrg:Number;
		private var _heightOrg:Number;
		private var _willAllowResize:Boolean = true;
		private var _willAllowResizeViaScale:Boolean;
		private var _uixmlIsComplete:Boolean;
		private var _isAdmin:Boolean;
		private var _uixmlConfigOnly:Boolean;
		private var _uixmlName:String;
		private var _dropShadow:DropShadowFilter = new DropShadowFilter(5, 45, 0, .39, 5, 5, 1, 3);
		private var _layoutPath:String;
		
		public static var UIXML_COMPLETE:String = "UIXML_COMPLETE";
		
		public function Uixml()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addedToStage();
			createUI();
			commitUI();
			layoutUI();
			updateUI();
			
			widthDifference = stage.stageWidth - width;
			heightDifference = stage.stageHeight - height;
			
			_widthOrg = stage.stageWidth;
			_heightOrg = stage.stageHeight;
			
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			//trace("width has been updated");
			updateUI();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			updateUI();
		}
		
		public function get uixml():*
		{
			return _uixml;
		}
		;
		
		public function set uixml(path:*):void
		{
			if (path == null)
			{
				if (_uixml is DisplayObject)
				{
					this.removeChild(_uixml);
					_displayCount--;
				}
				_uixml = null;
				return;
			}
			
			if (!uixml && !uixmlConfigOnly)
			{
				//trace("new uixml sprite right here:", uixmlConfigOnly)
				_uixml = new UixmlSprite();
				uixml.width = width;
				uixml.height = height;
				addChildAt(uixml, _displayCount);
				_displayCount++;
			}
			
			if (uixmlConfigOnly)
			{
				_uixml = new Object();
			}
			
			uixml.index = uixmlDisplayList.length;
			uixml.path = path;
			uixmlDisplayList.push(uixml);
			UixmlCore.load(path, uixml, uixmlLoadComplete);
		}
		
		private function uixmlLoadComplete(event:Event):void
		{
			uixmlIsComplete = true;
			UixmlCore.removeEventListener(event.type, uixmlLoadComplete);
			uixmlCompleteHandler();
			dispatchEvent(new Event(UIXML_COMPLETE));
		}
		
		protected function stageResizeHandler(e:Event):void
		{
			stageUpdateUI();
		}
		
		protected function stageUpdateUI():void
		{
			if (!stage)
			{
				return;
			}
			
			if (willAllowResizeViaScale)
			{
				var sx:Number = stage.stageWidth / _widthOrg;
				var sy:Number = stage.stageHeight / _heightOrg;
				
				scaleX = sx;
				scaleY = sy;
			}
			
			if (willAllowResize)
			{
				var widthDiff:Number = stage.stageWidth - widthDifference;
				var heightDiff:Number = stage.stageHeight - heightDifference;
				width = widthDiff;
				height = heightDiff;
			}
		}
		
		public function get uixmlDisplayList():Array
		{
			return _uixmlDisplayList;
		}
		
		public function set uixmlDisplayList(value:Array):void
		{
			_uixmlDisplayList = value;
		}
		
		public function get widthDifference():Number
		{
			return _widthDifference;
		}
		
		public function set widthDifference(value:Number):void
		{
			_widthDifference = value;
		}
		
		public function get heightDifference():Number
		{
			return _heightDifference;
		}
		
		public function set heightDifference(value:Number):void
		{
			_heightDifference = value;
		}
		
		public function get willAllowResize():Boolean
		{
			return _willAllowResize;
		}
		
		public function set willAllowResize(value:Boolean):void
		{
			_willAllowResize = value;
		}
		
		public function get dropShadow():DropShadowFilter
		{
			return _dropShadow;
		}
		
		public function set dropShadow(value:DropShadowFilter):void
		{
			_dropShadow = value;
		}
		
		public function get uixmlIsComplete():Boolean
		{
			return _uixmlIsComplete;
		}
		
		public function set uixmlIsComplete(value:Boolean):void
		{
			_uixmlIsComplete = value;
			updateUI();
		}
		
		public function get isAdmin():Boolean
		{
			return _isAdmin;
		}
		
		public function set isAdmin(value:Boolean):void
		{
			_isAdmin = value;
		}
		
		public function get uixmlConfigOnly():Boolean
		{
			return _uixmlConfigOnly;
		}
		
		public function set uixmlConfigOnly(value:Boolean):void
		{
			_uixmlConfigOnly = value;
		}
		
		public function get configPath():String
		{
			return _configPath;
		}
		
		public function set configPath(value:String):void
		{
			_configPath = value;
		}
		
		public function get willAllowResizeViaScale():Boolean
		{
			return _willAllowResizeViaScale;
		}
		
		public function set willAllowResizeViaScale(value:Boolean):void
		{
			_willAllowResizeViaScale = value;
		}
		
		public function get uixmlName():String
		{
			return _uixmlName;
		}
		
		public function set uixmlName(value:String):void
		{
			_uixmlName = value;
		}
		
		public function get layoutPath():String
		{
			return _layoutPath;
		}
		
		public function set layoutPath(value:String):void
		{
			_layoutPath = value;
		}
		
		protected function addedToStage():void
		{
		}
		
		protected function createUI():void
		{
		}
		
		protected function commitUI():void
		{
		}
		
		protected function layoutUI():void
		{
		}
		
		protected function updateUI():void
		{
		}
		
		protected function uixmlCompleteHandler():void
		{
		}
		
		public function reset():void
		{
		}
		
		public function dispose():void
		{
			if (stage)
			{
				stage.removeEventListener(Event.RESIZE, stageResizeHandler);
			}
		}
	}
}