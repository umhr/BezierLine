package jp.mztm.kinect
{
	import flash.geom.Vector3D;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author umhr
	 */
	public class Skeleton 
	{
		public var stageWidth:Number;
		public var stageHeight:Number;
		public var skeletonDataList:Vector.<SkeletonData> = new Vector.<SkeletonData>();
		public function Skeleton(stageWidth:Number, stageHeight:Number) 
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		public function parseByByteArray(bodyByte:ByteArray):void {
			
			var data:String = bodyByte.readMultiByte(bodyByte.bytesAvailable, 'shift-jis');
			//trace(data);
			data = data.split('\r\r').join('');
			parseByString(data);
		}
		public function parseByString(data:String):void {
			var skeletonList:Array = data.split('$');
			
			var n:int = skeletonList.length;
			for (var i:int = 0; i < n; i++) {
				skeletonDataList[i] = new SkeletonData();
				
				var dataList:Array = skeletonList[i].split(':');
				skeletonDataList[i].id = uint(dataList[0]);
				var jointList:Array = dataList[1].split('/');
				var m:int = jointList.length;
				var jointData:Array;
				var key:String;
				
				// 関節分ループ
				for (var j:int = 0; j < m; j++) {
					jointData = jointList[j].split(',');
					key = jointData[0];
					key = key.substr(0, 1).toLowerCase() + key.substr(1);
					skeletonDataList[i][key] = new Vector3D();
					skeletonDataList[i][key].x = stageWidth * 0.5 + Number(jointData[1]) * 400;
					skeletonDataList[i][key].y = stageHeight * 0.5 - Number(jointData[2]) * 400;
					skeletonDataList[i][key].z = Number(jointData[3])*400;
				}
				
			}
			
		}
		
		
	}

}