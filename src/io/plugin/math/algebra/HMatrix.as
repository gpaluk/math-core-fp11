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
	 * A homogeneous 4x4 matrix containing 16 elements, used to store rotation, scale, translation and projections.
	 * 
	 * @author Gary Paluk
	 */
	public class HMatrix implements IEquatable, ICloneable, IDisposable
	{
		
		/**
		 * The first element of the <code>HMatrix</code> Object.
		 */
		public var m00: Number;
		
		/**
		 * The second element of the <code>HMatrix</code> Object.
		 */
		public var m01: Number;
		
		/**
		 * The third element of the <code>HMatrix</code> Object.
		 */
		public var m02: Number;
		
		/**
		 * The fourth element of the <code>HMatrix</code> Object.
		 */
		public var m03: Number;
		
		/**
		 * The fifth element of the <code>HMatrix</code> Object.
		 */
		public var m10: Number;
		
		/**
		 * The sixth element of the <code>HMatrix</code> Object.
		 */
		public var m11: Number;
		
		/**
		 * The seventh element of the <code>HMatrix</code> Object.
		 */
		public var m12: Number;
		
		/**
		 * The eighth element of the <code>HMatrix</code> Object.
		 */
		public var m13: Number;
		
		/**
		 * The ninth element of the <code>HMatrix</code> Object.
		 */
		public var m20: Number;
		
		/**
		 * The tenth element of the <code>HMatrix</code> Object.
		 */
		public var m21: Number;
		
		/**
		 * The eleventh element of the <code>HMatrix</code> Object.
		 */
		public var m22: Number;
		
		/**
		 * The twelvth element of the <code>HMatrix</code> Object.
		 */
		public var m23: Number;
		
		/**
		 * The thirteenth element of the <code>HMatrix</code> Object.
		 */
		public var m30: Number;
		
		/**
		 * The fourteenth element of the <code>HMatrix</code> Object.
		 */
		public var m31: Number;
		
		/**
		 * The fifteenth element of the <code>HMatrix</code> Object.
		 */
		public var m32: Number;
		
		/**
		 * The sixteenth element of the <code>HMatrix</code> Object.
		 */
		public var m33: Number;
		
		/**
		 * A flag representing if this object has been disposed. True if the <code>dispose()</code> method has been called.
		 */
		protected var mIsDisposed: Boolean = false;
		
		/**
		 * Creates and returns a zero filled matrix object where all 16 values are 0.
		 */
		public static function get ZERO(): HMatrix
		{
			return new HMatrix( 0, 0, 0, 0,
								0, 0, 0, 0,
								0, 0, 0, 0,
								0, 0, 0, 0 );
		}
		
		/**
		 * Creates and returns an identity matrix.
		 */
		public static function get IDENTITY(): HMatrix
		{
			return new HMatrix( 1, 0, 0, 0,
								0, 1, 0, 0,
								0, 0, 1, 0,
								0, 0, 0, 1 );
		}
		
		/**
		 * A temporary <code>HMatrix</code> Object, used during computations where alaising may occur.
		 */
		private static const TEMP: HMatrix = new HMatrix();
		
		/**
		 * 
		 * @param	m00	The first element of the matrix.
		 * @param	m01	The second element of the matrix.
		 * @param	m02	The third element of the matrix.
		 * @param	m03	The fourth element of the matrix.
		 * @param	m10	The fifth element of the matrix.
		 * @param	m11	The sixth element of the matrix.
		 * @param	m12	The seventh element of the matrix.
		 * @param	m13	The eighth element of the matrix.
		 * @param	m20	The ninth element of the matrix.
		 * @param	m21	The tenth element of the matrix.
		 * @param	m22	The eleventh element of the matrix.
		 * @param	m23	The twelth element of the matrix.
		 * @param	m30	The thirteenth element of the matrix.
		 * @param	m31	The fourteenth element of the matrix.
		 * @param	m32	The fifteenth element of the matrix.
		 * @param	m33	The sixteenth element of the matrix.
		 */
		public function HMatrix( m00: Number = 1, m01: Number = 0, m02: Number = 0, m03: Number = 0,
								 m10: Number = 0, m11: Number = 1, m12: Number = 0, m13: Number = 0,
								 m20: Number = 0, m21: Number = 0, m22: Number = 1, m23: Number = 0,
								 m30: Number = 0, m31: Number = 0, m32: Number = 0, m33: Number = 1 ) 
		{
			this.m00 = m00;		this.m01 = m01;		this.m02 = m02;		this.m03 = m03;
			this.m10 = m10;		this.m11 = m11;		this.m12 = m12;		this.m13 = m13;
			this.m20 = m20;		this.m21 = m21;		this.m22 = m22;		this.m23 = m23;
			this.m30 = m30;		this.m31 = m31;		this.m32 = m32;		this.m33 = m33;
		}
		
		
		/**
		 * Disposes of this objects and frees the object ready for garbage collection.
		 */
		public function dispose(): void
		{
			
			mIsDisposed = true;
		}
		
		/**
		 * Creates a matrix from a set of tuples.
		 * 
		 * @param	tuple0	The first tuple.
		 * @param	tuple1	The second tuple.
		 * @param	tuple2	The third tuple.
		 * @param	tuple3	The fourth tuple.
		 * @param	columns	A boolean that indicates if the matrix is column or row major.
		 * 
		 * @return	The resulting <code>HMatrix</code> object.
		 */
		public static function fromTuple( tuple0: Array, tuple1: Array, tuple2: Array, tuple3: Array, columns: Boolean ): HMatrix
		{
			var matrix: HMatrix;
			
			if( columns )
			{
				matrix = new HMatrix (
						tuple0[ 0 ], tuple1[ 0 ], tuple2[ 0 ], tuple3[ 0 ],
						tuple0[ 1 ], tuple1[ 1 ], tuple2[ 1 ], tuple3[ 1 ],
						tuple0[ 2 ], tuple1[ 2 ], tuple2[ 2 ], tuple3[ 2 ],
						tuple0[ 3 ], tuple1[ 3 ], tuple2[ 3 ], tuple3[ 3 ]
					)
			}
			else
			{
				matrix = new HMatrix (
						tuple0[ 0 ], tuple0[ 1 ], tuple0[ 2 ], tuple0[ 3 ],
						tuple1[ 0 ], tuple1[ 1 ], tuple1[ 2 ], tuple1[ 3 ],
						tuple2[ 0 ], tuple2[ 1 ], tuple2[ 2 ], tuple2[ 3 ],
						tuple3[ 0 ], tuple3[ 1 ], tuple3[ 2 ], tuple3[ 3 ]
					)
			}
			return matrix;
		}
		
		public static function fromAxisAngle( axis: AVector, angle: Number ): HMatrix
		{
			return new HMatrix().rotation( axis, angle );
		}
		
		
		/**
		 * Gets a <code>Boolean</code> indicating if the <code>dispose()</code> method has been called and subsequently sets the isDisposed property to <code>true</code>.
		 */
		public function get isDisposed(): Boolean
		{
			return mIsDisposed;
		}
		
		/**
		 * Makes a shallow clone of this object is created passing the x, y and z properties to the clone.
		 * @return	A new shallow clone of this <code>Object</code>
		 */
		public function clone(): *
		{
			return new HMatrix( m00, m01, m02, m03,
								m10, m11, m12, m13,
								m20, m21, m22, m23,
								m30, m31, m32, m33 );
		}
		
		/**
		 * Creates and returns an <code>Array</code> containing the 16 elements of this <code>HMatrix</code> object.
		 * @return	The 16 elements of this <code>HMatrix</code> Object as an <code>Array</code>.
		 */
		public function toTuple(): Array
		{
			return [ m00, m01, m02, m03,
					 m10, m11, m12, m13,
					 m20, m21, m22, m23,
					 m30, m31, m32, m33 ];
		}
		
		public function toTuple2D():Array
		{
			return [[ m00, m01, m02, m03 ],
					[ m10, m11, m12, m13 ],
					[ m20, m21, m22, m23 ],
					[ m30, m31, m32, m33 ]];
		}
		
		/**
		 * Creates a new <code>HMatrix</code> Object by the x, y, and z properties of an <code>AVector</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> to translate the <code>HMatrix</code> Object by.
		 * @return	A new <code>HMatrix</code> Object with the appended translation applied.
		 */
		/*
		public function translateAVector( v: AVector ): HMatrix
		{
			return new HMatrix( m00, m01, m02, m03 + v.x,
								m10, m11, m12, m13 + v.y,
								m20, m21, m22, m23 + v.z,
								m30, m31, m32, m33 );
		}
		*/
		
		/**
		 * Translates the <code>HMatrix</code> Object by an <code>AVector</code> Objects and assign the result to <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> to translate the <code>HMatrix</code> Object by. 
		 * @return	<code>this</code> Object with the appended translation applied.
		 */
		/*
		public function translateAVectorEq( v: AVector ): HMatrix
		{
			m03 += v.x;
			m13 += v.y;
			m23 += v.z;
			
			return this;
		}
		*/
		
		/**
		 * Creates and return an <code>Vector</code> containing the 16 elements of this <code>HMatrix</code> object.
		 * 
		 * @return	The 16 elements of this <code>HMatrix</code> object as a <code>Vector</code>.
		 */
		public function toVector(): Vector.<Number>
		{
			var v: Vector.<Number> = new Vector.<Number>( 16, true );
			v[ 0 ] = m00;		v[ 1 ] = m01;		v[ 2 ] = m02;		v[ 3 ] = m03;
			v[ 4 ] = m10;		v[ 5 ] = m11;		v[ 6 ] = m12;		v[ 7 ] = m13;
			v[ 8 ] = m20;		v[ 9 ] = m21;		v[ 10 ] = m22;		v[ 11 ] = m23;
			v[ 12 ] = m30;		v[ 13 ] = m31;		v[ 14 ] = m32;		v[ 15 ] = m33;
			return v;
		}
		
		/**
		 * Helper method that allows the simultaneous setting of the 16 elements of this <code>HMatrix</code> object.
		 *
		 * @param	m00	The first element of the matrix.
		 * @param	m01	The second element of the matrix.
		 * @param	m02	The third element of the matrix.
		 * @param	m03	The fourth element of the matrix.
		 * @param	m10	The fifth element of the matrix.
		 * @param	m11	The sixth element of the matrix.
		 * @param	m12	The seventh element of the matrix.
		 * @param	m13	The eighth element of the matrix.
		 * @param	m20	The ninth element of the matrix.
		 * @param	m21	The tenth element of the matrix.
		 * @param	m22	The eleventh element of the matrix.
		 * @param	m23	The twelth element of the matrix.
		 * @param	m30	The thirteenth element of the matrix.
		 * @param	m31	The fourteenth element of the matrix.
		 * @param	m32	The fifteenth element of the matrix.
		 * @param	m33	The sixteenth element of the matrix.
		 * 
		 * @return	<code>this</code> Object with the newly assigned element values.
		 */
		public function set( m00: Number, m01: Number, m02: Number, m03: Number,
							 m10: Number, m11: Number, m12: Number, m13: Number,
							 m20: Number, m21: Number, m22: Number, m23: Number,
							 m30: Number, m31: Number, m32: Number, m33: Number ): HMatrix
		{
			this.m00 = m00;		this.m01 = m01;		this.m02 = m02;		this.m03 = m03;
			this.m10 = m10;		this.m11 = m11;		this.m12 = m12;		this.m13 = m13;
			this.m20 = m20;		this.m21 = m21;		this.m22 = m22;		this.m23 = m23;
			this.m30 = m30;		this.m31 = m31;		this.m32 = m32;		this.m33 = m33;
			
			return this;
		}
		
		/**
		 * Performs an equality check between this <code>HMatrix</code> and another <code>HMatrix</code> object.
		 * 
		 * @param	m	A <code>HMatrix</code> object to compare against.
		 * @return		True if the <code>AVector</code> objects contain the same 16 element values, false if not.
		 */
		public function equals( m: Object ): Boolean
		{
			if ( m is HMatrix )
			{
				return ( m00 == m.m00 && m01 == m.m01 && m02 == m.m02 && m03 == m.m03 &&
						 m10 == m.m10 && m11 == m.m11 && m12 == m.m12 && m13 == m.m13 &&
						 m20 == m.m20 && m21 == m.m21 && m22 == m.m22 && m23 == m.m23 &&
						 m30 == m.m30 && m31 == m.m31 && m32 == m.m32 && m33 == m.m33 );
			}
			return false;
		}
		
		/**
		 * Adds two <code>HMatrix</code> Objects together whilst preserving this <code>HMatrix</code> object and returns a new <code>HMatrix</code> object.
		 * 
		 * @param	m	The <code>HMatrix</code> object to add to <code>this</code> object.
		 * @return	The resulting new <code>HMatrix</code> object containing the result of the addition.
		 */
		public function add( m: HMatrix ): HMatrix
		{
			return new HMatrix( m00 + m.m00,	m01 + m.m01,	m02 + m.m02,	m03 + m.m03,
								m10 + m.m10,	m11 + m.m11,	m12 + m.m12,	m13 + m.m13,
								m20 + m.m20,	m21 + m.m21,	m22 + m.m22,	m23 + m.m23,
								m30 + m.m30,	m31 + m.m31,	m32 + m.m32,	m33 + m.m33 );
		}
		
		/**
		 * Adds two <code>HMatrix</code> Objects together and assigns the result to this <code>HMatrix</code> Object.
		 * 
		 * @param	m	A <code>HMatrix</code> object to add to <code>this</code> Object.
		 * @return	<code>this</code> Object containing the result of the addition.
		 */
		public function addEq( m: HMatrix ): HMatrix
		{
			m00 += m.m00;	m01 += m.m01;	m02 += m.m02;	m03 += m.m03;
			m10 += m.m10;	m11 += m.m11;	m12 += m.m12;	m13 += m.m13;
			m20 += m.m20;	m21 += m.m21;	m22 += m.m22;	m23 += m.m23;
			m30 += m.m30;	m31 += m.m31;	m32 += m.m32;	m33 += m.m33;
			return this;
		}
		
		/**
		 * Subtracts a <code>HMatrix</code> Object from <code>this</code> object whilst preserving <code>this</code> Object.
		 * 
		 * @param	m	The <code>HMatrix</code> Object to subtract from this Object.
		 * @return	A new <code>HMatix</code> Object containing the result of the subtraction.
		 */
		public function subtract( m: HMatrix ): HMatrix
		{
			return new HMatrix( m00 - m.m00,	m01 - m.m01,	m02 - m.m02,	m03 - m.m03,
								m10 - m.m10,	m11 - m.m11,	m12 - m.m12,	m13 - m.m13,
								m20 - m.m20,	m21 - m.m21,	m22 - m.m22,	m23 - m.m23,
								m30 - m.m30,	m31 - m.m31,	m32 - m.m32,	m33 - m.m33 );
		}
		
		/**
		 * Subtracts an <code>HMatrix</code> Object from this <code>HMatrix</code> Object and assigns the result to this <code>HMatrix</code> Object.
		 * 
		 * @param	p	The <code>HMatrix</code> Object to subtract from this <code>HMatrix</code> Object.
		 * @return	<code>this</code> Object containing the result of the subtraction.
		 */
		public function subtractEq( m: HMatrix ): HMatrix
		{
			m00 -= m.m00;	m01 -= m.m01;	m02 -= m.m02;	m03 -= m.m03;
			m10 -= m.m10;	m11 -= m.m11;	m12 -= m.m12;	m13 -= m.m13;
			m20 -= m.m20;	m21 -= m.m21;	m22 -= m.m22;	m23 -= m.m23;
			m30 -= m.m30;	m31 -= m.m31;	m32 -= m.m32;	m33 -= m.m33;
			return this;
		}
		
		/**
		 * Multiplies <code>this</code> Object by a <code>HMatrix</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	m	The <code>HMatrix</code> to multiply with this <code>HMatrix</code>.
		 * @return	A new <code>HMatrix</code> Object containing the result of the multiplication.
		 */
		public function multiply( m: HMatrix ): HMatrix
		{
			return new HMatrix( m00 * m.m00 + m01 * m.m10 + m02 * m.m20 + m03 * m.m30,
								m00 * m.m01 + m01 * m.m11 + m02 * m.m21 + m03 * m.m31,
								m00 * m.m02 + m01 * m.m12 + m02 * m.m22 + m03 * m.m32,
								m00 * m.m03 + m01 * m.m13 + m02 * m.m23 + m03 * m.m33,
								
								m10 * m.m00 + m11 * m.m10 + m12 * m.m20 + m13 * m.m30,
								m10 * m.m01 + m11 * m.m11 + m12 * m.m21 + m13 * m.m31,
								m10 * m.m02 + m11 * m.m12 + m12 * m.m22 + m13 * m.m32,
								m10 * m.m03 + m11 * m.m13 + m12 * m.m23 + m13 * m.m33,
								
								m20 * m.m00 + m21 * m.m10 + m22 * m.m20 + m23 * m.m30,
								m20 * m.m01 + m21 * m.m11 + m22 * m.m21 + m23 * m.m31,
								m20 * m.m02 + m21 * m.m12 + m22 * m.m22 + m23 * m.m32,
								m20 * m.m03 + m21 * m.m13 + m22 * m.m23 + m23 * m.m33,
								
								m30 * m.m00 + m31 * m.m10 + m32 * m.m20 + m33 * m.m30,
								m30 * m.m01 + m31 * m.m11 + m32 * m.m21 + m33 * m.m31,
								m30 * m.m02 + m31 * m.m12 + m32 * m.m22 + m33 * m.m32,
								m30 * m.m03 + m31 * m.m13 + m32 * m.m23 + m33 * m.m33 );
		}
		
		/**
		 * Multiplies <code>this</code> Object by a <code>HMatrix</code> and assigns the result to this <code>HMatrix</code> Object.
		 * 
		 * @param	m	The <code>HMatrix</code> to multiply <code>this</code> Object by.
		 * @return	<code>this</code> Object containing the result of the multiplication.
		 */
		public function multiplyEq( m: HMatrix ): HMatrix
		{
			TEMP.m00 = m00 * m.m00 + m01 * m.m10 + m02 * m.m20 + m03 * m.m30;
			TEMP.m01 = m00 * m.m01 + m01 * m.m11 + m02 * m.m21 + m03 * m.m31;
			TEMP.m02 = m00 * m.m02 + m01 * m.m12 + m02 * m.m22 + m03 * m.m32;
			TEMP.m03 = m00 * m.m03 + m01 * m.m13 + m02 * m.m23 + m03 * m.m33;
			
			TEMP.m10 = m10 * m.m00 + m11 * m.m10 + m12 * m.m20 + m13 * m.m30;
			TEMP.m11 = m10 * m.m01 + m11 * m.m11 + m12 * m.m21 + m13 * m.m31;
			TEMP.m12 = m10 * m.m02 + m11 * m.m12 + m12 * m.m22 + m13 * m.m32;
			TEMP.m13 = m10 * m.m03 + m11 * m.m13 + m12 * m.m23 + m13 * m.m33;
			
			TEMP.m20 = m20 * m.m00 + m21 * m.m10 + m22 * m.m20 + m23 * m.m30;
			TEMP.m21 = m20 * m.m01 + m21 * m.m11 + m22 * m.m21 + m23 * m.m31;
			TEMP.m22 = m20 * m.m02 + m21 * m.m12 + m22 * m.m22 + m23 * m.m32;
			TEMP.m23 = m20 * m.m03 + m21 * m.m13 + m22 * m.m23 + m23 * m.m33;
			
			TEMP.m30 = m30 * m.m00 + m31 * m.m10 + m32 * m.m20 + m33 * m.m30;
			TEMP.m31 = m30 * m.m01 + m31 * m.m11 + m32 * m.m21 + m33 * m.m31;
			TEMP.m32 = m30 * m.m02 + m31 * m.m12 + m32 * m.m22 + m33 * m.m32;
			TEMP.m33 = m30 * m.m03 + m31 * m.m13 + m32 * m.m23 + m33 * m.m33;
			
			m00 = TEMP.m00;		m01 = TEMP.m01;		m02 = TEMP.m02;		m03 = TEMP.m03;
			m10 = TEMP.m10;		m11 = TEMP.m11;		m12 = TEMP.m12;		m13 = TEMP.m13;
			m20 = TEMP.m20;		m21 = TEMP.m21;		m22 = TEMP.m22;		m23 = TEMP.m23;
			m30 = TEMP.m30;		m31 = TEMP.m31;		m32 = TEMP.m32;		m33 = TEMP.m33;
			
			return this;
		}
		
		/**
		 * Multiplies <code>this</code> object by a <code>Number</code> scaler whilst preserving <code>this</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to scale this Object by.
		 * @return	A new <code>HMatrix</code> Object containing the result of the multiplication.
		 */
		public function scale( scaler: Number ): HMatrix
		{
			return new HMatrix( m00 * scaler,		m01 * scaler,		m02 * scaler,		m03 * scaler,
								m10 * scaler,		m11 * scaler,		m12 * scaler,		m13 * scaler,
								m20 * scaler,		m21 * scaler,		m22 * scaler,		m23 * scaler,
								m30 * scaler,		m31 * scaler,		m32 * scaler,		m33 * scaler );
		}
		
		/**
		 * Multiplies <code>this</code> Object by a <code>Number</code> scaler and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to scale <code>this</code> Object by.
		 * @return	<code>this</code> Object containing the result of the multiplication.
		 */
		public function scaleEq( scaler: Number ): HMatrix
		{
			m00 *= scaler;		m01 *= scaler;		m02 *= scaler;		m03 *= scaler;
			m10 *= scaler;		m11 *= scaler;		m12 *= scaler;		m13 *= scaler;
			m20 *= scaler;		m21 *= scaler;		m22 *= scaler;		m23 *= scaler;
			m30 *= scaler;		m31 *= scaler;		m32 *= scaler;		m33 *= scaler;
			return this;
		}
		
		/**
		 * Divides <code>this</code> Object by a scaler <code>Number</code> value whilst preserving <code>this</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to divide <code>this</code> Object by.
		 * @return	A new <code>APoint</code> Object containing the result of the division.
		 */
		public function divide( scaler: Number ): HMatrix
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				
				return new HMatrix( m00 * invScaler,		m01 * invScaler,		m02 * invScaler,		m03 * invScaler,
									m10 * invScaler,		m11 * invScaler,		m12 * invScaler,		m13 * invScaler,
									m20 * invScaler,		m21 * invScaler,		m22 * invScaler,		m23 * invScaler,
									m30 * invScaler,		m31 * invScaler,		m32 * invScaler,		m33 * invScaler )
				
			}
			return new HMatrix( Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE, 
								Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,
								Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,
								Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE,	Number.MAX_VALUE );
		}
		
		/**
		 * Divides <code>this</code> Object by a scaler <code>Number</code> and assigns the result to this <code>APoint</code> Object.
		 * 
		 * @param	scaler	The <code>Number</code> to divide <code>this</code> Object by.
		 * @return	<code>this</code> Object containing the result of the division.
		 */
		public function divideEq( scaler: Number ): HMatrix
		{
			if ( scaler != 0 )
			{
				var invScaler: Number = 1 / scaler;
				
				m00 *= invScaler;		m01 *= invScaler;		m02 *= invScaler;		m03 *= invScaler;
				m10 *= invScaler;		m11 *= invScaler;		m12 *= invScaler;		m13 *= invScaler;
				m20 *= invScaler;		m21 *= invScaler;		m22 *= invScaler;		m23 *= invScaler;
				m30 *= invScaler;		m31 *= invScaler;		m32 *= invScaler;		m33 *= invScaler;
			}
			else
			{
				m00 *= Number.MAX_VALUE;		m01 *= Number.MAX_VALUE;		m02 *= Number.MAX_VALUE;		m03 *= Number.MAX_VALUE;
				m10 *= Number.MAX_VALUE;		m11 *= Number.MAX_VALUE;		m12 *= Number.MAX_VALUE;		m13 *= Number.MAX_VALUE;
				m20 *= Number.MAX_VALUE;		m21 *= Number.MAX_VALUE;		m22 *= Number.MAX_VALUE;		m23 *= Number.MAX_VALUE;
				m30 *= Number.MAX_VALUE;		m31 *= Number.MAX_VALUE;		m32 *= Number.MAX_VALUE;		m33 *= Number.MAX_VALUE;
			}
			
			return this;
		}
		
		/**
		 * Multiplies an <code>AVector</code> Object from <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	v	The <code>AVector</code> Object to subtract from this Object.
		 * @return	A new <code>AVector</code> Object containing the result of the multiplication.
		 */
		public function multiplyAVector( v: AVector ): AVector
		{
			return new AVector( v.x * m00 + v.y * m01 + v.z * m02,
								v.x * m10 + v.y * m11 + v.z * m12,
								v.x * m20 + v.y * m21 + v.z * m22 );
		}
		
		/**
		 * Multiplies an <code>HPoint</code> Object from <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	p	The <code>HPoint</code> Object to subtract from this Object.
		 * @return	A new <code>HPoint</code> Object containing the result of the multiplication.
		 */
		public function multiplyHPoint( p: HPoint ): HPoint
		{
			return new HPoint( p.x * m00 + p.y * m01 + p.z * m02 + p.w * m03,
							   p.x * m10 + p.y * m11 + p.z * m12 + p.w * m13,
							   p.x * m20 + p.y * m21 + p.z * m22 + p.w * m23,
							   p.x * m30 + p.y * m31 + p.z * m32 + p.w * m33 );
		}
		
		/**
		 * Multiplies an <code>APoint</code> Object from <code>this</code> Object whilst preserving <code>this</code> Object.
		 * 
		 * @param	p	The <code>APoint</code> Object to subtract from this Object.
		 * 
		 * @return	A new <code>APoint</code> Object containing the result of the multiplication.
		 */
		public function multiplyAPoint( p: APoint ): APoint
		{
			return new APoint( p.x * m00 + p.y * m01 + p.z * m02 + m03,
							   p.x * m10 + p.y * m11 + p.z * m12 + m13,
							   p.x * m20 + p.y * m21 + p.z * m22 + m23 );
		}
		
		/**
		 * Set all element of the <code>HMatrix</code> to 0 and return this Object.
		 * 
		 * @return	<code>this</code> Object where all elements are set to 0.
		 */
		public function makeZero(): HMatrix
		{
			m00 = 0;	m01 = 0;	m02 = 0;	m03 = 0;
			m10 = 0;	m11 = 0;	m12 = 0;	m13 = 0;
			m20 = 0;	m21 = 0;	m22 = 0;	m23 = 0;
			m30 = 0;	m31 = 0;	m32 = 0;	m33 = 0;
			
			return this;
		}
		
		/**
		 * Set all element of the <code>HMatrix</code> to be an identity matrix and return this Object.
		 * 
		 * @return	<code>this</code> Object where all elements are set to represent an identity matrix.
		 */
		public function identity(): HMatrix
		{
			m00 = 1;	m01 = 0;	m02 = 0;	m03 = 0;
			m10 = 0;	m11 = 1;	m12 = 0;	m13 = 0;
			m20 = 0;	m21 = 0;	m22 = 1;	m23 = 0;
			m30 = 0;	m31 = 0;	m32 = 0;	m33 = 1;
			
			return this;
		}
		
		/**
		 * Sets the diagonal elements, m00, m11 and m22 with new element values and returns <code>this</code> Object.
		 * 
		 * @param	m00	The value of element m00, the first element of the <code>HMatrix</code>.
		 * @param	m11	The value of element m11, the sixth element of the <code>HMatrix</code>.
		 * @param	m22	The value of element m22, the eleventh element of the <code>HMatrix</code>.
		 * 
		 * @return	<code>this</code> Object with the new diagnonal elements values defined.
		 */
		public function diagonal( m00: Number, m11: Number, m22: Number ): HMatrix
		{
			this.m00 = m00;		m01 = 0;			m02 = 0;			m03 = 0;
			m10 = 0;			this.m11 = m11;		m12 = 0;			m13 = 0;
			m20 = 0;			m21 = 0;			this.m22 = m22;		m23 = 0;
			m30 = 0;			m31 = 0;			m32 = 0;			m33 = 1;
			
			return this;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to a rotation matrix that represents a rotation on the <code>x</code> axis.
		 * 
		 * @param	angle	The rotation value in radians.
		 * 
		 * @return	<code>this</code> Object where the elements represent a rotation on the <code>x</code> axis.
		 */
		public function rotationX( angle: Number ): HMatrix
		{
			var c: Number = Math.cos( angle );
			var s: Number = Math.sin( angle );
			
			m00 = 1;	m01 = 0;	m02 = 0;	m03 = 0;
			m10 = 0;	m11 = c;	m12 =-s;	m13 = 0;
			m20 = 0;	m21 = s;	m22 = c;	m23 = 0;
			m30 = 0;	m31 = 0;	m32 = 0;	m33 = 1;
			
			return this;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to a rotation matrix that represents a rotation on the <code>y</code> axis.
		 * 
		 * @param	angle	The rotation value in radians.
		 * 
		 * @return	<code>this</code> Object where the elements represent a rotation on the <code>y</code> axis.
		 */
		public function rotationY( angle: Number ): HMatrix
		{
			var c: Number = Math.cos( angle );
			var s: Number = Math.sin( angle );
			
			m00 = c;	m01 = 0;	m02 = s;	m03 = 0;
			m10 = 0;	m11 = 1;	m12 = 0;	m13 = 0;
			m20 =-s;	m21 = 0;	m22 = c;	m23 = 0;
			m30 = 0;	m31 = 0;	m32 = 0;	m33 = 1;
			
			return this;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to a rotation matrix that represents a rotation on the <code>z</code> axis.
		 * 
		 * @param	angle	The rotation value in radians.
		 * 
		 * @return	<code>this</code> Object where the elements represent a rotation on the <code>z</code> axis.
		 */
		public function rotationZ( angle: Number ): HMatrix
		{
			var c: Number = Math.cos( angle );
			var s: Number = Math.sin( angle );
			
			m00 = c;	m01 =-s;	m02 = 0;	m03 = 0;
			m10 = s;	m11 = c;	m12 = 0;	m13 = 0;
			m20 = 0;	m21 = 0;	m22 = 1;	m23 = 0;
			m30 = 0;	m31 = 0;	m32 = 0;	m33 = 1;
			
			return this;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to a rotation matrix that represents a rotation on all axes.
		 * 
		 * @param	angle	The rotation value in radians.
		 * 
		 * @return	<code>this</code> Object where the elements represent a rotation on the <code>x</code> axis.
		 */
		public function rotation( axis: AVector, angle: Number ): HMatrix
		{
			var cs: Number = Math.cos( angle );
			var sn: Number = Math.sin( angle );
			var oneMinusCos: Number = 1 - cs;
			
			var x2: Number = axis.x * axis.x;
			var y2: Number = axis.y * axis.y;
			var z2: Number = axis.z * axis.z;
			
			var xym: Number = axis.x * axis.y * oneMinusCos;
			var xzm: Number = axis.x * axis.z * oneMinusCos;
			var yzm: Number = axis.y * axis.z * oneMinusCos;
			
			var xSin: Number = axis.x * sn;
			var ySin: Number = axis.y * sn;
			var zSin: Number = axis.z * sn;
			
			m00 = x2 * oneMinusCos + cs;
			m01 = xym - zSin;
			m02 = xzm + ySin;
			m03 = 0;
			
			m10 = xym + zSin;
			m11 = y2 * oneMinusCos + cs;
			m12 = yzm - xSin;
			m13 = 0;
			
			m20 = xzm - ySin;
			m21 = yzm + xSin;
			m22 = z2 * oneMinusCos + cs;
			m23 = 0;
			
			m30 = 0;
			m31 = 0;
			m32 = 0;
			m33 = 1;
			
			return this;
		}
		
		/**
		 * A new transposed representation of <code>this</code> Object.
		 * 
		 * @return	A new transposed representation of <code>this</code> Object.
		 */
		public function transpose(): HMatrix
		{
			return new HMatrix( m00, m10, m20, m30,
								m01, m11, m21, m31,
								m02, m12, m22, m32,
								m03, m13, m23, m33 );
		}
		
		public function transposeTimes( mat: HMatrix ): HMatrix
		{
			return new HMatrix(
				m00 * mat.m00 +
				m10 * mat.m10 +
				m20 * mat.m20 +
				m30 * mat.m30,
				
				m00 * mat.m01 +
				m10 * mat.m11 +
				m20 * mat.m21 +
				m30 * mat.m31,
				
				m00 * mat.m02 +
				m10 * mat.m12 +
				m20 * mat.m22 +
				m30 * mat.m32,
				
				m00 * mat.m03 +
				m10 * mat.m13 +
				m20 * mat.m23 +
				m30 * mat.m33,
				
				m01 * mat.m00 +
				m11 * mat.m10 +
				m21 * mat.m20 +
				m31 * mat.m30,
				
				m01 * mat.m01 +
				m11 * mat.m11 +
				m21 * mat.m21 +
				m31 * mat.m31,
				
				m01 * mat.m02 +
				m11 * mat.m12 +
				m21 * mat.m22 +
				m31 * mat.m32,
				
				m01 * mat.m03 +
				m11 * mat.m13 +
				m21 * mat.m23 +
				m31 * mat.m33,
				
				m02 * mat.m00 +
				m12 * mat.m10 +
				m22 * mat.m20 +
				m32 * mat.m30,
				
				m02 * mat.m01 +
				m12 * mat.m11 +
				m22 * mat.m21 +
				m32 * mat.m31,
				
				m02 * mat.m02 +
				m12 * mat.m12 +
				m22 * mat.m22 +
				m32 * mat.m32,
				
				m02 * mat.m03 +
				m12 * mat.m13 +
				m22 * mat.m23 +
				m32 * mat.m33,
				
				m03 * mat.m00 +
				m13 * mat.m10 +
				m23 * mat.m20 +
				m33 * mat.m30,
				
				m03 * mat.m01 +
				m13 * mat.m11 +
				m23 * mat.m21 +
				m33 * mat.m31,
				
				m03 * mat.m02 +
				m13 * mat.m12 +
				m23 * mat.m22 +
				m33 * mat.m32,
				
				m03 * mat.m03 +
				m13 * mat.m13 +
				m23 * mat.m23 +
				m33 * mat.m33 );
		}
		
		/**
		 * A new inverse representation of <code>this</code> Object.
		 * 
		 * @return	A new inverse representation of <code>this</code> Object.
		 */
		public function inverse( epsilon: Number = 1e-8 ): HMatrix
		{
			
			var a0: Number = m00 * m11 - m01 * m10;
			var a1: Number = m00 * m12 - m02 * m10;
			var a2: Number = m00 * m13 - m03 * m10;
			var a3: Number = m01 * m12 - m02 * m11;
			var a4: Number = m01 * m13 - m03 * m11;
			var a5: Number = m02 * m13 - m03 * m12;
			
			var b0: Number  = m20 * m31 - m21 * m30;
			var b1: Number  = m20 * m32 - m22 * m30;
			var b2: Number  = m20 * m33 - m23 * m30;
			var b3: Number  = m21 * m32 - m22 * m31;
			var b4: Number  = m21 * m33 - m23 * m31;
			var b5: Number  = m22 * m33 - m23 * m32;
			
			
			var det: Number = a0 * b5 - a1 * b4 + a2 * b3 + a3 * b2 - a4 * b1 + a5 * b0;
			if ( Math.abs(det) <= epsilon )
			{
				return ZERO;
			}
			
			var inverse: HMatrix = new HMatrix();
			
			inverse.m00 = + m11 * b5 - m12 * b4 + m13 * b3;
			inverse.m10 = - m10 * b5 + m12 * b2 - m13 * b1;
			inverse.m20 = + m10 * b4 - m11 * b2 + m13 * b0;
			inverse.m30 = - m10 * b3 + m11 * b1 - m12 * b0;
			inverse.m01 = - m01 * b5 + m02 * b4 - m03 * b3;
			inverse.m11 = + m00 * b5 - m02 * b2 + m03 * b1;
			inverse.m21 = - m00 * b4 + m01 * b2 - m03 * b0;
			inverse.m31 = + m00 * b3 - m01 * b1 + m02 * b0;
			inverse.m02 = + m31 * a5 - m32 * a4 + m33 * a3;
			inverse.m12 = - m30 * a5 + m32 * a2 - m33 * a1;
			inverse.m22 = + m30 * a4 - m31 * a2 + m33 * a0;
			inverse.m32 = - m30 * a3 + m31 * a1 - m32 * a0;
			inverse.m03 = - m21 * a5 + m22 * a4 - m23 * a3;
			inverse.m13 = + m20 * a5 - m22 * a2 + m23 * a1;
			inverse.m23 = - m20 * a4 + m21 * a2 - m23 * a0;
			inverse.m33 = + m20 * a3 - m21 * a1 + m22 * a0;
			
			var invDet: Number = 1 / det;
			
			inverse.m00 *= invDet;
			inverse.m01 *= invDet;
			inverse.m02 *= invDet;
			inverse.m03 *= invDet;
			inverse.m10 *= invDet;
			inverse.m11 *= invDet;
			inverse.m12 *= invDet;
			inverse.m13 *= invDet;
			inverse.m20 *= invDet;
			inverse.m21 *= invDet;
			inverse.m22 *= invDet;
			inverse.m23 *= invDet;
			inverse.m30 *= invDet;
			inverse.m31 *= invDet;
			inverse.m32 *= invDet;
			inverse.m33 *= invDet;
			
			return inverse;
			
		}
		
		// TODO implement adjoint
		
		/**
		 * Creates the determinant value of this <code>HMatrix</code> Object.
		 * 
		 * @return he determinant value of this <code>HMatrix</code> Object.
		 */
		public function determinant(): Number
		{
			return ( m00 * m11 - m01 * m10 ) * ( m22 * m33 - m23 * m32 )
				  -( m00 * m12 - m02 * m10 ) * ( m21 * m33 - m23 * m31 )
				  +( m00 * m13 - m03 * m10 ) * ( m21 * m32 - m22 * m31 )
				  +( m01 * m12 - m02 * m11 ) * ( m20 * m33 - m23 * m30 )
				  -( m01 * m13 - m03 * m11 ) * ( m20 * m32 - m22 * m30 )
				  +( m02 * m13 - m03 * m12 ) * ( m20 * m31 - m21 * m30 );
		}
		
		// TODO implement transposeTimes()
		
		// TODO implement timesTranspose()
		
		// TODO implement transposeTimesTranspose()
		
		public function orthonormalize(): HMatrix
		{
			
			var invLength: Number = 1 / Math.sqrt( m00 * m00 + m10 * m10 + m20 * m20 );
			
			m00 *= invLength;
			m10 *= invLength;
			m20 *= invLength;
			
			var dot0: Number = m00 * m01 + m10 * m11 + m20 * m21;
			
			m01 -= dot0 * m00;
			m11 -= dot0 * m10;
			m21 -= dot0 * m20;
			
			invLength = 1 / Math.sqrt( m01 * m01 + m11 * m11 + m21 * m21 );
			
			m01 *= invLength;
			m11 *= invLength;
			m21 *= invLength;
			
			var dot1: Number = m01 * m02 + m11 * m12 + m21 * m22;
			
			dot0 = m00 * m02 + m10 * m12 + m20 * m22;
			
			m02 -= dot0 * m00 + dot1 * m01;
			m12 -= dot0 * m10 + dot1 * m11;
			m22 -= dot0 * m20 + dot1 * m21;
			
			invLength = 1 / Math.sqrt( m02 * m02 + m12 * m12 + m22 * m22 );
			
			m02 *= invLength;
			m12 *= invLength;
			m22 *= invLength;
			
			return this;
		}
		
		public function timesDiagonal( p: APoint ): HMatrix
		{
			return new HMatrix( m00 * p.x, m01 * p.y, m02 * p.z, m03,
								m10 * p.x, m11 * p.y, m12 * p.z, m13,
								m20 * p.x, m21 * p.y, m22 * p.z, m23,
								m30 * p.x, m31 * p.y, m32 * p.z, m33 );
		}
		
		public function diagonalTimes( p: APoint ): HMatrix
		{
			return new HMatrix ( p.x * m00, p.x * m01, p.x * m02, m03,
								 p.y * m10, p.y * m11, p.y * m12, m13,
								 p.z * m20, p.z * m21, p.z * m22, m23,
								 m30, m31, m32, m33 );
		}
		
		
		
		/**
		 * Creates the quadratic form representation on this <code>HMatrix</code> Object.
		 * 
		 * @param	p0	
		 * @param	p1
		 * @return	A <code>Number</code> representation as quadratic form notation.
		 */
		public function quadForm( p0: HPoint, p1: HPoint ): Number
		{
			var mp1: HPoint = new HPoint( m00 * p1.x + m01 * p1.y + m02 * p1.z + m03 * p1.w,
										  m10 * p1.x + m11 * p1.y + m12 * p1.z + m13 * p1.w,
										  m20 * p1.x + m21 * p1.y + m22 * p1.z + m23 * p1.w,
										  m30 * p1.x + m31 * p1.y + m32 * p1.z + m33 * p1.w );
			
			return p0.x * p1.x + p0.y * p1.y + p0.z * p1.z + p0.w * p1.w;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to an oblique projection matrix.
		 * 
		 * @param	origin	The projection origin
		 * @param	normal	The normal vector
		 * @param	direction	An <code>AVector</code> defining the direction of the projection.
		 * 
		 * @return	<code>this</code> Object with elements set to the new oblique projection matrix values.
		 */
		public function obliqueProjection( origin: APoint, normal: AVector, direction: AVector ): HMatrix
		{
			var dotND: Number = normal.dotProduct( direction );
			var dotNO: Number = origin.dotProduct( normal );
			
			m00 = direction.x * normal.x - dotND;
			m01 = direction.x * normal.y;
			m02 = direction.x * normal.z;
			m03 = -dotNO * direction.x;
			
			m10 = direction.y * normal.x;
			m11 = direction.y * normal.y - dotND;
			m12 = direction.y * normal.z;
			m13 = -dotNO * direction.y;
			
			m20 = direction.z * normal.x;
			m21 = direction.z * normal.y;
			m22 = direction.z * normal.z - dotND;
			m23 = -dotNO * direction.z;
			
			m30 = 0;
			m31 = 0;
			m32 = 0;
			m33 = -dotND;
			
			return this;
		}
		
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to an perspective projection matrix.
		 * 
		 * @param	origin	The projection origin
		 * @param	normal	The normal vector
		 * @param	eye	The eye location 
		 * 
		 * @return	<code>this</code> Object with elements set to the new perspective projection matrix values.
		 */
		public function perspectiveProjection( origin: APoint, normal: AVector, eye: APoint ): HMatrix
		{
			var dotND: Number = normal.dotProduct( eye.subtract( origin ) );
			
			m00 = dotND - eye.x * normal.x;
			m01 = -eye.x * normal.x;
			m02 = -eye.x * normal.y;
			m03 = -( m00 * eye.x + m01 * eye.y + m02 * eye.z );
			
			m10 = -eye.y * normal.x;
			m11 = dotND - eye.y * normal.y;
			m12 = -eye.y * normal.z;
			m13 = -( m10 * eye.x + m11 * eye.y + m12 * eye.z );
			
			m20 = -eye.z * normal.x;
			m21 = -eye.z * normal.y;
			m22 = dotND - eye.z * normal.z;
			m23 = -( m20 * eye.x + m21 * eye.y + m22 * eye.z );
			
			m30 = -normal.x;
			m31 = -normal.y;
			m32 = -normal.z;
			m33 = eye.dotProduct( normal );
			
			return this;
		}
		
		/**
		 * Sets the elements of this <code>HMatrix</code> to an perspective projection matrix.
		 * 
		 * @param	origin	The reflection origin
		 * @param	normal	The normal vector
		 */
		public function reflection( origin: APoint, normal: AVector ): void
		{
			var twoDotNO: Number = 2 * origin.dotProduct( normal );
			
			m00 = 1 - 2 * normal.x * normal.x;
			m01 = -2 * normal.x * normal.y;
			m02 = -2 * normal.x * normal.z;
			m03 = twoDotNO * normal.x;
			
			m10 = -2 * normal.y * normal.x;
			m11 = 1 - 2 * normal.y * normal.y;
			m12 = -2 * normal.y * normal.z;
			m13 = twoDotNO * normal.y;
			
			m20 = -2 * normal.z * normal.x;
			m21 = -2 * normal.z * normal.y;
			m22 = 1 - 2 * normal.z * normal.z;
			m23 = twoDotNO * normal.z;
			
			m30 = 0;
			m31 = 0;
			m32 = 0;
			m33 = 1;
		}
		
		/**
		 * Get a column from the <code>HMatrix</code> Object. Column values are 0, 1, 2 and 3.
		 * 
		 * @param	column	The column number of the <code>HMatrix</code> Object.
		 * 
		 * @return	The 4 element values associated with the column as an <code>Array</code>
		 */
		public function getColumn( column: int ): Array
		{
			switch( column )
			{
				case 0:
					return [ m00, m10, m20, m30 ];
				break;
				case 1:
					return [ m01, m11, m21, m31 ];
				break;
				case 2:
					return [ m02, m12, m22, m32 ];
				break;
				case 3:
					return [ m03, m13, m23, m33 ];
				break;
				default:
					throw new Error( "Invalid column." );
				break;
			}
		}
		
		public function setColumn( column: int, data:Array ): void
		{
			if ( data.length != 4 )
			{
				throw new Error( "Invalid length." );
			}
			switch( column )
			{
				case 0:
					m00 = data[0];
					m10 = data[1], 
					m20 = data[2], 
					m30 = data[3];
				break;
				case 1:
					m01 = data[0];
					m11 = data[1], 
					m21 = data[2], 
					m31 = data[3];
				break;
				case 2:
					m02 = data[0];
					m12 = data[1], 
					m22 = data[2], 
					m32 = data[3];
				break;
				case 3:
					m03 = data[0];
					m13 = data[1], 
					m23 = data[2], 
					m33 = data[3];
				break;
				default:
					throw new Error( "Invalid column." );
				break;
			}
		}
		
		/**
		 * Get a row from the <code>HMatrix</code> Object. Row values are 0, 1, 2 and 3.
		 * 
		 * @param	row	The row number of the <code>HMatrix</code> Object.
		 * 
		 * @return	The 4 element values associated with the row as an <code>Array</code>
		 */
		public function getRow( row: int ): Array
		{
			switch( row )
			{
				case 0:
					return [ m00, m01, m02, m03 ];
				break;
				case 1:
					return [ m10, m11, m12, m13 ];
				break;
				case 2:
					return [ m20, m21, m22, m23 ];
				break;
				case 3:
					return [ m30, m31, m32, m33 ];
				break;
				default:
					throw new Error( "Invalid row." );
				break;
			}
		}
		
		public function setRow( row: int, data:Array ): void
		{
			if ( data.length != 4 )
			{
				throw new Error( "Invalid length." );
			}
			switch( row )
			{
				case 0:
					m00 = data[0];
					m01 = data[1], 
					m02 = data[2], 
					m03 = data[3];
				break;
				case 1:
					m10 = data[0];
					m11 = data[1], 
					m12 = data[2], 
					m13 = data[3];
				break;
				case 2:
					m20 = data[0];
					m21 = data[1], 
					m22 = data[2], 
					m23 = data[3];
				break;
				case 3:
					m30 = data[0];
					m31 = data[1], 
					m32 = data[2], 
					m33 = data[3];
				break;
				default:
					throw new Error( "Invalid row." );
				break;
			}
		}
		
		/**
		 * Composes a <code>String</code> representation of <code>this</code> Object.
		 * 
		 * @return	A <code>String</code> representation of the object, note that values are truncated using <code>String.toFixed()</code>.
		 */
		public function toString(): String
		{
			return "[object HMatrix]\n" + m00.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m01.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m02.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m03.toFixed( 5 ).substr( 0, 7 ) + "\n"
										
										+ m10.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m11.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m12.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m13.toFixed( 5 ).substr( 0, 7 ) + "\n"
										
										+ m20.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m21.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m22.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m23.toFixed( 5 ).substr( 0, 7 ) + "\n"
										
										+ m30.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m31.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m32.toFixed( 5 ).substr( 0, 7 ) + "\t\t"
										+ m33.toFixed( 5 ).substr( 0, 7 ) + "\n";
		}
		
	}

}