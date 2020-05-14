package jp.mztm.kinect
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class KinectEvent extends Event 
	{
		static public const UPDATE:String = "update";
		
		public var skeleton:Skeleton;
		public function KinectEvent(skeleton:Skeleton, type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.skeleton = skeleton;
		} 
		
		public override function clone():Event 
		{ 
			return new KinectEvent(skeleton, type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("KinectEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}