package io.plugin.math.intersection 
{
	import io.plugin.math.intersection.enum.IntersectionType;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Intersector 
	{
		
		protected var _intersectionType: IntersectionType;
		protected var _contactTime: Number;
		
		// abstract
		public function Intersector() 
		{
			_contactTime = 0;
			_intersectionType = IntersectionType.EMPTY;
		}
		
		// virtual
		public function test(): Boolean
		{
			throw new Error( "Function not yet implemented." );
		}
		
		// virtual
		public function find(): Boolean
		{
			throw new Error( "Function not yet implemented." );
		}
		
		[Inline]
		public final function get contactTime(): Number
		{
			return _contactTime;
		}
		
		[Inline]
		public final function get intersectionType(): IntersectionType
		{
			return _intersectionType;
		}
		
	}

}