package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import jp.mztm.ribon.Branch;
	import jp.mztm.ribon.Pika;
	import net.hires.debug.Stats;

    /**
     * ...
     * @author umhr
     */
    //[SWF(width = 1024, height = 768, backgroundColor = 0x000000, frameRate = 60)]
    public class Drawer extends Sprite
    {
        private var _mousePoint:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
        private var _count:int;
        private var _bitmap:Bitmap;
        private var _bitmapParticle:Bitmap;
        private var _shape:Shape = new Shape();
        private var _shapeParticle:Shape = new Shape();
        private const FADE:ColorTransform = new ColorTransform(1, 1, 1, 1, -0x8, -0x6, -0x4);
        private const FADE2:ColorTransform = new ColorTransform(1, 1, 1, 1, -0x33, -0x22, -0x11, -0x14);
		
		public var pointList:Vector.<Point> = new Vector.<Point>();
        public function Drawer():void
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
            
            //_bitmap = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x000000), "auto", true);
            //_bitmapParticle = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x000000));
            _bitmap = new Bitmap(new BitmapData(1024, 768, false, 0x000000), "auto", true);
            _bitmapParticle = new Bitmap(new BitmapData(1024, 768, true, 0x000000));
            this.addChild(_bitmap);
            this.addChild(_bitmapParticle);
			
			//trace(mouseX, mouseY)
			
			
            var point:Point = new Point(mouseX, mouseY);
            for (var i:int = 0; i < 10; i++) {
                var vector:Vector.<Point> = new Vector.<Point>();
                for (var j:int = 0; j < 3; j++) {
                    vector[j] = point;
                }
                _mousePoint[i] = vector;
            }
			
            
            this.addEventListener(Event.ENTER_FRAME, onEnter);
            stage.addEventListener(MouseEvent.CLICK, onClick);
			
            //this.addChild(new Stats());
        }
		
		private function onClick(e:MouseEvent):void 
		{
			trace("click!",stage.mouseX, stage.mouseY);
			
			new Branch(_shape.graphics, stage.mouseX, stage.mouseY);
			
		}

        private function onEnter(e:Event):void
        {
            _count++;
			
			if (pointList.length == 0) {
				return;
			}
			
			var n:int = _mousePoint.length;
            for (var i:int = 0; i < n; i++) {
                var inertiaPoint:Point = _mousePoint[i][0].subtract(_mousePoint[i][1]).add(_mousePoint[i][0]);
                var radian:Number = _count / 6 + Math.PI * 2 * i / n;
                var r:Number = 7 * (1 + 2.5 * Math.sin(_count / 12));
				
				var targetPoint:Point = pointList[i % pointList.length];
				
                var mousePoint:Point;
				if(i%2 == 0){
					mousePoint = new Point(targetPoint.x + Math.cos(radian) * r , targetPoint.y + Math.sin(radian) * r);
				}else{
					mousePoint = new Point(targetPoint.x + Math.sin(radian) * r , targetPoint.y + Math.cos(radian) * r);
				}
                inertiaPoint.x = inertiaPoint.x * 0.94 + mousePoint.x * 0.06;
                inertiaPoint.y = inertiaPoint.y * 0.94 + mousePoint.y * 0.06;
                _mousePoint[i].unshift(inertiaPoint);
                _mousePoint[i].length = 3;
            }
			if(_count%10 == 0){
				new Pika(_shapeParticle.graphics, pointList[0].x, pointList[0].y);
			}
            draw(_mousePoint);
        }

        /**
         * 線を描画
         * @param    mousePoint
         */
        private function draw(mousePoint:Vector.<Vector.<Point>>):void {
 			var d:Number;
			var thickness:Number;
			var n:int = mousePoint.length;
            for (var i:int = 0; i < n; i++) {
				
				d = 5;
				
				var p0x:Number = mousePoint[i][0].x;
				var p0y:Number = mousePoint[i][0].y;
				var p1x:Number = mousePoint[i][1].x;
				var p1y:Number = mousePoint[i][1].y;
				var p2x:Number = mousePoint[i][2].x;
				var p2y:Number = mousePoint[i][2].y;
				
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
				
				_shape.graphics.beginFill(0x99CCFF);
				_shape.graphics.moveTo(m0x - ay, m0y + ax);
				_shape.graphics.curveTo(p1x - cy, p1y + cx, m1x - by, m1y + bx);
				_shape.graphics.lineTo(m1x + by, m1y - bx);
				_shape.graphics.curveTo(p1x + cy, p1y - cx, m0x + ay, m0y - ax);
				_shape.graphics.lineTo(m0x - ay, m0y + ax);
				_shape.graphics.endFill();
				_shape.filters = [new BlurFilter(8, 8)];
				
            }
            //_bitmap.bitmapData.colorTransform(_bitmap.bitmapData.rect, FADE);
            //_bitmap.bitmapData.colorTransform(_bitmap.bitmapData.rect, new ColorTransform(0.9, 0.9, 0.9, 1));
			
			//var ratio:Number = 1;// 0.997;
			var ratio:Number = 1.0015;
			var w:Number = 1024 * (1 - ratio) * 0.5;
			var h:Number = 768 * (1 - ratio) * 0.5;
			
			_bitmap.bitmapData.draw(_bitmap, new Matrix(ratio, 0, 0, ratio, w, h), FADE, null, null, true);
			
			_bitmap.bitmapData.draw(_shape, new Matrix(1, 0, 0, 1, 0, 0), null, "add", null, true);
            _shape.graphics.clear();
			
			//_shapeParticle.filters = [new BlurFilter(2,2)];
			//_bitmapParticle.bitmapData.draw(_bitmapParticle, new Matrix(ratio, 0, 0, ratio, w, h), FADE, null, null, true);
            _bitmapParticle.bitmapData.colorTransform(_bitmapParticle.bitmapData.rect, FADE2);
            _bitmapParticle.bitmapData.draw(_shapeParticle, null, null, "add");
            _shapeParticle.graphics.clear();
        }
    }

}
