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
	 * An affine vector represents a vector as (x,y,z,0) in the three-dimensional space using the Cartesian coordinates x, y, and z.
	 * 
	 * <p>The <code>w</code> property provides additional orientation information. For example, the <code>w</code> property can define an angle of
	 * rotation of a <code>AVector</code> object. The combination of the angle of rotation and the coordinates x, y, and z can determine the display
	 * object's orientation.</p>
	 * 
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class AVector implements IDisposable, ICloneable, IEquatable
	{
		
		/**
		 * The first element of an <code>AVector</code> Object, such as the <code>x</code> coordinate of a point in the three-dimensional space.
		 */
		public var x: Number;
		
		/**
		 * The second element of an <code>AVector</code> Object, such as the <code>y</code> coordinate of a point in the three-dimensional space.
		 */
		public var y: Number;
		
		/**
		 * The second element of an <code>AVector</code> Object, such as the <code>z</code> coordinate of a point in the three-dimensional space.
		 */
		public var z: Number;
		
		private var _w: Number;
		
		/**
		 * The fourth element of an <code>AVector</code> Object (in addition to the <code>x</code>, <code>y</code>, and <code>z</code> properties).
		 * The <code>w</code> parameter is used to hold data such as the angle of rotation.
		 */
		public function get w(): Number 
		{
			return _w;
		}
		
		/**
		 * Disposed flag.
		 */
		protected var mIsDisposed: Boolean;
		
		/**
		 * Creates an instance of an <code>AVector</code> object. If you do not specify a parameter for the constructor, an <code>AVector</code>
		 * Object is created with the elements (0,0,0,0).
		 * 
		 * @param	x	The first element, such as the <code>x</code> coordinate.
		 * @param	y	The second element, such as the <code>y</code> coordinate.
		 * @param	z	The third element, such as the <code>z</code> coordinate.
		 */
		public function AVector( x: Number = 0, y: Number = 0, z: Number = 0 ) 
		{
			this.x = x;
			this.y = y;
			this.z = z;
			_w = 0;
			
			mIsDisposed = false;
			
		}
		
		public static function fromTuple( tuple: Array ): AVector
		{
			return new AVector( tuple[ 0 ], tuple[ 1 ], tuple[ 2 ] );
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
			mIsDisposed = true;
		}
		
		/**
		 * Returns a new <code>AVector</code> object that is an shallow copy of this <code>AVector</code> Object.
		 * 
		 * @return 	A new <code>AVector</code> object that is an shallow copy of the current <code>AVector</code> Object.
		 */
		public function clone(): *
		{
			return new AVector( x, y, z );
		}
		
		/**
		 * Returns an <code>Array</code> containing four elements, the x, y, z, w elements of the <code>AVector</code> respectively.
		 * 
		 * @return 	An <code>Array</code> containing four elements, the x, y, z, w elements of the <code>AVector</code> respectively.
		 */
		public function toTuple(): Array
		{
			return [ x, y, z, w ];
		}
		
		/**
		 * Returns an <code>AVector</code> containing four elements, the <code>x</code>, <code>y</code>, <code>z</code> and 
		 * <code>w</code> are components of the <code>AVector</code> respectively.
		 * 
		 * @return	A <code>Vector</code> Object containing four elements, the <code>x</code>, <code>y</code>, <code>z</code> and
		 * <code>w</code> properties of the <code>AVector</code> respectively.
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
		 * Sets the components of the <code>AVector</code> to the specified values 
		 * 
		 * @param	x	The <code>x</code> element.
		 * @param	y	The <code>y</code> element.
		 * @param	z	The <code>z</code> element.
		 * 
		 * @return	<code>this AVector</code> Object with the new x,y and z element values. 
		 */
		public function set( x: Number, y: Number, z: Number ): AVector
		{
			this.x = x;
			this.y = y;
			this.z = z;
			return this;
		}
		
		/**
		 * Adds an <code>AVector</code> Object to <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to add to <code>this</code> Object.
		 * @return	A new <code>AVector</code> Object containing the result of the addition.
		 */
		public function add( v: AVector ): AVector
		{
			return new AVector( x + v.x, y + v.y, z + v.z );
		}
		
		/**
		 * Adds another <code>AVector</code> Object to <code>this</code> Object and assigns the result to <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to add.
		 * @return	<code>this</code> Object
		 */
		public function addEq( v: AVector ): AVector
		{
			x += v.x;
			y += v.y;
			z += v.z;
			return this;
		}
		
		/**
		 * Subtracts another <code>AVector</code> Objet from <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to subtract form <code>this</code> Object.
		 * @return	A new <code>AVector</code> Object containing the result of the subtraction.
		 */
		public function subtract( v: AVector ): AVector
		{
			return new AVector( x - v.x, y - v.y, z - v.z );
		}
		
		/**
		 * Subtracts an <code>AVector</code> from <code>this</code> Object and assigns it to <code>this</code> Object.
		 * 
		 * @param	v	An <code>AVector</code> to subtract from <code>this</code> Object.
		 * @return	<code>this</code> Object contatining the result of the subtraction.
		 */
		public function subtractEq( v: AVector ): AVector
		{
			x -= v.x;
			y -= v.y;
			z -= v.z;
			return this;
		}
		
		/**
		 * Multiplies this <code>AVector</code> Object by a scaler <code>Number</code> whilst preserving this <code>AVector</code> Object.
		 * 
		 * @param	scaler	The scaler value to multiply with this <code>AVector</code> Object.
		 * @return	A new <code>AVector</code> Object that contains the result of the multiplication.
		 */
		public function scale( scaler: Number ): AVector
		{
			return new AVector( x * scaler, y * scaler, z * scaler );
		}
		
		/**
		 * Multiplies this <code>AVector</code> Object by a scaler <code>Number</code> and assigns the result to <code>this</code> Object.
		 * 
		 * @param	scaler	The scaler value to multiply with this <code>AVector</code> Object.
		 * @return	<code>this</code> Object contatining the result of the multiplication.
		 */
		public function scaleEq( scaler: Number ): AVector
		{
			x *= scaler;
			y *= scaler;
			z *= scaler;
			return this;
		}
		
		/**
		 * Divides this <code>AVector</code> Object by a scaler <code>Number</code> whilst preserving this <code>AVector</code> Object.
		 * 
		 * @param	scaler	The scaler value to divide with this <code>AVector</code> Object.
		 * @return	A new <code>AVector</code> Object that contains the result of the division.
		 */
		public function divide( scaler: Number ): AVector
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				return new AVector( x * invScaler, y * invScaler, z * invScaler );
			}
			return new AVector( Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE );
		}
		
		/**
		 * Divides this <code>AVector</code> Object by a scaler <code>Number</code> and assigns the result to <code>this</code> Object.
		 * 
		 * @param	scaler	The scaler value to divide with this <code>AVector</code> Object.
		 * @return	<code>this</code> Object contatining the result of the division.
		 */
		public function divideEq( scaler: Number ): AVector
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
		
		/**
		 * Negates this <code>AVector</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @return	A new <code>AVector</code> Object with negated x,y and z properties from this <code>AVector</code> Object.
		 */
		public function negate(): AVector
		{
			return new AVector( -x, -y, -z );
		}
		
		/**
		 * Negates the <code>AVector</code> Object and assigns the new x, y, z properties to <code>this</code> Object.
		 * 
		 * @return	<code>this</code> Object which contains the result of the negation.
		 */
		public function negateEq(): AVector
		{
			x = -x;
			y = -y;
			z = -z;
			return this;
		}
		
		/**
		 * Calculates the length of this <code>AVector</code> Object from the origin (0,0,0).
		 * 
		 * @return	The length of the <code>AVector</code>.
		 */
		[Inline]
		public final function get length(): Number
		{
			return Math.sqrt( x * x + y * y + z * z );
		}
		
		/**
		 * Calculates the squared length of this <code>AVector</code> Object. The squared length can often be used to
		 * optimize proceedures where a length comparison between vectors is required, this operation saves a costly
		 * square root operation being performed.
		 * 
		 * @return	The squared length of the <code>AVector</code> Object.
		 */
		public function get squaredLength(): Number
		{
			return x * x + y * y + z * z;
		}
		
		/**
		 * Calculates the dot product between an <code>AVector</code> Object and <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to used to calculate the dot product with <code>this</code> Object.
		 * @return	The calculated dot product between the two <code>AVector</code> Objects.
		 */
		public function dotProduct( v: AVector ): Number
		{
			return x * v.x + y * v.y + z * v.z;
		}
		
		/**
		 * Normalize the <code>AVector</code> Object so that it has a unit length of 1. If the original length is below that of the provided
		 * epsilon value, the <code>AVector</code> Object's length is set to 0, along with x, y and z values which are also set to 0.
		 * 
		 * @param	epsilon	The lower length rounding limit.
		 * @return	The new length of the <code>AVector</code>.
		 */
		public function normalize( epsilon: Number = 1e-8 ): Number
		{
			var len: Number = length;
			
			if ( len > epsilon )
			{
				var invLength: Number = 1 / len;
				x *= invLength;
				y *= invLength;
				z *= invLength;
			}
			else
			{
				len = 0;
				x = 0;
				y = 0;
				z = 0;
			}
			
			return len;
		}
		
		/**
		 * Calculates a new <code>AVector</code> Object that is the cross product between <code>this</code> Object and 
		 * another <code>AVector</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	v	Another <code>AVector</code> Object to perform the cross product function.
		 * @return	A new <code>AVector</code> Object containing the result of the cross product function.
		 */
		public function crossProduct( v: AVector ): AVector
		{
			return new AVector( y * v.z - z * v.y,
								z * v.x - x * v.z,
								x * v.y - y * v.x );
		}
		
		/**
		 * Calulates and creates a new <code>AVector</code> Object with a unit length of 1. The function preserves <code>this</code> Object.
		 * If the length of the original <code>AVector</code> is below the value of epsilon, the length is set to be 0.
		 * 
		 * @param	v	Another <code>AVector</code> Object to perform the unit cross product function.
		 * @param	epsilon	The lower length rounding limit passed to the normalize method.
		 * @return	A new <code>AVector</code> Object containing the result of the cross product and normalization function.
		 */
		public function unitCrossProduct( v: AVector, epsilon: Number = 1e-8 ): AVector
		{
			var cross: AVector = new AVector( y * v.z - z * v.y,
											  z * v.x - x * v.z,
											  x * v.y - y * v.x );
			cross.normalize( epsilon );
			return cross;
		}
		
		
		// TODO add an epsilon??
		
		/**
		 * Performs an equality check between this <code>AVector</code> and another <code>AVector</code> object.
		 * 
		 * @param	v	A <code>AVector</code> object to compare against.
		 * @return		True if the <code>AVector</code> objects contain the same x, y, and z values, false if not.
		 */
		public function equals( v: Object ): Boolean
		{
			if ( !(v is AVector ) )
			{
				return false;
			}
			return ( x == v.x && y == v.y && z == v.z );
		}
		
		/**
		 * The x, y, z axis defined as an <code>AVector</code> object with coordinates (0,0,0).
		 */
		public static function get ZERO(): AVector
		{
			return new AVector( 0, 0, 0 );
		}
		
		/**
		 * The x axis defined as a <code>AVector</code> object with coordinates (1,0,0).
		 */
		public static function get UNIT_X(): AVector
		{
			return new AVector( 1, 0, 0 );
		}
		
		/**
		 * The negative x axis defined as a <code>AVector</code> object with coordinates (-1,0,0).
		 */
		public static function get UNIT_X_NEGATIVE(): AVector
		{
			return new AVector( -1, 0, 0 );
		}
		
		/**
		 * The y axis defined as a <code>AVector</code> object with coordinates (0,1,0).
		 */
		public static function get UNIT_Y(): AVector
		{
			return new AVector( 0, 1, 0 );
		}
		
		/**
		 * The negative y axis defined as a <code>AVector</code> object with coordinates (0,-1,0).
		 */
		public static function get UNIT_Y_NEGATIVE(): AVector
		{
			return new AVector( 0, -1, 0 );
		}
		
		/**
		 * The z axis defined as a <code>AVector</code> object with coordinates (0,0,1).
		 */
		public static function get UNIT_Z(): AVector
		{
			return new AVector( 0, 0, 1 );
		}
		
		/**
		 * The negative z axis defined as a <code>AVector</code> object with coordinates (0,0,-1).
		 */
		public static function get UNIT_Z_NEGATIVE(): AVector
		{
			return new AVector( 0, 0, -1 );
		}
		
		/**
		 * Orthonormalize a set of three <code>AVector</code> Objects.
		 * 
		 * @param	v0	The first <code>AVector</code> Object.
		 * @param	v1	The second <code>AVector</code> Object.
		 * @param	v2	The third <code>AVector</code> Object.
		 * 
		 * @return	An <code>Array</code> containing the authonormalized set of <code>AVector</code> Objects.
		 */
		public static function orthonormalize( v0: AVector, v1: AVector, v2: AVector ): Array
		{
			v0.normalize();
			
			var dot0: Number = v0.dotProduct( v1 );
			
			v1.subtractEq( v0.scale( dot0 ) ); 
			v1.normalize();
			
			var dot1: Number = v1.dotProduct( v2 );
			v2.subtractEq( v0.scale( dot0 ).add( v1.scale( dot1 ) ) );
			v2.normalize();
			
			return [ v0, v1, v2 ];
		}
		
		// TODO consider to add following methods: generateOrthonormalBasis, generateComplementBasis 
		
		public static function generateOrthonormalBasis( v0: AVector, v1: AVector, v2: AVector ): void
		{
			v2.normalize();
			generateComplementBasis( v0, v1, v2 );
		}
		
		public static function generateComplementBasis( v0: AVector, v1: AVector, v2: AVector ): void
		{
			var invLength: Number;
			
			if ( Math.abs( v2.x ) >= Math.abs( v2.y ) )
			{
				invLength = 1 / Math.sqrt( v2.x * v2.x + v2.z * v2.z );
				
				v0.x = -v2.z * invLength;
				v0.y = 0;
				v0.z = v2.x * invLength;
				
				v1.x = v2.y * v0.z;
				v1.y = v2.z * v0.x - v2.x * v0.z;
				v1.z = -v2.y * v0.x;
			}
			else
			{
				invLength = 1 / Math.sqrt( v2.y * v2.y + v2.z * v2.z );
				
				v0.x = 0;
				v0.y = v2.z * invLength;
				v0.z = -v2.y * invLength;
				
				v1.x = v2.y * v0.z - v2.z * v0.y;
				v1.y = -v2.x * v0.z;
				v1.z = v2.x * v0.y;
			}
		}
		
		/**
		 * Returns a <code>String</code> representation of the object.
		 * 
		 * @return A <code>String</code> representation of the object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object AVector] (x:" + x.toFixed( 5 ).substr( 0, 7 ) + 
					", y:" + y.toFixed( 5 ).substr( 0, 7 ) +
					", z:" + z.toFixed( 5 ).substr( 0, 7 ) +
					", w:" + w.toFixed( 5 ).substr( 0, 7 ) + ")";
		}
		
	}

}