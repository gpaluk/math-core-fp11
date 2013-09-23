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
	import io.plugin.core.interfaces.IEquatable;
	
	/**
	 * A representation of an axis and angle.
	 * 
	 * @author Gary Paluk
	 */
	public class AxisAngle implements IDisposable, IEquatable, ICloneable
	{
		/**
		 * An <code>AVector</code> defining the axis.
		 */
		public var axis: AVector;
		
		/**
		 * A <code>Number</code> that defining the angle.
		 */
		public var angle: Number;
		
		/**
		 * Disposed flag set to <code>true</code> once the object has been <code>disposed.</code>
		 */
		protected var mIsDisposed: Boolean;
		
		/**
		 * Representation of an axis with an angle. If no angle is defined, a default of 0 is used.
		 * 
		 * @param	axis	An <code>AVector</code> defining the axis
		 * @param	angle	A <code>Number</code> that defining the angle in radians.
		 */
		public function AxisAngle( axis: AVector, angle: Number = 0 )
		{
			this.axis = axis;
			this.angle = angle;
			
			mIsDisposed = false;
		}
		
		/**
		 * Returns a new <code>AxisAngle</code> object that is an shallow copy of this <code>AxisAngle</code> Object.
		 * 
		 * @return 	A new <code>AxisAngle</code> object that is an shallow copy of the current <code>AxisAngle</code> Object.
		 */
		public function clone(): *
		{
			return new AxisAngle( axis, angle );
		}
		
		/**
		 * Performs an equality check between this <code>AxisAngle</code> and another <code>AxisAngle</code> object.
		 * 
		 * @param	v	A <code>AxisAngle</code> object to compare against.
		 * @return	True if the <code>AxisAngle</code> objects contain the same x, y, and z values, false if not.
		 */
		public function equals( v: Object ): Boolean
		{
			if ( !(v is AxisAngle ) )
			{
				throw new Error( "An error occured in AxisAngle::equals(). Objetct type mismatch." );
			}
			return ( axis.equals( v.axis ) && ( angle == v.angle ) );
		}
		
		/**
		 * Disposes of this objects and frees the object ready for garbage collection.
		 */
		public function dispose(): void
		{
			axis.dispose();
			axis = null;
			
			mIsDisposed = true;
		}
		
	}

}