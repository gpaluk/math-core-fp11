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
	 * An affine point represents a point (x,y,z,1) in the three-dimensional space using the Cartesian coordinates x, y, and z. If you do not specify 
	 * a parameter for the constructor, an <code>APoint</code> Object is created with the elements (0,0,0,1).
	 * 
	 * @author Gary Paluk
	 */
	public class APoint implements IEquatable, ICloneable, IDisposable
	{
		
		/**
		 * The first element of an <code>APoint</code> Object, such as the <code>x</code> coordinate of a point in the three-dimensional space.
		 */
		public var x: Number;
		
		/**
		 * The first element of an <code>APoint</code> Object, such as the <code>y</code> coordinate of a point in the three-dimensional space.
		 */
		public var y: Number;
		
		/**
		 * The first element of an <code>APoint</code> Object, such as the <code>z</code> coordinate of a point in the three-dimensional space.
		 */
		public var z: Number;
		
		
		protected var _w: Number;
		
		/**
		 * The fourth element of an <code>APoint</code> Object (in addition to the <code>x</code>, <code>y</code>, and <code>z</code> properties).
		 * The <code>w</code> parameter is used to hold data such as the angle of rotation.
		 */
		public function get w():Number 
		{
			return _w;
		}
		
		/**
		 * Creates and returns a new <code>APoint</code> object the represents an origin value at x=0, y=0, z=0.
		 */
		public static function get ORIGIN(): APoint
		{
			return new APoint( 0, 0, 0 );
		}
		
		/**
		 * Creates and returns a new <code>APoint</code> object that represents a value at x=1, y=1, z=1.
		 */
		public static function get ONE(): APoint
		{
			return new APoint( 1, 1, 1 );
		}
		
		/**
		 * Creates a new <code>APoint</code> object from an array.
		 * 
		 * @param	tuple	The values to instanciate the new <code>APoint</code> object.
		 * 
		 * @return The new <code>APoint</code> object.
		 */
		public static function fromTuple( tuple: Array ): APoint
		{
			return new APoint( tuple[ 0 ], tuple[ 1 ], tuple[ 2 ] );
		}
		
		/**
		 * An affine point represents a point (x,y,z,1) in the three-dimensional space using the Cartesian coordinates x, y, and z. If you do not specify 
		 * a parameter for the constructor, an <code>APoint</code> Object is created with the elements (0,0,0,1).
		 * 
		 * @param	x	The x component.
		 * @param	y	The y component.
		 * @param	z	The z component.
		 */
		public function APoint( x: Number = 0, y: Number = 0, z: Number = 0 ) 
		{
			this.x = x;
			this.y = y;
			this.z = z;
			_w = 1;
		}
		
		/**
		 * Disposes of this objects and frees the object ready for garbage collection.
		 */
		public function dispose(): void
		{
			
		}
		
		/**
		 * Creates a shallow clone of this object is created passing the x, y and z properties to the clone.
		 * 
		 * @return	A new shallow clone of this <code>Object</code>
		 */
		public function clone(): *
		{
			return new APoint( x, y, z );
		}
		
		/**
		 * Creates and returns an <code>Array</code> containing the x, y, z and w properies of this <code>APoint</code> object.
		 * 
		 * @return	The x, y, z and w components of this <code>APoint</code> Object as an <code>Array</code>.
		 */
		public function toTuple(): Array
		{
			return [ x, y, z, w ];
		}
		
		/**
		 * Creates and return an <code>Vector</code> containing the x, y, z and w properies of this <code>APoint</code> object.
		 * 
		 * @return	The x, y, z and w components of this <code>APoint</code> object as a <code>Vector</code>.
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
		 * Helper method that allows the simultaneous setting of the x, y and z components of this <code>APoint</code> object.
		 * 
		 * @param	x	The <code>x</code> component.
		 * @param	y	The <code>y</code> component.
		 * @param	z	The <code>z</code> component.
		 * @return	The resulting <code>APoint</code> object.
		 */
		public function set( x: Number, y: Number, z: Number ): APoint
		{
			this.x = x;
			this.y = y;
			this.z = z;
			return this;
		}
		
		/**
		 * Adds two <code>APoint</code> Objects together whilst preserving this <code>APoint</code> object and returns a new <code>APoint</code> object.
		 * 
		 * @param	p	The <code>APoint</code> object to add to <code>this</code> object.
		 * @return	The resulting new <code>APoint</code> object containing the result of the addition.
		 */
		public function add( p: APoint ): APoint
		{
			return new APoint( x + p.x, y + p.y, z + p.z );
		}
		
		/**
		 * Adds two <code>APoint</code> Objects together and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	p	An <code>APoint</code> object to add to <code>this</code> Object.
		 * @return	<code>this</code> Object containing the result of the addition.
		 */
		public function addEq( p: APoint ): APoint
		{
			x += p.x;
			y += p.y;
			z += p.z;
			return this;
		}
		
		/**
		 * Adds an <code>AVector</code> Object to this <code>APoint</code> whilst preserving the <code>APoint</code> object and returns a new <code>APoint</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> object to add to this <code>APoint</code> Object.
		 * @return	A new <code>APoint</code> Object containing the result of the addition.
		 */
		public function addAVector( v: AVector ): APoint
		{
			return new APoint( x + v.x, y + v.y, z + v.z );
		}
		
		/**
		 * Adds an <code>AVector</code> Objects to this <code>APoint</code> and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to add to this <code>APoint</code> Object.
		 * @return	<code>this</code> Object Object containing the result of the addition.
		 */
		public function addAVectorEq( v: AVector ): APoint
		{
			x += v.x;
			y += v.y;
			z += v.z;
			return this;
		}
		
		/**
		 * Subtracts an <code>APoint</code> Object from <code>this</code> object whilst preserving <code>this</code> Object.
		 * 
		 * @param	p	The <code>APoint</code> Object to subtract from this Object.
		 * @return	A new <code>APoint</code> Object containing the result of the subtraction.
		 */
		public function subtract( p: APoint ): AVector
		{
			return new AVector( x - p.x, y - p.y, z - p.z );
		}
		
		/**
		 * Subtracts an <code>APoint</code> Object from this <code>APoint</code> Object and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	p	The <code>APoint</code> Object to subtract from this <code>APoint</code> Object.
		 * @return	<code>this</code> Object containing the result of the subtraction.
		 */
		public function subtractEq( p: APoint ): APoint
		{
			x -= p.x;
			y -= p.y;
			z -= p.z;
			return this;
		}
		
		/**
		 * Subtracts an <code>AVector</code> Object from <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to subtract from this Object.
		 * @return	A new <code>APoint</code> Object containing the result of the subtraction.
		 */
		public function subtractAVector( v: AVector ): APoint
		{
			return new APoint( x - v.x, y - v.y, z - v.z );
		}
		
		/**
		 * Subtracts an <code>AVector</code> Object from this <code>APoint</code> Object and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to subtract from this <code>APoint</code> Object.
		 * @return	The resulting <code>APoint</code> Object containing the result of the subtraction.
		 */
		public function subtractAVectorEq( v: AVector ): APoint
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
			return this;
		}
		
		/**
		 * Multiplies <code>this</code> object by a <code>Number</code> scaler whilst preserving <code>this</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to scale this Object by.
		 * @return	A new <code>APoint</code> Object containing the result of the multiplication.
		 */
		public function scale( scaler: Number ): APoint
		{
			return new APoint( x * scaler, y * scaler, z * scaler );
		}
		
		/**
		 * Multiplies <code>this</code> Object by a <code>Number</code> scaler and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to scale <code>this</code> Object by.
		 * @return	<code>this</code> Object containing the result of the multiplication.
		 */
		public function scaleEq( scaler: Number ): APoint
		{
			x *= scaler;
			y *= scaler;
			z *= scaler;
			return this;
		}
		
		/**
		 * Divides <code>this</code> Object by a scaler <code>Number</code> value whilst preserving <code>this</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to divide <code>this</code> Object by.
		 * @return	A new <code>APoint</code> Object containing the result of the division.
		 */
		public function divide( scaler: Number ): APoint
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				return new APoint( x * invScaler, y * invScaler, z * invScaler );
			}
			return new APoint( Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE );
		}
		
		/**
		 * Divides <code>this</code> Object by a scaler <code>Number</code> and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to divide <code>this</code> Object by.
		 * @return	<code>this</code> Object containing the result of the division.
		 */
		public function divideEq( scaler: Number ): APoint
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				x *= invScaler;
				y *= invScaler;
				z *= invScaler;
			}
			else
			{
				x = Number.MAX_VALUE;
				y = Number.MAX_VALUE;
				z = Number.MAX_VALUE;
			}
			return this;
		}
		
		
		// TODO consider a scale helper function scale( scaler: Number ) and scaleEq( scaler: Number )
		// essentially is it the same as multiply
		
		
		
		/**
		 * Negates this <code>APoint</code> Object whilst preserving <code>this</code> Object.
		 * @return	A new <code>APoint</code> Object with negated x,y,z properties from this <code>APoint</code> Object.
		 */
		public function negate(): APoint
		{
			return new APoint( -x, -y, -z );
		}
		
		/**
		 * Negates the <code>APoint</code> Object and assigns the new x, y, z properties to <code>this</code> Object.
		 * @return	<code>this</code> Object which contains the result of the negation.
		 */
		public function negateEq(): APoint
		{
			x = -x;
			y = -y;
			z = -z;
			return this;
		}
		
		/**
		 * A dot product between a point and a vector is not allowed in affine algebra but is a convenience
		 * when dealing with planes. Specifically, a plane is dot(N,X-P) = 0, where N is a vector, P is a 
		 * specific point on the plane, and X is any point on the plane.
		 * 
		 * @param	v	The <code>AVector</code> 
		 * @return	The dot product between <code>this</code> and the <code>AVector</code> object
		 */
		public function dotProduct( v: AVector ): Number
		{
			return x * v.x + y * v.y + z * v.z;
		}
		
		/**
		 * Performs an equality check between this <code>APoint</code> and another <code>APoint</code> object.
		 * 
		 * @param	p	An <code>APoint</code> object to compare against.
		 * @return		True if the <code>APoint</code> objects contain the same x, y, and z values, false if not.
		 */
		public function equals( p: Object ): Boolean
		{
			if ( p is APoint )
			{
				return ( x == p.x && y == p.y && z == p.z );
			}
			return false;
		}
		
		/**
		 * Composes a <code>String</code> representation of <code>this</code> Object.
		 * 
		 * @return	A <code>String</code> representation of the object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object APoint] (x:" + x.toFixed( 5 ).substr( 0, 7 ) +
								  ", y:" + y.toFixed( 5 ).substr( 0, 7 ) + 
								  ", z:" + z.toFixed( 5 ).substr( 0, 7 ) + 
								  ", w:" + w.toFixed( 5 ).substr( 0, 7 ) + ")";
		}
		
	}

}