package org.uixml.tools
{
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public function attributesToObject(attributes:XMLList):Object
	{
		var object:Object = new Object();
		
		for (var i:int = 0; i < attributes.length(); i++)
		{
			object[String(attributes[i].name())] = String(attributes[i]);
		}
		
		return object;
	}
}