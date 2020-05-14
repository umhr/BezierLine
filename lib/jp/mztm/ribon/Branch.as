package jp.mztm.ribon
{
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Branch extends Sprite {
		
		private var _positionPointList:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
		private var _directionList:Vector.<Number> = new Vector.<Number>();
		private var _count:int = 0;
		private var _graphics:Graphics;
		public function Branch(graphics:Graphics, x:Number, y:Number)
		{
			_graphics = graphics;
			
            for (var i:int = 0; i < 2; i++) {
                var vector:Vector.<Point> = new Vector.<Point>();
                for (var j:int = 0; j < 3; j++) {
                    vector[j] = new Point(x, y);
                }
                _positionPointList[i] = vector;
				_directionList[i] = 2 * Math.PI * Math.random();
            }
			
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(event:Event):void 
		{
			_count++;
			
			make(_count / 30);
			
			if (_count >= 30) {
				removeEventListener(Event.ENTER_FRAME, onEnter);
			}
			
		}
		
		private function make(ratio:Number):void {
			var n:int = _directionList.length;
			for (var i:int = 0; i < n; i++) {
				if (Math.random() > 0.4) {
					_directionList[i] += 0.5 * Math.PI * (Math.random() - 0.5);
				}
				var point:Point = _positionPointList[i][0];
				_positionPointList[i].unshift(new Point(point.x + ratio * 15 * Math.sin(_directionList[i]), point.y + ratio * 15 * Math.cos(_directionList[i])));
				_positionPointList[i].length = 3;
			}
			if (_positionPointList[0].length > 2) {
				draw(ratio);
			}
		}
		
		private function draw(ratio:Number):void {
			
 			var d:Number = 3;
			var thickness:Number;
			
			var n:int = _positionPointList.length;
			for (var i:int = 0; i < n; i++) {
				var p0x:Number = _positionPointList[i][0].x;
				var p0y:Number = _positionPointList[i][0].y;
				var p1x:Number = _positionPointList[i][1].x;
				var p1y:Number = _positionPointList[i][1].y;
				var p2x:Number = _positionPointList[i][2].x;
				var p2y:Number = _positionPointList[i][2].y;
				
				var m0x:Number = (p0x + p1x) * 0.5;
				var m0y:Number = (p0y + p1y) * 0.5;
				var m1x:Number = (p1x + p2x) * 0.5;
				var m1y:Number = (p1y + p2y) * 0.5;
				
				var ax:Number = p0x - p1x;
				var ay:Number = p0y - p1y;
				thickness = d / Math.sqrt(ax * ax + ay * ay);
				ax *= thickness;
				ay *= thickness;
				
				var bx:Number = p1x - p2x;
				var by:Number = p1y - p2y;
				thickness = d / Math.sqrt(bx * bx + by * by);
				bx *= thickness;
				by *= thickness;
				
				var cx:Number = ax + bx;
				var cy:Number = ay + by;
				thickness = d / Math.sqrt(cx * cx + cy * cy);
				cx *= thickness;
				cy *= thickness;
				
				_graphics.beginFill(0x99CCFF);
				_graphics.moveTo(m0x - ay, m0y + ax);
				_graphics.curveTo(p1x - cy, p1y + cx, m1x - by, m1y + bx);
				_graphics.lineTo(m1x + by, m1y - bx);
				_graphics.curveTo(p1x + cy, p1y - cx, m0x + ay, m0y - ax);
				_graphics.lineTo(m0x - ay, m0y + ax);
				_graphics.endFill();
			}
			
		}
		
	}
	
}