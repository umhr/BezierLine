package  
{
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Test extends Sprite {
		
		private var _pointList:Array/*Point*/ = [];
		public function Test() 
		{
			init();
		}
		private function init():void {
			
			trace("hoge");
			
			//_pointList.push(new Point(200, 400));
			//_pointList.push(new Point(600, 200));
			//_pointList.push(new Point(1000, 400));
			
			var n:int = 3;
			for (var i:int = 0; i < n; i++) 
			{
				_pointList.push(new Point(1900*Math.random(), 1000*Math.random()));
			}
			
			draw();
		}
		private function draw():void {
			
			graphics.beginFill(0xFF0000);
			var n:int = _pointList.length;
			for (var i:int = 0; i < n; i++) 
			{
				graphics.drawCircle(_pointList[i].x, _pointList[i].y, 4);
				
			}
			graphics.endFill();
			
			var d:Number = 6;
			
			///
			
			var m0:Point = Point.interpolate(_pointList[0], _pointList[1], 0.5);
			var m1:Point = Point.interpolate(_pointList[1], _pointList[2], 0.5);
			//graphics.lineStyle(0, 0xFF0000);
			//graphics.moveTo(m0.x, m0.y);
			//graphics.curveTo(_pointList[1].x, _pointList[1].y, m1.x, m1.y);
			
			///
			
			var aSubtract:Point = _pointList[0].subtract(_pointList[1]);
			aSubtract.normalize(d);
			var a0Point:Point = new Point( -aSubtract.y, aSubtract.x);
			var a1Point:Point = new Point( aSubtract.y, -aSubtract.x);
			
			var bSubtract:Point = _pointList[1].subtract(_pointList[2]);
			bSubtract.normalize(d);
			var b0Point:Point = new Point( -bSubtract.y, bSubtract.x);
			var b1Point:Point = new Point( bSubtract.y, -bSubtract.x);
			
			var cSubtract:Point = aSubtract.add(bSubtract);
			cSubtract.normalize(d);
			var c0Point:Point = new Point( -cSubtract.y, cSubtract.x);
			var c1Point:Point = new Point( cSubtract.y, -cSubtract.x);
			
			
			a0Point = a0Point.add(m0);
			a1Point = a1Point.add(m0);
			b0Point = b0Point.add(m1);
			b1Point = b1Point.add(m1);
			c0Point = c0Point.add(_pointList[1]);
			c1Point = c1Point.add(_pointList[1]);
			
			//graphics.lineStyle(4, 0x00FF00);
			//graphics.moveTo(a0Point.x, a0Point.y);
			//graphics.lineTo(a1Point.x, a1Point.y);
			//graphics.moveTo(b0Point.x, b0Point.y);
			//graphics.lineTo(b1Point.x, b1Point.y);
			//graphics.moveTo(c0Point.x, c0Point.y);
			//graphics.lineTo(c1Point.x, c1Point.y);
			//graphics.endFill();
			//
			//graphics.lineStyle(0, 0x0000FF);
			//graphics.moveTo(_pointList[0].x, _pointList[0].y);
			//graphics.lineTo(_pointList[1].x, _pointList[1].y);
			//graphics.moveTo(_pointList[1].x, _pointList[1].y);
			//graphics.lineTo(_pointList[2].x, _pointList[2].y);
			//graphics.endFill();
			
			//graphics.lineStyle(0, 0xFF00FF);
			graphics.lineStyle();
			graphics.beginFill(0xFF00FF,0.5);
			graphics.moveTo(a0Point.x, a0Point.y);
			graphics.curveTo(c0Point.x, c0Point.y, b0Point.x, b0Point.y);
			graphics.lineTo(b1Point.x, b1Point.y);
			graphics.curveTo(c1Point.x, c1Point.y, a1Point.x, a1Point.y);
			graphics.lineTo(a0Point.x, a0Point.y);
			graphics.endFill();
			
			
		}
		
	}
	
}