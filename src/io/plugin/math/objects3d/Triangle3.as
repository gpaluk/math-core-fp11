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
	public class Triangle3 
	{
		
		public var v0: APoint;
		public var v1: APoint;
		public var v2: APoint;
		
		public function Triangle3( v0: APoint, v1: APoint, v2: APoint ) 
		{
			this.v0 = v0;
			this.v1 = v1;
			this.v2 = v2;
		}
		
		public function distanceToAPoint( p: APoint ): Number
		{
			var diff: AVector = v0.subtract( p );
			var edge0: AVector = v1.subtract( v0 );
			var edge1: AVector = v2.subtract( v0 );
			
			var a00: Number = edge0.squaredLength;
			var a01: Number = edge0.dotProduct( edge1 );
			var a11: Number = edge1.squaredLength;
			var b0: Number = diff.dotProduct( edge0 );
			var b1: Number = diff.dotProduct( edge1 );
			var c: Number = diff.squaredLength;
			var det: Number = Math.abs( a00 * a11 - a01 * a01 );
			var s: Number = a01 * b1 - a11 * b0;
			var t: Number = a01 * b0 - a00 * b1;
			
			var sqrDistance: Number = 0;
			
			if ( s + t <= det )
			{
				if ( s < 0 )
				{
					if ( t < 0 )
					{
						if ( b0 < 0 )
						{
							if ( -b0 >= a00 )
							{
								sqrDistance = a00 + 2 * b0 + c;
							}
							else
							{
								sqrDistance = c - b0 * b0 / a00;
							}
						}
						else
						{
							if ( b1 >= 0 )
							{
								sqrDistance = c;
							}
							else if ( -b1 >= a11 )
							{
								sqrDistance = a11 + 2 * b1 + c;
							}
							else
							{
								sqrDistance = c - b1 * b1 / a11;
							}
						}
					}
					else
					{
						if ( b1 >= 0 )
						{
							sqrDistance = c;
						}
						else if ( -b1 >= a11 )
						{
							sqrDistance = a11 + 2 * b1 + c;
						}
						else
						{
							sqrDistance = c - b1 * b1 / a11;
						}
					}
				}
				else if ( t < 0 )
				{
					if ( b0 >= 0 )
					{
						sqrDistance = c;
					}
					else if ( -b0 >= a00 )
					{
						sqrDistance = a00 + 2 * b0 + c;
					}
					else
					{
						sqrDistance = b0 * s + c - b0 * b0 / a00;
					}
				}
				else
				{
					var invDet: Number = 1 / det;
					s *= invDet;
					t *= invDet;
					sqrDistance = s * (a00 * s + a01 * t + 2 * b0) + t * (a01 * s + a11 * t + 2 * b1) + c;
				}
			}
			else
			{
				var tmp0: Number = 0;
				var tmp1: Number = 0;
				var numer: Number = 0;
				var denom: Number = 0;
				
				if ( s < 0 )
				{
					tmp0 = a01 + b0;
					tmp1 = a11 + b1;
					
					if ( tmp1 > tmp0 )
					{
						numer = tmp1 - tmp0;
						denom = a00 - 2 * a01 + a11;
						if ( numer >= denom )
						{
							sqrDistance = a00 + 2 * b0 + c;
						}
						else
						{
							s = numer / denom;
							t = 1 - s;
							sqrDistance = s * (a00 * s + a01 * t + 2 * b0) + t * (a01 * s + a11 * t + 2 * b1) + c;
						}
					}
					else
					{
						if ( tmp1 <= 0 )
						{
							sqrDistance = a11 + 2 * b1 + c;
						}
						else if ( b1 >= 0 )
						{
							sqrDistance = c;
						}
						else
						{
							sqrDistance = c - b1 * b1 / a11;
						}
					}
				}
				else if ( t < 0 )
				{
					tmp0 = a01 + b1;
					tmp1 = a00 + b0;
					if ( tmp1 > tmp0 )
					{
						numer = tmp1 - tmp0;
						denom = a00 - 2 * a01 + a11;
						if ( numer >= denom )
						{
							t = 1;
							s = 0;
							sqrDistance = a11 + 2 * b1 + c;
						}
						else
						{
							t = numer / denom;
							s = 1 - t;
							sqrDistance = s * (a00 * s + a01 * t + 2 * b0) + t * (a01 * s + a11 * t + 2 * b1) + c;
						}
					}
					else
					{
						if ( tmp1 <= 0 )
						{
							sqrDistance = a00 + 2 * b0 + c;
						}
						else if ( b0 >= 0 )
						{
							sqrDistance = c;
						}
						else
						{
							sqrDistance = c - b0 * b0 / a00;
						}
					}
				}
				else
				{
					numer = a11 + b1 - a01 - b0;
					if (numer <= 0 )
					{
						sqrDistance = a11 + 2 * b1 + c;
					}
					else
					{
						denom = a00 - 2 * a01 + a11;
						if ( numer >= denom )
						{
							sqrDistance = a00 + 2 * b0 + c;
						}
						else
						{
							s = numer / denom;
							t = 1 - s;
							sqrDistance = s * (a00 * s + a01 * t + 2 * b0) + t * (a01 * s + a11 * t + 2 * b1) + c;
						}
					}
				}
			}
			
			return Math.sqrt( Math.abs( sqrDistance ) );
		}
		
	}

}