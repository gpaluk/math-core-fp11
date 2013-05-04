package io.plugin.math.algebra.pool 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.core.pool.Pool;
	import io.plugin.math.algebra.APoint;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class APointPool extends Pool implements IDisposable 
	{
		
		public function APointPool() 
		{
			super( construct, destruct, 50, 50 );
		}
		
		private function construct(): APoint
		{
			return new APoint();
		}
		
		private function destruct( point: APoint ): void
		{
			point.dispose();
		}
	}

}