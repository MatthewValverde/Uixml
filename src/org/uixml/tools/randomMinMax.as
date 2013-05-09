package org.uixml.tools
{
	/**
	 * ...
	 * @author Matthew C. Valverde
	 */
	
	public function randomMinMax(min:Number, max:Number):Number
	{
		return min + (max - min) * Math.random();
	}

}