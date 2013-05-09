package org.uixml.core
{
	import org.uixml.core.UixmlElements;
	import org.uixml.elements.UixmlSprite;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import org.uixml.utils.UixmlLoader;
	import org.uixml.tools.updateElementProperties;
	import org.uixml.tools.attributesToObject;
	import org.uixml.utils.GlobalAttribute;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public class UixmlCore extends UixmlElements
	{
		public static var COMPLETE:String = "uixml_complete_event";
		protected static var dispatch:EventDispatcher = new EventDispatcher();
		private static var _uixml:XML;
		private static var _uixmlLoader:UixmlLoader;
		private static var _displayList:Array = new Array();
		private static var _uixmlList:Array = new Array();
		private static var _count:int;
		
		public static function load(uixmlPath:String, parent:*, handlerFunction:Function = null):void
		{
			displayList.push(parent);
			_uixmlLoader = new UixmlLoader();
			_uixmlLoader.index = count;
			_uixmlLoader.path = uixmlPath + String(count);
			if (handlerFunction)
			{
				addEventListener(_uixmlLoader.path, handlerFunction);
			}
			_uixmlLoader.addEventListener(Event.COMPLETE, uixmlLoaderComplete);
			_uixmlLoader.load(new URLRequest(uixmlPath));
			count++;
		}
		
		private static function uixmlLoaderComplete(event:Event):void
		{
			var uixmlloader:UixmlLoader = UixmlLoader(event.target);
			uixmlloader.removeEventListener(Event.COMPLETE, uixmlLoaderComplete);
			addToDisplay(new XML(uixmlloader.data), displayList[uixmlloader.index]);
			dispatch.dispatchEvent(new Event(COMPLETE));
			uixmlloader = null;
		}
		
		public static function addToDisplay(uixml:XML, parent:*):void
		{
			var uixmlAttributes:Object = uixml.attributes();
			
			parent.name = uixml.name();
			
			var nameSpaceArray:Array = new Array();
			var attributeIndex:Array = new Array();
			var uixmlNameSpaceDeclarations:Array = uixml.namespaceDeclarations();
			for (var nameString:String in uixmlNameSpaceDeclarations)
			{
				var newNameSpace:Namespace = new Namespace(uixmlNameSpaceDeclarations[nameString]);
				nameSpaceArray.push(newNameSpace);
			}
			
			for (var j:int = 0; j < uixmlAttributes.length(); j++)
			{
				var attributeName:String = String(uixmlAttributes[j].localName());
				
				for (var o:String in nameSpaceArray)
				{
					if (nameSpaceArray[o] == uixmlAttributes[j].namespace())
					{
						var nm:Namespace = new Namespace(nameSpaceArray[o]);
						if (!parent.dictionaryOfTypes)
						{
							parent.dictionaryOfTypes = new Dictionary();
						}
						parent.dictionaryOfTypes[attributeName] = String(nm);
					}
				}
				parent[attributeName] = uixmlAttributes[j];
				attributeIndex.push(attributeName);
				parent.attributeIndex = attributeIndex;
				
				GlobalAttribute[attributeName] = uixmlAttributes[j];
			}
			
			if (!(parent is DisplayObject))
			{
				return;
			}
			
			for (var i:int = 0; i < uixml.children().length(); i++)
			{
				var element:* = new (getDefinitionByName("org.uixml.elements." + String(uixml.child(i).name())) as Class)();
				var propObject:Object = attributesToObject(uixml.child(i).attributes());
				updateElementProperties(element, propObject, parent);
				parent[element.id] = element;
				parent.addChild(element);
				parent.elementList.push({"element": element, "properties": propObject});
			}
		}
		
		public static function addEventListener(p_type:String, p_displayListener:Function, p_useCapture:Boolean = false, p_priority:int = 0, p_useWeakReference:Boolean = false):void
		{
			dispatch.addEventListener(p_type, p_displayListener, p_useCapture, p_priority, p_useWeakReference);
		}
		
		public static function removeEventListener(p_type:String, p_displayListener:Function, p_useCapture:Boolean = false):void
		{
			dispatch.removeEventListener(p_type, p_displayListener, p_useCapture);
		}
		
		static public function get displayList():Array
		{
			return _displayList;
		}
		
		static public function set displayList(value:Array):void
		{
			_displayList = value;
		}
		
		public static function get count():int
		{
			return _count;
		}
		
		public static function set count(value:int):void
		{
			_count = value;
		}
		
		public static function get uixmlList():Array
		{
			return _uixmlList;
		}
		
		public static function set uixmlList(value:Array):void
		{
			_uixmlList = value;
		}
	}
}