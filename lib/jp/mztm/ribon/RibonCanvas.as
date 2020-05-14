package jp.mztm.ribon
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class RibonCanvas extends Sprite
	{
		
		private var _particlerList:Vector.<Particler> = new Vector.<Particler>();
		
		public function RibonCanvas()
		{
			init();
		}
		
		private function init():void
		{
			if (stage)
			{
				onInit();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, onInit);
			}
		}
		
		private function onInit(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			for (var i:int = 0; i < 10; i++)
			{
				var particler:Particler = new Particler();
				_particlerList.push(particler);
				this.addChild(particler);
			}
			
			this.addEventListener(Event.ENTER_FRAME, onEnter);
		}
		
		private function onEnter(event:Event):void
		{
			//ribon0.execute();
			
			var pointXY:Array = [];
			pointXY.push([mouseX, mouseY]);
			pointXY.push([1024 - mouseX, mouseY]);
			pointXY.push([1024 - mouseX, 768 - mouseY]);
			pointXY.push([mouseX, 768 - mouseY]);
			pointXY.push([1024 * 0.5, 768 * 0.5]);
			pointXY.push([mouseY, mouseX]);
			pointXY.push([mouseY, 1024 - mouseX]);
			pointXY.push([768 - mouseY, 1024 - mouseX]);
			pointXY.push([768 - mouseY, mouseX]);
			pointXY.push([mouseY * 0.5, mouseX * 0.5]);
			
			var n:int = _particlerList.length;
			for (var i:int = 0; i < n; i++)
			{
				_particlerList[i].execute.apply(null, pointXY[i]);
				
				//var m:int = n-
				for (var j:int = i + 1; j < n; j++)
				{
					if (i != j) {
						var d:Number = (pointXY[i][0] - pointXY[j][0]) * (pointXY[i][0] - pointXY[j][0]);
						d += (pointXY[i][1] - pointXY[j][1]) * (pointXY[i][1] - pointXY[j][1]);
						if (d < 20) {
							//trace("Bang");
							
							var element:Particle = new Particle();
							element.x = (pointXY[i][0] + pointXY[j][0]) * 0.5;
							element.y = (pointXY[i][1] + pointXY[j][1]) * 0.5;
							addChild(element);
							
							
						}
						
						
					}
				}
				
			}
		
		}
	
	}

}