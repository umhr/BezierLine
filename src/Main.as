package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import jp.mztm.ribon.RibonCanvas;
	//import net.hires.debug.Stats;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 1024, height = 768, backgroundColor = 0x000000, frameRate = 60)]
	public class Main extends Sprite 
	{
		
		public function Main() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			this.addChild(new Canvas());
			//this.addChild(new Stats());
		}
		
	}
	
}