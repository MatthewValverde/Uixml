package org.uixml.tools
{
	
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public function objectToName(value:*):String
	{
		var pattern:RegExp = /(class)\s|[\[|\]]/g;
		var string:String = String(value).replace(pattern, "");
		string = string.replace(/((?<![A-Z])[A-Z]|[A-Z](?![A-Z]))/g, '_$1');
		return string.slice(1, string.length).toLowerCase();
	}

}