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
	import io.plugin.core.interfaces.IDisposable;
	/**
	 * A homogeneneous representation of a plane in the three-dimensional space using the Cartesian coordinates x, y, and z.
	 * 
	 * @author Gary Paluk
	 */
	public class HPlane implements IDisposable, ICloneable
	{
		/**
		 * The normal property.
		 */
		private var mNormal: AVector;
		
		/**
		 * The constant property.
		 */
		private var mConstant: Number;
		
		/**
		 * Disposed flag.
		 */
		private var mIsDisposed: Boolean;
		
		/**
		 * Constructor function
		 * 
		 * @param	normal	The <code>HPlane</code> normal vector.
		 * @param	constant	The <code>HPlane</code> constant.
		 */
		public function HPlane( normal: AVector, constant: Number = 0 ) 
		{
			mNormal = normal;
			mConstant = -constant;
			
			mIsDisposed = false;
		}
		
		/**
		 * Creates and returns a new <code>HPlane</code> object from 3 <code>HPlane</code> objects.
		 * 
		 * @param	p0	The first APoint.
		 * @param	p1	The second APoint.
		 * @param	p2	The third APoint.
		 * 
		 * @return	The resulting <code>HPlane</code> object.
		 */
		public static function fromAPoints( p0: APoint, p1: APoint, p2: APoint ): HPlane
		{
			
			var edge1: AVector = p1.subtract( p0 );
			var edge2: AVector = p2.subtract( p0 );
			var normal: AVector = edge1.unitCrossProduct( edge2 );
			
			var constant: Number = -p0.dotProduct( normal );
			
			return new HPlane( normal, constant );
		}
		
		/**
		 * Gets a <code>Boolean</code> indicating if the <code>dispose()</code> method has been called and subsequently sets the isDisposed property to <code>true</code>.
		 */
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		/**
		 * Disposes of this objects and frees the object ready for garbage collection.
		 */
		public function dispose(): void
		{
			mNormal.dispose();
			mNormal = null;
			
			mIsDisposed = true;
		}
		
		/**
		 * Helper method that allows the simultaneous setting of the normal and constant components of this <code>HPlane</code> Object.
		 * 
		 * @param	normal	The <code>HPlane</code> normal.
		 * @param	constant	The <code>HPlane</code> constant.
		 * 
		 * @return	The resulting <code>HPlane</code> Object.
		 */
		public function set( normal: AVector, constant: Number ): HPlane
		{
			mNormal = normal;
			mConstant = -constant;
			return this;
		}
		
		/**
		 * Define a <code>Plane</code> Object and assign the result to <code>this</code> Object.
		 * 
		 * @param	p0	The first <code>APoint</code> Object.
		 * @param	p1	The second <code>APoint</code> Object.
		 * @param	p2	The third <code>APoint</code> Object.
		 * 
		 * @return	<code>this</code> Object as a new <code>HPlane</code> defined by three <code>APoint</code> Objects.
		 */
		public function fromPoints( p0: APoint, p1: APoint, p2: APoint ): HPlane
		{
			var edge1: AVector = p1.subtract( p0 );
			var edge2: AVector = p2.subtract( p0 );
			mNormal = edge1.crossProduct( edge2 );
			mConstant = -p0.dotProduct( mNormal );
			
			return this;
		}
		
		/**
		 * Creates a shallow clone of this object is created passing the normal and constant properties to the clone.
		 * 
		 * @return	A new shallow clone of this <code>Object</code>
		 */
		public function clone(): *
		{
			return new HPlane( mNormal, mConstant );
		}
		
		/**
		 * Get the normal of the <code>HPlane</code> Object.
		 * 
		 * @return	The normal of the <code>HPlane</code> Object.
		 */
		[Inline]
		public final function get normal(): AVector
		{
			return mNormal;
		}
		
		/**
		 * Set the normal of the <code>HPlane</code> Object.
		 * 
		 * @param	normal	A normal to define the direction on the <code>Hplane</code> Object.
		 */
		[Inline]
		public final function set normal( normal: AVector ): void
		{
			mNormal = normal;
		}
		
		/**
		 *  Get the <code>Number</code> constant of the <code>HPlane</code> Object.
		 * 
		 * @return	The <code>Number</code> constant of the <code>HPlane</code> Object.
		 */
		[Inline]
		public final function get constant(): Number
		{
			return mConstant;
		}
		
		/**
		 * Set the <code>Number</code> constant of the <code>HPlane</code> Object.
		 * 
		 * @param	constant	The <code>Number</code> constant of the <code>HPlane</code> Object.
		 */
		[Inline]
		public final function set constant( constant: Number ): void
		{
			mConstant = -constant;
		}
		
		/**
		 * Normalize the <code>HPlane</code> Object that it's width and depth are of length 1 and set the result to <code>this</code> Object.
		 * 
		 * @param	epsilon	A rounding value used to clamp a lower limit. If the length of the <code>HPlane</code> is less
		 * than that of the epsilon value. The <code>HPlane</code> length is the square root of all normal element lengths as;
		 * <code>Math.sqrt( n.x * n.x + n.y * n.y + n.z * n.z )</code>.
		 * 
		 * @return	The resulting length of the normalize operation.
		 */
		public function normalize( epsilon: Number = 1e-8 ): Number
		{
			var length: Number = Math.sqrt( mNormal.x * mNormal.x + mNormal.y * mNormal.y + mNormal.z * mNormal.z );
			if ( length > epsilon )
			{
				var invLength: Number = 1 / length;
				mNormal.x *= invLength;
				mNormal.y *= invLength;
				mNormal.z *= invLength;
				mConstant *= invLength;
			}
			return length;
		}
		
		/**
		 * Calculates the distance to the <code>HPlane</code> Object from any <code>APoint</code> in Cartesian space.
		 * 
		 * @param	p	The <code>APoint</code> Object to check distance to.
		 * 
		 * @return	The distance from the <code>HPlane</code> Object to the <code>APoint</code> Object.
		 */
		public function distanceTo( p: APoint ): Number
		{
			return mNormal.x * p.x + mNormal.y * p.y + mNormal.z * p.z + mConstant;
		}
		
		
		/**
		 * Calculates which side of the <code>HPlane</code> Object an <code>APoint</code> Object is located.
		 * 
		 * @param	p	The <code>APoint</code> Object to check which side it is located.
		 * @return	-1 if the <code>APoint</code> is on the negative side of the <code>HPlane</code>, 1 if the <code>APoint</code>
		 * is on the possitive side, and 0 if the <code>HPoint</code> is on the plane.
		 */
		public function whichSide( p: APoint ): int
		{
			var distance: Number = distanceTo( p );
			
			if ( distance < 0 )
			{
				return -1;
			}
			
			if ( distance > 0 )
			{
				return 1;
			}
			
			return 0;
		}
		
		/**
		 * Composes a <code>String</code> representation of <code>this</code> Object.
		 * 
		 * @return	A <code>String</code> representation of the object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object HPlane] ( x:" + mNormal.x.toFixed( 5 ).substr( 0, 7 ) + 
								   ", y:" + mNormal.y.toFixed( 5 ).substr( 0, 7 ) +
								   ", z:" + mNormal.z.toFixed( 5 ).substr( 0, 7 ) +
								   ", constant:" + mConstant.toFixed( 5 ).substr( 0, 7 ) + ")";
		}
		
		
	}

}