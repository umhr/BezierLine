package jp.mztm.ribon
{
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import jp.mztm.utils.Utils;
	import org.libspark.betweenas3.core.easing.*;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Pika extends Sprite {
		
		private var _positionPointList:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
		private var _directionList:Vector.<Number> = new Vector.<Number>();
		private var _count:int = 0;
		private var _graphics:Graphics;
		private var _sineEaseOut:SineEaseOut = new SineEaseOut();
		private var _cubicEaseOut:CubicEaseOut = new CubicEaseOut();
		private var _bounceEaseOut:BounceEaseOut = new BounceEaseOut();
		private var _centerX:Number;
		private var _centerY:Number;
		public function Pika(graphics:Graphics, x:Number, y:Number)
		{
			_graphics = graphics;
			_centerX = x;
			_centerY = y;
			
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
			
			make(_count / 50);
			
			if (_count >= 50) {
				removeEventListener(Event.ENTER_FRAME, onEnter);
			}
			
		}
		
		private function make(ratio:Number):void {
			var n:int = _directionList.length;
			
			var ra:Number = _sineEaseOut.calculate(ratio, 0, 1, 1);
			
			for (var i:int = 0; i < n; i++) {
				if (Math.random() > 0.5) {
					_directionList[i] += 0.5 * Math.PI * (Math.random() - 0.5);
				}
				var point:Point = _positionPointList[i][0];
				//_positionPointList[i].unshift(new Point(point.x + ratio * 7 * Math.sin(_directionList[i]), point.y + ratio * 7 * Math.cos(_directionList[i])));
				_positionPointList[i].unshift(new Point(_centerX+ra * 100 * Math.sin(_directionList[i]),_centerY+ra * 100 * Math.cos(_directionList[i])));
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
				
				//_graphics.beginFill(Utils.rgbBrightness(0x99CCFF, ratio), ratio);
				_graphics.beginFill(Utils.rgbBrightness(0x99CCFF, Math.random()), 1-ratio);
				//_graphics.beginFill(0x99CCFF, Math.random());
				_graphics.drawCircle(_positionPointList[i][0].x, _positionPointList[i][0].y, 4);
				_graphics.endFill();
				
			}
			
		}
		
	}
	
}