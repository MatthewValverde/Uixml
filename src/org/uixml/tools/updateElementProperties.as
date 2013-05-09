package org.uixml.tools
{
	import org.uixml.elements.UixmlSprite;
	import org.uixml.utils.GlobalAttribute;
	import r1.deval.D;
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public function updateElementProperties(element:*, properties:Object, parent:UixmlSprite):void
	{
		for (var prop:String in properties)
		{
			var propString:String = properties[prop];
			var value:* = properties[prop];
			var pass:Boolean = true;
			
			if ((propString).search("{") >= 0)
			{
				var propStringArray:Array = propString.split(" ");
				propString = String(propStringArray.join(""));
				var pattern:RegExp = /{|}/g;
				var myPattern:RegExp = /(\w*)[.](\w*)/ig;
				var string:String = propString.replace(pattern, "");
				
				if (string.search("global.") >= 0)
				{
					var globalString:String = string.replace("global.", "");
					value = GlobalAttribute[globalString];
					pass = false;
				}
				
				if (string.search("this.") >= 0)
				{
					var tempString:String = string.replace("this.", "");
					if (parent[tempString].search(":") >= 0)
					{
						value = parent[tempString];
						pass = false;
					}
				}
				
				var result:Object = myPattern.exec(string);
				
				while (result != null && pass)
				{
					var array:Array = result.toString().split(",");
					var regexp:RegExp = new RegExp(String(array[0]), "g");
					var object:Object = parent;
					
					for (var q:int = 1; q < array.length; q++)
					{
						if (String(array[q]).search("this") >= 0)
							continue;
						
						object = object[array[q]];
					}
					
					string = string.replace(regexp, String(object));
					result = myPattern.exec(string);
				}
				
				var temp:String = string + ";";
				
				if (pass)
					value = D.evalToNumber("calculate()", D.parseFunctions("function calculate():Number\n{\n" + "return " + temp + "\n};"));
				
				if (pass)
					if (value == 0)
						value = string;
			}
			
			element[prop] = value;
		}
	}
}
