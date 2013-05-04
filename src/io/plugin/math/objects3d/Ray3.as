package io.plugin.math.objects3d 
{
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Ray3 
	{
		
		public var origin: APoint;
		public var direction: AVector;
		
		public function Ray3( origin: APoint, direction: AVector ) 
		{
			this.origin = origin;
			this.direction = direction;
		}
		
		public function toString(): String
		{
			return "Origin: " + origin.toString() + " \nDirection: " + direction.toString();
		}
		
	}

}