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
package io.plugin.math.intersection 
{
	import io.plugin.math.intersection.enum.IntersectionType;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Intersector 
	{
		
		protected var _intersectionType: IntersectionType;
		protected var _contactTime: Number;
		
		// abstract
		public function Intersector() 
		{
			_contactTime = 0;
			_intersectionType = IntersectionType.EMPTY;
		}
		
		// virtual
		public function test(): Boolean
		{
			throw new Error( "Function not yet implemented." );
		}
		
		// virtual
		public function find(): Boolean
		{
			throw new Error( "Function not yet implemented." );
		}
		
		[Inline]
		public final function get contactTime(): Number
		{
			return _contactTime;
		}
		
		[Inline]
		public final function get intersectionType(): IntersectionType
		{
			return _intersectionType;
		}
		
	}

}