package jp.mztm.ribon
{
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.ITween;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Element extends Sprite {
		
		public function Element() 
		{
			init();
		}
		private function init():void {
			
			this.mouseEnabled = false;
			
			var colors:Array = [0x1166CC, 0x116699, 0x6699CC];
			
			var shape:Shape = new Shape();
			shape.graphics.beginFill(colors[Math.floor(Math.random()*3)], 1);
			shape.graphics.drawCircle(0, 0, 5);
			shape.graphics.endFill();
			addChild(shape);
			
			var r:Number = Math.random()*2*Math.PI;
			
			var rX:Number = Math.sin(r)*100;
			var rY:Number = Math.cos(r)*100;
			
			var t:ITween;
			t = BetweenAS3.tween(shape, { x:rX, y:rY, alpha:0 }, { x:0, y:0 }, 1, Sine.easeOut);
			t.addEventListener(TweenEvent.COMPLETE, onComplete);
			t.play();
			
		}
		
		private function onComplete(event:TweenEvent):void 
		{
			event.target.removeEventListener(TweenEvent.COMPLETE, onComplete);
			
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			parent.removeChild(this);
		}
		
	}
	
}