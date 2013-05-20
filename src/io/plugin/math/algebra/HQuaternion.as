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
	import io.plugin.core.interfaces.IEquatable;
	import io.plugin.math.base.MathHelper;
	
	/**
	 * A homogeneous representation of a quartenion in the three-dimensional space using the Cartesian coordinates x, y, and z.
	 * 
	 * @author Gary Paluk
	 */
	public class HQuaternion implements IEquatable, ICloneable
	{
		
		/**
		 * The first element of an <code>HQuaternion</code> Object, such as the <code>w</code> coordinate of a point in the three-dimensional space.
		 */
		public var w: Number;
		
		/**
		 * The second element of an <code>HQuaternion</code> Object, such as the <code>x</code> coordinate of a point in the three-dimensional space.
		 */
		public var x: Number;
		
		/**
		 * The third element of an <code>HQuaternion</code> Object, such as the <code>y</code> coordinate of a point in the three-dimensional space.
		 */
		public var y: Number;
		
		/**
		 * The fourth element of an <code>HQuaternion</code> Object, such as the <code>z</code> coordinate of a point in the three-dimensional space.
		 */
		public var z: Number;
		
		/**
		 * Performs an equality check between this <code>HQuaternion</code> and another <code>HQuaternion</code> object.
		 * 
		 * @param	q	An <code>HQuaternion</code> object to compare against.
		 * 
		 * @return		True if the <code>HQuaternion</code> objects contain the same w, x, y, and z values, false if not.
		 */
		public function equals( q: Object ): Boolean
		{
			if ( !(q is HQuaternion ) )
			{
				throw new Error( "An error occured in HQuaternion::equals(). Object type mismatch." );
			}
			return ( w == q.w && x == q.x && y == q.y && z == q.z );
		}
		
		/**
		 * Creates and returns a zero filled <code>HQuaternion</code> object where all w, x, y and z values are (0,0,0,0) respectivly.
		 */
		public static function get ZERO(): HQuaternion
		{
			return new HQuaternion( 0, 0, 0, 0 );
		}
		
		/**
		 * Creates and returns a zero filled <code>HQuaternion</code> object where all w, x, y andz values are (1,0,0,0) respectivly.
		 */
		public static function get IDENTITY(): HQuaternion
		{
			return new HQuaternion( 1, 0, 0, 0 );
		}
		
		/**
		 * A temporary <code>HQuaternion</code> Object, used during computations where alaising may occur.
		 */
		private static const TEMP: HQuaternion = new HQuaternion();
		
		/**
		 * Creates an instance of an <code>HQuaternion</code> object. If you do not specify a parameter for the constructor, an <code>HQuaternion</code>
		 * Object is created with the elements (0,0,0,0).
		 * 
		 * @param	w	The first element, such as the <code>w</code> coordinate.
		 * @param	x	The second element, such as the <code>x</code> coordinate.
		 * @param	y	The third element, such as the <code>y</code> coordinate.
		 * @param	z	The fourth element, such as the <code>z</code> coordinate.
		 */
		public function HQuaternion( w: Number = 0, x: Number = 0, y: Number = 0, z: Number = 0 ) 
		{
			this.w = w;
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		/**
		 * Returns a new <code>HQuaternion</code> object that is an shallow copy of this <code>HQuaternion</code> Object.
		 * 
		 * @return 	A new <code>HQuaternion</code> object that is an shallow copy of the current <code>HQuaternion</code> Object.
		 */
		public function clone(): *
		{
			return new HQuaternion( w, x, y, z );
		}
		
		/**
		 * Returns an <code>Array</code> containing four elements, the w, x, y, z elements of the <code>HQuaternion</code> respectively.
		 * 
		 * @return 	An <code>Array</code> containing four elements, the w, x, y, z elements of the <code>HQuaternion</code> respectively.
		 */
		public function toTuple(): Array
		{
			return [ w, x, y, z ];
		}
		
		/**
		 * Returns an <code>Vector</code> containing four elements, the <code>w</code>, <code>x</code>, <code>y</code> and <code>z</code>
		 * are components of the <code>HQuaternion</code> respectively.
		 * 
		 * @return	A <code>Vector</code> Object containing four elements, the <code>w</code>, <code>x</code>, <code>y</code>, <code>z</code> and
		 * properties of the <code>AVector</code> respectively.
		 */
		public function toVector(): Vector.<Number>
		{
			var v: Vector.<Number> = new Vector.<Number>( 4, true );
			v[ 0 ] = w;
			v[ 1 ] = x;
			v[ 2 ] = y;
			v[ 3 ] = z;
			return v;
		}
		
		/**
		 * Sets the components of the <code>HQuaternion</code> to the specified values.
		 * 
		 * @param	w	The <code>w</code> element.
		 * @param	x	The <code>x</code> element.
		 * @param	y	The <code>y</code> element.
		 * @param	z	The <code>z</code> element.
		 * 
		 * @return	<code>this AVector</code> Object with the new w, x, y and z element values. 
		 */
		public function set( w: Number, x: Number, y: Number, z: Number ): HQuaternion
		{
			this.w = w;
			this.x = x;
			this.y = y;
			this.z = z;
			return this;
		}
		
		/**
		 * Adds an <code>HQuaternion</code> Object to <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> Object to add to <code>this</code> Object.
		 * @return	A new <code>HQuaternion</code> Object containing the result of the addition.
		 */
		public function add( q: HQuaternion ): HQuaternion
		{
			return new HQuaternion( w + q.w, x + q.x, y + q.y, z + q.z );
		}
		
		/**
		 * Adds another <code>HQuaternion</code> Object to <code>this</code> Object and assigns the result to <code>this</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> Object to add.
		 * @return	<code>this</code> Object containing the result of the addition.
		 */
		public function addEq( q: HQuaternion ): HQuaternion
		{
			w += q.w;
			x += q.x;
			y += q.y;
			z += q.z;
			return this;
		}
		
		/**
		 * Subtracts another <code>HQuaternion</code> Objet from <code>this</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> Object to subtract form <code>this</code> Object.
		 * @return	A new <code>HQuaternion</code> Object containing the result of the subtraction.
		 */
		public function subtract( q: HQuaternion ): HQuaternion
		{
			return new HQuaternion( w - q.w, x - q.x, y - q.y, z - q.z );
		}
		
		/**
		 * Subtracts an <code>HQuaternion</code> from <code>this</code> Object and assigns it to <code>this</code> Object.
		 * 
		 * @param	q	An <code>HQuaternion</code> to subtract from <code>this</code> Object.
		 * @return	<code>this</code> Object contatining the result of the subtraction.
		 */
		public function subtractEq( q: HQuaternion ): HQuaternion
		{
			w -= q.w;
			x -= q.x;
			y -= q.y;
			z -= q.z;
			return this;
		}
		
		/**
		 * Multiplies this <code>HQuaternion</code> Object with another <code>HQuaternion</code> Object whilst preserving this <code>HQuaternion</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> value to multiply with this <code>HQuaternion</code> Object.
		 * @return	A new <code>HQuaternion</code> Object that contains the result of the multiplication.
		 */
		public function multiply( q: HQuaternion ): HQuaternion
		{
			return new HQuaternion( w * q.w - x * q.x - y * q.y - z * q.z,
									w * q.x + x * q.w + y * q.z - z * q.y,
									w * q.y + y * q.w + z * q.x - x * q.z,
									w * q.z + z * q.w + x * q.y - y * q.x );
		}
		
		/**
		 * Multiplies this <code>HQuaternion</code> Object with another <code>HQuaternion</code> Object and return it as a new <code>HQuaternion</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> value to multiply with this <code>HQuaternion</code> Object.
		 * @return	 <code>this</code> Object that contains the result of the multiplication.
		 */
		public function multiplyEq( q: HQuaternion ): HQuaternion
		{
			TEMP.set( w * q.w - x * q.x - y * q.y - z * q.z,
					  w * q.x + x * q.w + y * q.z - z * q.y,
					  w * q.y + y * q.w + z * q.x - x * q.z,
					  w * q.z + z * q.w + x * q.y - y * q.x );
			
			w = TEMP.w;
			x = TEMP.x;
			y = TEMP.y;
			z = TEMP.z;
			
			return this;
		}
		
		/**
		 * Multiplies this <code>HQuaternion</code> Object by a scaler <code>Number</code> whilst preserving this <code>HQuaternion</code> Object.
		 * 
		 * @param	scaler	The scaler value to multiply with this <code>HQuaternion</code> Object.
		 * @return	A new <code>HQuaternion</code> Object that contains the result of the scale.
		 */
		public function scale( scaler: Number ): HQuaternion
		{
			return new HQuaternion( w * scaler, x * scaler, y * scaler, z * scaler );
		}
		
		/**
		 * Multiplies this <code>HQuaternion</code> Object by a scaler <code>Number</code> and assigns the result to <code>this</code> Object.
		 * 
		 * @param	scaler	The scaler value to multiply with this <code>HQuaternion</code> Object.
		 * @return	<code>this</code> Object contatining the result of the scale.
		 */
		public function scaleEq( scaler: Number ): HQuaternion
		{
			w *= scaler;
			x *= scaler;
			y *= scaler;
			z *= scaler;
			return this;
		}
		
		/**
		 * Divides this <code>HQuaternion</code> Object by a scaler <code>Number</code> whilst preserving this <code>HQuaternion</code> Object.
		 * 
		 * @param	scaler	The scaler value to divide with this <code>HQuaternion</code> Object.
		 * @return	A new <code>HQuaternion</code> Object that contains the result of the division.
		 */
		public function divide( scaler: Number ): HQuaternion
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				return new HQuaternion( w * invScaler, x * invScaler, y * invScaler, z * invScaler );
			}
			return new HQuaternion( Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE );
		}
		
		/**
		 * Divides this <code>HQuaternion</code> Object by a scaler <code>Number</code> and assigns the result to <code>this</code> Object.
		 * 
		 * @param	scaler	The scaler value to divide with this <code>HQuaternion</code> Object.
		 * @return	<code>this</code> Object contatining the result of the division.
		 */
		public function divideEq( scaler: Number ): HQuaternion
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				w *= invScaler;
				x *= invScaler;
				y *= invScaler;
				z *= invScaler;
			}
			else
			{
				w = Number.MAX_VALUE;
				x = Number.MAX_VALUE;
				y = Number.MAX_VALUE;
				z = Number.MAX_VALUE;
			}
			return this;
		}
		
		/**
		 * Negates this <code>HQuaternion</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @return	A new <code>HQuaternion</code> Object with negated w, x, y and z properties from this <code>HQuaternion</code> Object.
		 */
		public function negate(): HQuaternion
		{
			return new HQuaternion( -w, -x, -y, -z );
		}
		
		/**
		 * Negates the <code>HQuaternion</code> Object and assigns the new w, x, y, z properties to <code>this</code> Object.
		 * 
		 * @return	<code>this</code> Object which contains the result of the negation.
		 */
		public function negateEq(): HQuaternion
		{
			w = -w;
			x = -x;
			y = -y;
			z = -z;
			return this;
		}
		
		/*
		private static function sign( value: Number ): Number
		{
			return( value > 0 ? 1 : -1 );
		}
		*/
		[Inline]
		private final function norm( a: Number, b: Number, c: Number, d: Number ): Number
		{
			return Math.sqrt( a * a + b * b + c * c + d * d);
		}
		
		public static function fromRotationMatrix( rot: HMatrix ): HQuaternion
		{
			// TODO serious test this stuff + pointer optimizations
			var q0: Number = ( rot.m00 + rot.m11 + rot.m22 + 1 ) / 4;
			var q1: Number = ( rot.m00 - rot.m11 - rot.m22 + 1 ) / 4;
			var q2: Number = (-rot.m00 + rot.m11 - rot.m22 + 1 ) / 4;
			var q3: Number = (-rot.m00 - rot.m11 + rot.m22 + 1 ) / 4;
			
			if ( q0 < 0 )
			{
				q0 =  0;
			}
			if ( q1 < 0 )
			{
				q1 =  0;
			}
			if ( q2 < 0 )
			{
				q2 =  0;
			}
			if ( q3 < 0 )
			{
				q3 =  0;
			}
			
			q0 = Math.sqrt( q0 );
			q1 = Math.sqrt( q1 );
			q2 = Math.sqrt( q2 );
			q3 = Math.sqrt( q3 );
			
			if ( q0 >= q1 && q0 >= q2 && q0 >= q3 )
			{
				q1 *= MathHelper.sign( rot.m21 - rot.m12 );
				q2 *= MathHelper.sign( rot.m02 - rot.m20 );
				q3 *= MathHelper.sign( rot.m10 - rot.m01 );
			}
			else if( q1 >= q0 && q1 >= q2 && q1 >= q3 )
			{
				q0 *= MathHelper.sign( rot.m21 - rot.m12 );
				q2 *= MathHelper.sign( rot.m10 + rot.m01 );
				q3 *= MathHelper.sign( rot.m02 + rot.m20 );
			}
			else if ( q2 >= q0 && q2 >= q1 && q2 >= q3 )
			{
				q0 *= MathHelper.sign( rot.m02 - rot.m20 );
				q1 *= MathHelper.sign( rot.m10 + rot.m01 );
				q3 *= MathHelper.sign( rot.m21 + rot.m12 );
			}
			else if ( q3 >= q0 && q3 >= q1 && q3 >= q2 )
			{
				q0 *= MathHelper.sign( rot.m10 - rot.m01 );
				q1 *= MathHelper.sign( rot.m20 + rot.m02 );
				q2 *= MathHelper.sign( rot.m21 + rot.m12 );
			}
			else
			{
				throw new Error( "Invalid value." );
			}
			var r: Number = Math.sqrt( q0 * q0 + q1 * q1 + q2 * q2 + q3 * q3)
			
			return new HQuaternion( q0 /= r, q1 /= r, q2 /= r, q3 /= r );
		}
		
		/**
		 * Calculates a rotation matrix from the quarternion values.
		 * 
		 * @return	A new <code>HMatrix</code> Object rotation representation of the <code>HQuaternion</code> Object.
		 */
		public function toRotationMatrix( ): HMatrix
		{
			var twoX: Number = 2 * x;
			var twoY: Number = 2 * y;
			var twoZ: Number = 2 * z;
			
			var twoWX: Number = twoX * w;
			var twoWY: Number = twoY * w;
			var twoWZ: Number = twoZ * w;
			
			var twoXX: Number = twoX * x;
			var twoXY: Number = twoY * x;
			var twoXZ: Number = twoZ * x;
			
			//var twoYX: Number = twoX * y;
			var twoYY: Number = twoY * y;
			var twoYZ: Number = twoZ * y;
			
			//var twoZX: Number = twoX * z;
			//var twoZY: Number = twoY * z;
			var twoZZ: Number = twoZ * z;
			
			return new HMatrix( 1 - (twoYY + twoZZ),
								twoXY - twoWZ,
								twoXZ + twoWY,
								0,
								
								twoXY + twoWZ,
								1 - (twoXX + twoZZ),
								twoYZ - twoWX,
								0,
								
								twoXZ - twoWY,
								twoYZ + twoWX,
								1 - (twoXX + twoYY),
								0,
								
								0, 0, 0, 1 );
		}
		
		
		public function fromAxisAngle( axisAngle: AxisAngle ): void
		{
			var halfAngle: Number = 0.5 * axisAngle.angle;
			var sn: Number = Math.sin( halfAngle );
			
			w = Math.cos( halfAngle );
			x = sn * axisAngle.axis.x;
			y = sn * axisAngle.axis.y;
			z = sn * axisAngle.axis.z;
		}
		
		public function toAxisAngle( ): AxisAngle
		{
			var sqlLength: Number = x * x + y * y + z * z;
			
			if ( sqlLength > 0 )
			{
				var invLength: Number = 1 / Math.sqrt( sqlLength );
				return new AxisAngle( new AVector( x * invLength, y * invLength, z * invLength ), 2 * Math.acos( w ) );
			}
			return new AxisAngle( new AVector( 1, 0, 0 ), 0 );
		}
		
		/**
		 * Calculates the length of this <code>HQuaternion</code> Object.
		 * 
		 * @return	The length of the <code>HQuaternion</code>.
		 */
		public function getLength(): Number
		{
			return Math.sqrt( w * w + x * x + y * y + z * z );
		}
		
		/**
		 * Calculates the squared length of this <code>HQuaternion</code> Object. The squared length can often be used to
		 * optimize proceedures where a length comparison is required, this operation saves a costly
		 * square root operation being performed.
		 * 
		 * @return	The squared length of the <code>HQuaternion</code> Object.
		 */
		public function getSquaredLength(): Number
		{
			return w * w + x * x + y * y + z * z;
		}
		
		/**
		 * Calculates the dot product between an <code>AVector</code> Object and <code>this</code> Object.
		 * 
		 * @param	q	The <code>HQuaternion</code> Object to used to calculate the dot product with <code>this</code> Object.
		 * @return	The calculated dot product between the two <code>HQuaternion</code> Objects.
		 */
		public function dotProduct( q: HQuaternion ): Number
		{
			return  w * q.w + x * q.x + y * q.y + z * q.z;
		}
		
		/**
		 * Normalize the <code>HQuaternion</code> Object so that it has a unit length of 1. If the original length is below that of the provided
		 * epsilon value, the <code>AVector</code> Object's length is set to 0, along with w, x, y and z values which are also set to 0.
		 * 
		 * @param	epsilon	The lower length rounding limit.
		 * @return	The new length of the <code>HQuaternion</code>.
		 */
		public function normalize( epsilon: Number = 1e-8 ): Number
		{
			var length: Number = getLength();
			if ( length > epsilon )
			{
				var invLength: Number = 1 / length;
				w *= invLength;
				x *= invLength;
				y *= invLength;
				z *= invLength;
			}
			else
			{
				w = 0;
				x = 0;
				y = 0;
				z = 0;
				length = 0;
			}
			return length;
		}
		
		
		public function inverse(): HQuaternion
		{
			var norm: Number = getSquaredLength();
			if ( norm > 0 )
			{
				var invNorm: Number = 1 / norm;
				return new HQuaternion( w * invNorm, -x * invNorm, -y * invNorm, -z * invNorm );
			}
			return new HQuaternion( 0, 0, 0, 0 );
		}
		
		public function conjugate(): HQuaternion
		{
			return new HQuaternion( w, -x, -y, -z );
		}
		
		public function exp(): HQuaternion
		{
			var result: HQuaternion = new HQuaternion();
			
			var angle: Number = Math.sqrt( x * x + y * y + z * z );
			
			var sn: Number = Math.sin( angle );
			var cosAngle: Number = Math.cos( angle );
			
			if ( Math.abs( sn ) > 0 )
			{
				var coeff: Number = sn / angle;
				return new HQuaternion( cosAngle, x * coeff, y * coeff, z * coeff );
			}
			return new HQuaternion( cosAngle, x, y, z );
		}
		
		public function log(): HQuaternion
		{
			if ( Math.abs( w ) < 1 )
			{
				var angle: Number = Math.acos( w );
				var sn: Number = Math.sin( angle );
				if ( Math.abs( sn ) > 0 )
				{
					var coeff: Number = angle / sn;
					return new HQuaternion( 0, coeff * x, coeff * y, coeff * z );
				}
			}
			return new HQuaternion( 0, x, y, z );
		}
		
		/*
		public function rotate( v: AVector ): AVector
		{
			// TODO implement rotate()
		}
		*/
		
		/**
		 * Calculate the spherical interpolation of two <code>HQuaternion</code> Objects and assign <code>this</code> Object with the result.
		 * 
		 * @param	t	Tha alpha parameter betweeen the closed set [0,1].
		 * @param	p	The first <code>HQuaternion</code> Object.
		 * @param	q	The second <code>HQuaternion</code> Object.
		 * 
		 * @return	<code>this</code> Object with the spherically interpolated result.
		 */
		public function slerp( t: Number, p: HQuaternion, q: HQuaternion ): HQuaternion
		{
			var cs: Number = p.dotProduct( q );
			var angle: Number = Math.acos( cs );
			
			if ( Math.abs( angle ) > 0 )
			{
				var sn: Number = Math.sin( angle );
				var invSn: Number = 1 / sn;
				var tAngle: Number = t * angle;
				
				var coeff0: Number = Math.sin( angle - tAngle ) * invSn;
				var coeff1: Number = Math.sin( tAngle ) * invSn;
				
				w = p.w * coeff0 + q.w * coeff1;
				x = p.x * coeff0 + q.x * coeff1;
				y = p.y * coeff0 + q.y * coeff1;
				z = p.z * coeff0 + q.z * coeff1;
			}
			else
			{
				w = p.w;
				x = p.x;
				y = p.y;
				z = p.z;
			}
			
			return this;
		}
		
		/*
		public function intermediate(): HQuaternion
		{
			// TODO implement intermediate()
		}
		*/
		
		/*
		public function squad( t: Number, q0: HQuaternion, a0: HQuaternion, q1: HQuaternion, a1: HQuaternion ): HQuaternion
		{
			// TODO implement squad()
		}
		*/
		
		/**
		 * Returns a <code>String</code> representation of the Object.
		 * 
		 * @return A <code>String</code> representation of the Object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object HQuaternion] (w:" + w.toFixed( 5 ).substr( 0, 7 ) + 
										", x:" + x.toFixed( 5 ).substr( 0, 7 ) + 
										", y:" + y.toFixed( 5 ).substr( 0, 7 ) + 
										", z:" + z.toFixed( 5 ).substr( 0, 7 ) + ")";
		}
		
	}

}