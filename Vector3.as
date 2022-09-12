package {
	
	final public class Vector3
	{
		public var x:Number = 0;
		public var y:Number = 0;
		public var z:Number = 0;
		public var w:Number = 0;
		
		final public function Vector3(x:Number=0, y:Number=0, z:Number=0, w:Number=0):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}
		
		final public function add(rhs:Vector3):Vector3
		{
			x+=rhs.x;
			y+=rhs.y;
			z+=rhs.z;
			
			return this;
		}
		
		final public function equal(rhs:Vector3):Boolean
		{
			return (x==rhs.x && y==rhs.y && z==rhs.z && w==rhs.w);
		}
		
		final public function get size():Number
		{
			return Math.sqrt(x*x + y*y + z*z);
		}
		
		final public function setVector(x:Number, y:Number, z:Number, w:Number):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}
		
		final public function normalize():Vector3
		{
			var divSize:Number = 1.0 / size;

			x *= divSize;
			y *= divSize;
			z *= divSize;
			
			return this;
		}
		
		final public function sub(rhs:Vector3):Vector3
		{
			x-=rhs.x;
			y-=rhs.y;
			z-=rhs.z;
			
			return this;
		}
		
		final public function dot(rhs:Vector3):Number
		{
			return (x*rhs.x + y*rhs.y + z*rhs.z);
		}
		
		final public function scalar(rhs:Number, useW:Boolean=false):Vector3
		{
			x *=rhs;
			y *=rhs;
			z *=rhs;
			if(useW==true)
			{
				w*=rhs;
			}
			return this;
		}
		
		final public function toString():String
		{
			return "["+String(x)+", "+String(y)+", "+String(z)+", "+String(w)+"]";
		}
	}
	
}