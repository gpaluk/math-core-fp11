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
	import io.plugin.core.system.Assert;
	import io.plugin.core.system.Random;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class MathHelper 
	{
		
		public static const ZERO_TOLLERANCE: Number = 1e-8;
		public static const DEG_TO_RAD:Number = Math.PI / 180;
		public static const RAD_TO_DEG: Number = 180 / Math.PI;
		public static const INV_PI: Number = 1 / Math.PI;
		public static const TWO_PI: Number = 2 * Math.PI;
		
		public static function degToRad( degrees: Number ): Number
		{
			return degrees * DEG_TO_RAD;
		}
		
		public static function radToDeg( radians: Number ): Number
		{
			return radians * RAD_TO_DEG;
		}
		
		public static function invSqrt( value: Number ): Number
		{
			if ( value != 0 )
			{
				return 1 / Math.sqrt( value );
			}
			throw new Error( "Division by zero in InvSqr." );
		}
		
		//TODO fix bugs here
		public static function unitRandom( seed: int = 0 ): Number
		{
			var random: Random;
			
			if ( seed > 0 )
			{
				random = new Random( seed );
				return random.nextNumberRange( 0, 1 );
			}
			
			random = new Random( Math.random() );
			return random.nextNumberRange( 0, 1 );
		}
		
		public static function symmetricRandom( seed: int = 0 ): Number
		{
			return  (2 * unitRandom( seed )) - 1;
		}
		
		public static function sign( value: Number ): Number
		{
			return ( value > 0 ) ? 1 : (( value < 0 ) ? -1 : 0 );
		}
	}

}