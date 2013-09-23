/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2012
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package io.plugin.math.algebra 
{
	import io.plugin.core.interfaces.ICloneable;
	/**
	 * A homogeneous point represents a point (x,y,z,w) in the three-dimensional space using the Cartesian coordinates
	 * <code>x</code>, <code>y</code>, <code>z</code> and <code>w</code>.
	 * 
	 * @author Gary Paluk
	 */
	public class HPoint implements ICloneable
	{
		/**
		 * The first element of a <code>HPoint</code> object, such as the <code>x</code> coordinate of a point in the three-dimensional space.
		 */
		public var x: Number;
		
		/**
		 * The second element of a <code>HPoint</code> object, such as the <code>y</code> coordinate of a point in the three-dimensional space.
		 */
		public var y: Number;
		
		/**
		 * The third element of a <code>HPoint</code> object, such as the <code>z</code> coordinate of a point in the three-dimensional space.
		 */
		public var z: Number;
		
		/**
		 * The fourth element of a <code>HPoint</code> object (in addition to the <code>x</code>, <code>y</code>, and <code>z</code> properties)
		 * can hold data such as the angle of rotation.
		 */
		public var w: Number;
		
		/**
		 * An homogeneous point represents a point (x,y,z,w) in the three-dimensional space using the Cartesian coordinates x, y, z and w. If you do not specify 
		 * a parameter for the constructor, an <code>APoint</code> Object is created with the elements (0,0,0,0).
		 * 
		 * @param	x	The x component.
		 * @param	y	The y component.
		 * @param	z	The z component.
		 * @param	w	The w component.
		 */
		public function HPoint( x: Number = 0, y: Number = 0, z: Number = 0, w: Number = 0 ) 
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}
		
		/**
		 * Returns a new <code>HPoint</code> object that is an exact copy of the current <code>HPoint</code> object.
		 * 
		 * @return 	A new <code>HPoint</code> object that is an exact copy of the current <code>HPoint</code> object.
		 */
		public function clone(): *
		{
			return new HPoint( x, y, z, w );
		}
		
		/**
		 * Creates and returns an <code>Array</code> containing the x, y, z and w properies of this <code>APoint</code> object.
		 * 
		 * @return	The x, y, z and w components of this <code>HPoint</code> Object as an <code>Array</code>.
		 */
		public function toTuple(): Array
		{
			return [ x, y, z, w ];
		}
		
		/**
		 * Creates and return an <code>Vector</code> containing the x, y, z and w properies of this <code>HPoint</code> object.
		 * 
		 * @return	The x, y, z and w components of this <code>HPoint</code> object as a <code>Vector</code>.
		 */
		public function toVector(): Vector.<Number>
		{
			var v: Vector.<Number> = new Vector.<Number>( 4, true );
			v[ 0 ] = x;
			v[ 1 ] = y;
			v[ 2 ] = z;
			v[ 3 ] = w;
			return v;
		}
		
		/**
		 * Helper method that allows the simultaneous setting of the x, y, z  and w components of this <code>HPoint</code> object.
		 * 
		 * @param	x	The <code>x</code> component.
		 * @param	y	The <code>y</code> component.
		 * @param	z	The <code>z</code> component.
		 * * @param	z	The <code>w</code> component.
		 * 
		 * @return	The resulting <code>HPoint</code> object.
		 */
		public function set( x: Number, y: Number, z: Number, w: Number ): HPoint
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
			return this;
		}
		
		/**
		 * Composes a <code>String</code> representation of <code>this</code> Object.
		 * 
		 * @return	A <code>String</code> representation of the object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object HPoint] (x:" + x.toFixed( 5 ).substr( 0, 7 ) +
								", y:" + y.toFixed( 5 ).substr( 0, 7 ) +
								", z:" + z.toFixed( 5 ).substr( 0, 7 ) +
								", w:" + w.toFixed( 5 ).substr( 0, 7 ) + ")";
		}
		
	}

}