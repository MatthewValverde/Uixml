package org.uixml.elements
{
	import org.uixml.tools.updateElementProperties;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public dynamic class UixmlSprite extends Sprite
	{
		private var _width:Number = 0;
		private var _height:Number = 0;
		private var _id:String = "";
		private var _propertyList:Object = new Object();
		private var _elementList:Array = new Array();
		private var _willAllowResize:Boolean = true;
		private var _willAllowResizeViaScale:Boolean;
		private var attributeIndex:Array;
		public var index:int = 0;
		
		public function UixmlSprite()
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
			
			addedToStage();
			createUI();
			commitUI();
			layoutUI();
			
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
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
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get propertyList():Object
		{
			return _propertyList;
		}
		
		public function set propertyList(value:Object):void
		{
			_propertyList = value;
		}
		
		public function get elementList():Array
		{
			return _elementList;
		}
		
		public function set elementList(value:Array):void
		{
			_elementList = value;
		}
		
		public function get willAllowResize():Boolean
		{
			return _willAllowResize;
		}
		
		public function set willAllowResize(value:Boolean):void
		{
			_willAllowResize = value;
		}
		
		public function get willAllowResizeViaScale():Boolean
		{
			return _willAllowResizeViaScale;
		}
		
		public function set willAllowResizeViaScale(value:Boolean):void
		{
			_willAllowResizeViaScale = value;
		}
		
		protected function stageResizeHandler(e:Event):void
		{
			if (willAllowResize)
				stageUpdateUI();
		}
		
		protected function stageUpdateUI():void
		{
			for (var i:String in elementList)
			{
				if (elementList[i].element)
				{
					updateElementProperties(elementList[i].element, elementList[i].properties, this);
				}
			}
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
	}
}