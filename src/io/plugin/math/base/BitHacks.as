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
package io.plugin.math.base 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class BitHacks 
	{
		
		public function BitHacks() 
		{
			
		}
		
		public static function logOfPowerTwoUint( powerOfTwo: uint ): uint
		{
			var log2: uint = ((powerOfTwo & 0xAAAAAAAA) != 0 ? 1 : 0 );
			log2 |= ((( powerOfTwo & 0xFFFF0000 ) != 0 ) ? 1 : 0 ) << 4;
			log2 |= ((( powerOfTwo & 0xFF00FF00 ) != 0 ) ? 1 : 0 ) << 3;
			log2 |= ((( powerOfTwo & 0xF0F0F0F0 ) != 0 ) ? 1 : 0 ) << 2;
			log2 |= ((( powerOfTwo & 0xCCCCCCCC ) != 0 ) ? 1 : 0 ) << 1;
			return log2;
		}
		
		public static function logOfPowerTwoInt( powerOfTwo: int ): int
		{
			var log2: uint = ((powerOfTwo & 0xAAAAAAAA) != 0 ? 1 : 0 );
			log2 |= ((( powerOfTwo & 0xFFFF0000 ) != 0 ) ? 1 : 0 ) << 4;
			log2 |= ((( powerOfTwo & 0xFF00FF00 ) != 0 ) ? 1 : 0 ) << 3;
			log2 |= ((( powerOfTwo & 0xF0F0F0F0 ) != 0 ) ? 1 : 0 ) << 2;
			log2 |= ((( powerOfTwo & 0xCCCCCCCC ) != 0 ) ? 1 : 0 ) << 1;
			return int( log2 );
		}
		
		public static function isPowerOfTwoUint( value: uint ): Boolean
		{
			return (value > 0) && ((value & (value - 1)) == 0);
		}
		
		public static function isPowerOfTwoInt( value: int ): Boolean
		{
			return (value > 0) && ((value & (value - 1)) == 0);
		}
		
	}

}