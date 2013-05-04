package io.plugin.math.objects3d 
{
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Line3 
	{
		
		public var origin: APoint;
		public var direction: AVector;
		
		
		public function Line3( origin: APoint, direction: AVector ) 
		{
			this.origin = origin;
			this.direction = direction;
		}
		
	}

}