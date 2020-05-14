package jp.mztm.ribon
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import jp.mztm.utils.Utils;

    /**
     * ...
     * @author umhr
     */
    internal class Ribon extends Sprite
    {
        private var _mousePoint:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
        private var _count:int;
        private var _shape:Shape = new Shape();
        public function Ribon():void
        {
			init();
        }

        private function init(e:Event = null):void
        {
            this.addChild(_shape);
			
            var point:Point = new Point(mouseX, mouseY);
            for (var i:int = 0; i < 3; i++) {
                var vector:Vector.<Point> = new Vector.<Point>();
                for (var j:int = 0; j < 60; j++) {
                    vector[j] = point;
                }
                _mousePoint[i] = vector;
            }
			
        }
		
		public function execute(mouseX:Number = 0, mouseY:Number = 0):void {
            _count++;
			var n:int = _mousePoint.length;
            for (var i:int = 0; i < n; i++) {
                var inertiaPoint:Point = _mousePoint[i][0].subtract(_mousePoint[i][1]).add(_mousePoint[i][0]);
                var radian:Number = -(_count / 6 + Math.PI * 2 * i / n);
                var r:Number = 10 * (0.7 + 1 * Math.sin(_count / 12));
                var mousePoint:Point = new Point(mouseX + Math.cos(radian) * r , mouseY + Math.sin(radian) * r);
                inertiaPoint.x = inertiaPoint.x * 0.97 + mousePoint.x * 0.03;
                inertiaPoint.y = inertiaPoint.y * 0.97 + mousePoint.y * 0.03;
                _mousePoint[i].unshift(inertiaPoint);
                _mousePoint[i].length = 30;
            }
            draw(_mousePoint);
			
		}
		
        /**
         * 線を描画
         * @param    mousePoint
         */
        private function draw(mousePoint:Vector.<Vector.<Point>>):void {
            _shape.graphics.clear();
			
			var d:Number;
			var thickness:Number;
			
            var colors:Array = [];
			colors = [0x1166CC, 0x116699, 0x6699CC, 0x116699, 0x1166CC, 0x6699CC,
			0x1166CC, 0x116699, 0x6699CC, 0x116699, 0x1166CC, 0x6699CC];
			
			var n:int = mousePoint.length;
            for (var i:int = 0; i < n; i++) {
				
				var m:int = mousePoint[i].length - 2;
				for (var j:int = m - 1; j >= 0; j--) {
					d = ((m - j) / m) * 1;
					
					var p0x:Number = mousePoint[i][j].x;
					var p0y:Number = mousePoint[i][j].y;
					var p1x:Number = mousePoint[i][j + 1].x;
					var p1y:Number = mousePoint[i][j + 1].y;
					var p2x:Number = mousePoint[i][j + 2].x;
					var p2y:Number = mousePoint[i][j + 2].y;
					
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
					
					var t:Number = j/ m-1;
					t = t * t;
					
					//_shape.graphics.beginFill(Utils.rgbBrightness(colors[i], (m - j) / m));
					_shape.graphics.beginFill(Utils.rgbBrightness(colors[i], t));
					//_shape.graphics.beginFill(colors[i]);
					_shape.graphics.moveTo( -ay + m0x, ax + m0y);
					_shape.graphics.curveTo( -cy + p1x, cx + p1y, -by + m1x, bx + m1y);
					_shape.graphics.lineTo(by + m1x, -bx + m1y);
					_shape.graphics.curveTo(cy + p1x, -cx + p1y, ay + m0x, -ax + m0y);
					_shape.graphics.lineTo( -ay + m0x, ax + m0y);
					
					_shape.graphics.endFill();
					
				}
				
				if ((i == 0 || i == 3) && Math.random() > 0.5) {
					var element:Particle = new Particle();
					element.x = mousePoint[i][0].x;
					element.y = mousePoint[i][0].y;
					addChild(element);
				}
				
				//if (i == 0 || i == 3) {
					//var element:Element = new Element();
					//element.x = mousePoint[i][0].x;
					//element.y = mousePoint[i][0].y;
					//addChild(element);
				//}
				
            }
        }
		
        private function draw2(mousePoint:Vector.<Vector.<Point>>):void {
            _shape.graphics.clear();
			
            var colors:Array = [];
			colors = [0x1166CC, 0x116699, 0x6699CC, 0x116699, 0x1166CC, 0x6699CC,
			0x1166CC, 0x116699, 0x6699CC, 0x116699, 0x1166CC, 0x6699CC];
			
			var n:int = mousePoint.length;
            for (var i:int = 0; i < n; i++) {
                //_shape.graphics.lineStyle(0, colors[i]);
				
				var m:int = mousePoint[i].length - 2;
				for (var j:int = m - 1; j >= 0; j--) {
				//for (var j:int = 0; j < m; j++) {
					_shape.graphics.lineStyle(((m - j) / m) * 3, Utils.rgbBrightness(colors[i], (m - j) / m));
					//_shape.graphics.lineStyle(0, Utils.rgbBrightness(colors[i], 1));
					//_shape.graphics.lineStyle(0, Utils.rgbBrightness(colors[i], 1));
					
					var p0x:Number = mousePoint[i][j].x;
					var p0y:Number = mousePoint[i][j].y;
					var p1x:Number = mousePoint[i][j + 1].x;
					var p1y:Number = mousePoint[i][j + 1].y;
					var p2x:Number = mousePoint[i][j + 2].x;
					var p2y:Number = mousePoint[i][j + 2].y;
					
					var m0x:Number = (p0x + p1x) * 0.5;
					var m0y:Number = (p0y + p1y) * 0.5;
					var m1x:Number = (p1x + p2x) * 0.5;
					var m1y:Number = (p1y + p2y) * 0.5;
					
					//var m0:Point = Point.interpolate(mousePoint[i][j], mousePoint[i][j + 1], 0.5);
					//var m1:Point = Point.interpolate(mousePoint[i][j + 1], mousePoint[i][j + 2], 0.5);
					_shape.graphics.moveTo(m0x, m0y);
					_shape.graphics.curveTo(p1x, p1y, m1x, m1y);
					
					//var m0:Point = Point.interpolate(mousePoint[i][j], mousePoint[i][j + 1], 0.5);
					//var m1:Point = Point.interpolate(mousePoint[i][j + 1], mousePoint[i][j + 2], 0.5);
					//_shape.graphics.moveTo(m0.x, m0.y);
					//_shape.graphics.curveTo(mousePoint[i][j + 1].x, mousePoint[i][j + 1].y, m1.x, m1.y);
				}
				
				
				//if (i == 0 || i == 3) {
					//var element:Element = new Element();
					//element.x = mousePoint[i][0].x;
					//element.y = mousePoint[i][0].y;
					//addChild(element);
					//
				//}
				
            }
        }
		
    }

}
