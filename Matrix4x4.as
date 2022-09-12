package {
	import flash.geom.Matrix;
 
	final public class Matrix4x4
	{
		private const rawvs:Vector.<Vector3> = new <Vector3>[
		     new Vector3(1,0,0), 
		     new Vector3(0,1,0), 
		     new Vector3(0,0,1), 
		     new Vector3(0,0,0,1)
		];
		
		
		
		// constructor.
		final public function Matrix4x4(r1x:Number=1, r1y:Number=0, r1z:Number=0, r1w:Number=0,
		                                r2x:Number=0, r2y:Number=1, r2z:Number=0, r2w:Number=0,
		                                r3x:Number=0, r3y:Number=0, r3z:Number=1, r3w:Number=0,
		                                r4x:Number=0, r4y:Number=0, r4z:Number=0, r4w:Number=1):void {
			rawvs[0].x = r1x;
			rawvs[0].y = r1y;
			rawvs[0].z = r1z;
			rawvs[0].w = r1w;
			
			rawvs[1].x = r2x;
			rawvs[1].y = r2y;
			rawvs[1].z = r2z;
			rawvs[1].w = r2w;
			
			rawvs[2].x = r3x;
			rawvs[2].y = r3y;
			rawvs[2].z = r3z;
			rawvs[2].w = r3w;
			
			rawvs[3].x = r4x;
			rawvs[3].y = r4y;
			rawvs[3].z = r4z;
			rawvs[3].w = r4w;
		}
		
		
		
		// convert Matrix4x4 to Matrix
		final public function get toMatrix2D():Matrix {
			
			return new Matrix(rawvs[0].x, rawvs[1].x, 
			                  rawvs[0].y, rawvs[1].y, 
							  rawvs[0].w, rawvs[1].w);
		}
		
		
		
		// get array type data.
		final public function get rawData():Vector.<Vector3> {
			return rawvs;
		}
		
		
		
		// 
		final public function setRawData(index:int, x:Number, y:Number, z:Number, w:Number):void {
			if(index<0) index=0;
			if(index>3) index=3;
			
			var t:Vector3 = rawvs[index];
			t.x = x;
			t.y = y;
			t.z = z;
			t.w = w;
		}
		
		
		
		// matrix sum.
		final public function add(rhs:Matrix4x4):Matrix4x4 
		{
			rawvs[0].add(rhs.rawvs[0]);
			rawvs[0].w+=rhs.rawvs[0].w;
			
			rawvs[1].add(rhs.rawvs[1]);
			rawvs[1].w+=rhs.rawvs[1].w;
			
			rawvs[2].add(rhs.rawvs[2]);
			rawvs[2].w+=rhs.rawvs[2].w;
			
			rawvs[3].add(rhs.rawvs[3]);
			rawvs[3].w+=rhs.rawvs[3].w;
			
			return this;
		}
		
		
		
		// multiply by a scalar.
		final public function scalar(rhs:Number, mainTain:Boolean=false):Matrix4x4 {
			
			if(mainTain==false){
				rawvs[0].scalar(rhs, true);
				rawvs[1].scalar(rhs, true);
				rawvs[2].scalar(rhs, true);
				rawvs[3].scalar(rhs, true);
			}
			return this;
		}
		
		final public function equal(rhs:Matrix4x4):Boolean 
		{
			return (rawvs[0].equal(rhs.rawvs[0]) && rawvs[1].equal(rhs.rawvs[1]) && rawvs[2].equal(rhs.rawvs[2]) && rawvs[3].equal(rhs.rawvs[3]) );
		}
		
		final public function mulVector3(rhs:Vector3, mainTain:Boolean=false):Matrix4x4
		{
			var clone:Matrix4x4 = new Matrix4x4();
			
			for(var i:int=0; i<4 ; i++)
			{
				clone.rawData[i].x = (rawvs[i].x*rhs.x)+(rawvs[i].y*rhs.y)+(rawvs[i].z*rhs.z)+(rawvs[i].w*rhs.w);
				clone.rawData[i].y = (rawvs[i].x*rhs.x)+(rawvs[i].y*rhs.y)+(rawvs[i].z*rhs.z)+(rawvs[i].w*rhs.w);
				clone.rawData[i].z = (rawvs[i].x*rhs.x)+(rawvs[i].y*rhs.y)+(rawvs[i].z*rhs.z)+(rawvs[i].w*rhs.w);
				clone.rawData[i].w = (rawvs[i].x*rhs.x)+(rawvs[i].y*rhs.y)+(rawvs[i].z*rhs.z)+(rawvs[i].w*rhs.w);
			}
			
			if(mainTain==false)
			{
				rawvs[0] = clone.rawData[0];
				rawvs[1] = clone.rawData[1];
				rawvs[2] = clone.rawData[2];
				rawvs[3] = clone.rawData[3];
				
				return this;
			}
			
			return clone;
		}
		
		final public function mul(rhs:Matrix4x4, mainTain:Boolean=false):Matrix4x4
		{
			var temp:Vector.<Vector3> = rhs.transpose(true).rawData;
			var clone:Matrix4x4 = new Matrix4x4();
			
			for(var i:int=0; i<4 ; i++)
			{
				clone.rawData[i].x = (rawvs[i].x*temp[0].x)+(rawvs[i].y*temp[0].y)+(rawvs[i].z*temp[0].z)+(rawvs[i].w*temp[0].w);
				clone.rawData[i].y = (rawvs[i].x*temp[1].x)+(rawvs[i].y*temp[1].y)+(rawvs[i].z*temp[1].z)+(rawvs[i].w*temp[1].w);
				clone.rawData[i].z = (rawvs[i].x*temp[2].x)+(rawvs[i].y*temp[2].y)+(rawvs[i].z*temp[2].z)+(rawvs[i].w*temp[2].w);
				clone.rawData[i].w = (rawvs[i].x*temp[3].x)+(rawvs[i].y*temp[3].y)+(rawvs[i].z*temp[3].z)+(rawvs[i].w*temp[3].w);
			}
			
			if(mainTain==false)
			{
				rawvs[0] = clone.rawData[0];
				rawvs[1] = clone.rawData[1];
				rawvs[2] = clone.rawData[2];
				rawvs[3] = clone.rawData[3];
				
				return this;
			}
			
			return clone;
		}
		
		final public function transpose(mainTain:Boolean=false):Matrix4x4
		{
			var new1:Vector3 = new Vector3(rawvs[0].x, rawvs[1].x, rawvs[2].x, rawvs[3].x);
			var new2:Vector3 = new Vector3(rawvs[0].y, rawvs[1].y, rawvs[2].y, rawvs[3].y);
			var new3:Vector3 = new Vector3(rawvs[0].z, rawvs[1].z, rawvs[2].z, rawvs[3].z);
			var new4:Vector3 = new Vector3(rawvs[0].w, rawvs[1].w, rawvs[2].w, rawvs[3].w);
			
			if(mainTain==false)
			{
				rawvs[0] = new1;
				rawvs[1] = new2;
				rawvs[2] = new3;
				rawvs[3] = new4;
				
				return this;
			}
			
			var clone:Matrix4x4 = new Matrix4x4();
			clone.rawData[0] = new1;
			clone.rawData[1] = new2;
			clone.rawData[2] = new3;
			clone.rawData[3] = new4;
			return clone;
		}
		
		final public function toString():String
		{
			return rawvs[0].toString()+"\n"+rawvs[1].toString()+"\n"+rawvs[2].toString()+"\n"+rawvs[3].toString();
		}
	}	
}