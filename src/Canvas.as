package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import jp.mztm.kinect.Kinect;
	import jp.mztm.kinect.KinectEvent;

    /**
     * ...
     * @author umhr
     */
    public class Canvas extends Sprite
    {
		private var _drawer:Drawer;
		private var _kinect:Kinect;
        public function Canvas():void
        {
            if (stage) init();
            else addEventListener(Event.ADDED_TO_STAGE, init);
        }

        private function init(e:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
            // entry point
			
			_drawer = new Drawer();
			addChild(_drawer);
			
			addEventListener(Event.ENTER_FRAME, onEnter);
			//_kinect = new Kinect(stage.stageWidth, stage.stageHeight);
			//_kinect.useDammyData = true;
			//_kinect.addEventListener(KinectEvent.UPDATE, onUpdate);
			//_kinect.execute();
        }
		
		private function onUpdate(e:KinectEvent):void 
		{
			var handRight:Vector3D = e.skeleton.skeletonDataList[0].handRight;
			
			_drawer.pointList[0] = new Point(handRight.x, handRight.y);
		}
		
		private function onEnter(e:Event):void 
		{
			_drawer.pointList[0] = new Point(mouseX, mouseY);
			_drawer.pointList[1] = new Point(mouseX, 768-mouseY);
			//_drawer.pointList[2] = new Point(1024-mouseX, 768-mouseY);
			//_drawer.pointList[3] = new Point(1024-mouseX, mouseY);
			//_drawer.pointList[1] = new Point((mouseX-1024) * 0.5, (mouseY-768) * 0.5);
		}


    }

}
