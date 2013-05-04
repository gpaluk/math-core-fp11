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
	public class Segment3 
	{
		
		public var center: APoint;
		public var direction: AVector;
		public var extent: Number;
		
		public var p0: APoint;
		public var p1: APoint;
		
		public function Segment3( center: APoint, direction: AVector, extent: Number ) 
		{
			this.center = center;
			this.direction = direction;
			this.extent = extent;
			
			computeEndPoints();
		}
		
		public static function fromPoints( p0: APoint, p1: APoint ): Segment3
		{
			var center: APoint = p0.add( p1 ).scale( 0.5 );
			var direction: AVector = p1.subtract( p0 );
			var extent: Number = 0.5 * direction.normalize();
			
			return new Segment3( center, direction, extent );
		}
		
		public function computeCenterDirectionExtent(): void
		{
			center = p0.add( p1 ).scale( 0.5 );
			direction = p1.subtract( p0 );
			extent = 0.5 * direction.normalize();
		}
		
		public function computeEndPoints(): void
		{
			p0 = center.subtractAVector( direction.scale( extent ) );
			p1 = center.addAVector( direction.scale( extent ) );
		}
		
	}

}