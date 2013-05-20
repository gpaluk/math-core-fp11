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
	import io.plugin.math.algebra.AVector;
	import io.plugin.math.base.MathHelper;
	import io.plugin.math.intersection.enum.IntersectionType;
	import io.plugin.math.objects3d.Line3;
	import io.plugin.math.objects3d.Triangle3;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class IntrLine3Triangle3 extends Intersector
	{
		
		private var _line: Line3;
		private var _triangle: Triangle3;
		
		private var _lineParameter: Number;
		private var _triBary0: Number;
		private var _triBary1: Number;
		private var _triBary2: Number;
		
		public function IntrLine3Triangle3( rkLine: Line3,  rkTriangle: Triangle3 ) 
		{
			_line = rkLine;
			_triangle = rkTriangle;
			_lineParameter = 0;
			_triBary0 = 0;
			_triBary1 = 0;
			_triBary2 = 0;
		}
		
		[Inline]
		public final function get line():Line3
		{
			return _line;
		}
		
		[Inline]
		public final function get triangle():Triangle3
		{
			return _triangle;
		}
		
		//virtual
		override public function test():Boolean 
		{
			
			var diff: AVector = _line.origin.subtract( _triangle.v0 );
			var edge1: AVector = _triangle.v1.subtract( _triangle.v0 );
			var edge2: AVector = _triangle.v2.subtract( _triangle.v0 );
			var normal: AVector = edge1.crossProduct( edge2 );
			
			var DdN: Number = _line.direction.dotProduct( normal );
			var sign: Number = 0;
			
			if ( DdN > MathHelper.ZERO_TOLLERANCE )
			{
				sign = 1;
			}
			else if ( DdN < -MathHelper.ZERO_TOLLERANCE )
			{
				sign = -1;
				DdN = -DdN;
			}
			else
			{
				_intersectionType = IntersectionType.EMPTY;
				return false;
			}
			
			var DdQxE2: Number = sign * _line.direction.dotProduct( diff.crossProduct( edge2 ));
			if ( DdQxE2 >= 0 )
			{
				var DdE1xQ: Number = sign * _line.direction.dotProduct( edge1.crossProduct( diff ) );
				if ( DdE1xQ >= 0 )
				{
					if ( DdQxE2 + DdE1xQ <= DdN )
					{
						_intersectionType = IntersectionType.POINT;
						return true;
					}
				}
			}
			
			_intersectionType = IntersectionType.EMPTY;
			return false;
		}
		
		override public function find():Boolean 
		{
			var diff: AVector = _line.origin.subtract( _triangle.v0 );
			var edge1: AVector = _triangle.v1.subtract( _triangle.v0 );
			var edge2: AVector = _triangle.v2.subtract( _triangle.v0 );
			var normal: AVector = edge1.crossProduct( edge2 );
			
			var DdN: Number = _line.direction.dotProduct( normal );
			var sign: Number = 0;
			if ( DdN > MathHelper.ZERO_TOLLERANCE )
			{
				sign = 1;
			}
			else if ( DdN < -MathHelper.ZERO_TOLLERANCE )
			{
				sign = -1;
				DdN = -DdN;
			}
			else
			{
				_intersectionType = IntersectionType.EMPTY;
				return false;
			}
			
			var DdQxE2: Number = sign * _line.direction.dotProduct( diff.crossProduct( edge2 ) );
			if ( DdQxE2 >= 0 )
			{
				var DdE1xQ: Number = sign * _line.direction.dotProduct( edge1.crossProduct( diff ) );
				if ( DdE1xQ >= 0)
				{
					if ( DdQxE2 + DdE1xQ <= DdN )
					{
						var QdN: Number = -sign * diff.dotProduct( normal );
						var inv: Number = 1 / DdN;
						_lineParameter = QdN * inv;
						_triBary1 = DdQxE2 * inv;
						_triBary2 = DdE1xQ * inv;
						_triBary0 = 1 - _triBary1 - _triBary2;
						_intersectionType = IntersectionType.POINT;
						return true;
					}
				}
			}
			return false;
		}
		
		[Inline]
		public final function get lineParameter(): Number
		{
			return _lineParameter;
		}
		
		[Inline]
		public final function get triBary0(): Number
		{
			return _triBary0;
		}
		
		[Inline]
		public final function get triBary1(): Number
		{
			return _triBary1;
		}
		
		[Inline]
		public final function get triBary2(): Number
		{
			return _triBary2;
		}
		
	}

}
