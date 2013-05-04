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
package io.plugin.math.intersection.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class IntersectionType 
	{
		
		public static const EMPTY: IntersectionType = new IntersectionType( "empty", 0 );
		public static const POINT: IntersectionType = new IntersectionType( "point", 1 );
		public static const SEGMENT: IntersectionType = new IntersectionType( "segment", 2 );
		public static const RAY: IntersectionType = new IntersectionType( "ray", 3 );
		public static const LINE: IntersectionType = new IntersectionType( "line", 4 );
		public static const POLYGON: IntersectionType = new IntersectionType( "polygon", 5 );
		public static const PLANE: IntersectionType = new IntersectionType( "plane", 6 );
		public static const POLYHEDRON: IntersectionType = new IntersectionType( "polyhedron", 7 );
		public static const OTHER: IntersectionType = new IntersectionType( "other", 8 );
		
		protected var _type: String;
		protected var _index: int;
		public function IntersectionType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
	}

}