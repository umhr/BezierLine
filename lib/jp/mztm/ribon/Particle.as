package jp.mztm.ribon
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.mztm.utils.Utils;
	
	/**
	 * ...
	 * @author umhr
	 */
	internal class Particle extends Sprite {
		
		static public const CIRCLE:String = "circle";
		static public const CROSS:String = "cross";
		
		//private var bitmapData:BitmapData = new BitmapData(100, 100, true, 0xFFFF0000);
		private var direction:Number = 2 * Math.PI * Math.random();
		private var count:int = 0;
		private var rgb:int;
		public var type:String;
		public function Particle(type:String = "circle") 
		{
			
			//var bitmap:Bitmap = new Bitmap(new BitmapData(10, 10, true, 0xFFFF0000));
			//addChild(bitmap);
			this.type = type;
			this.mouseEnabled = false;
			
			var colors:Array = [0x1166CC, 0x116699, 0x6699CC];
			rgb = colors[Math.floor(Math.random() * 3)];
			draw(1);
			
			addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(event:Event):void 
		{
			count++;
			
			this.x += Math.sin(direction)*2;
			this.y += Math.cos(direction)*2;
			//this.alpha = (30 - count) / 30;
			draw((31 - count) / 30);
			
			if (count > 30 && parent) {
				//while (this.numChildren > 0) {
					//this.removeChildAt(0);
				//}
				
				removeEventListener(Event.ENTER_FRAME, onEnter);
				parent.removeChild(this);
			}
			
		}
		private function draw(ratio:Number):void {
			graphics.clear();
			
			if(type == CIRCLE){
				graphics.beginFill(Utils.rgbBrightness(0xFF0000, ratio), 1);
				//graphics.beginFill(rgb, 1);
				graphics.drawCircle(0, 0, 3);
				graphics.endFill();
			}else if(type == CROSS){
				graphics.beginFill(Utils.rgbBrightness(rgb, ratio), 1);
				//graphics.beginFill(rgb, 1);
				graphics.drawRect(-4, 0, 9, 1);
				graphics.drawRect(0, -4, 1, 9);
				graphics.endFill();
			}
		}
		
	}
	
}