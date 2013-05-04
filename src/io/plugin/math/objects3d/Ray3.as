/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2013
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package io.plugin.math.objects3d 
{
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Ray3 
	{
		
		public var origin: APoint;
		public var direction: AVector;
		
		public function Ray3( origin: APoint, direction: AVector ) 
		{
			this.origin = origin;
			this.direction = direction;
		}
		
		public function toString(): String
		{
			return "Origin: " + origin.toString() + " \nDirection: " + direction.toString();
		}
		
	}

}