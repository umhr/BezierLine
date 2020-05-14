package jp.mztm.kinect
{
	import flash.geom.Vector3D;
	/**
	 * Skeltonの値を保持します。
	 * @author umhr
	 */
	public class SkeletonData 
	{
		/**
		 * 人番号
		 */
		public var id:int;
		/**
		 * 頭の座標
		 */
		public var head:Vector3D;
		/**
		 * 肩の中央、首元
		 */
		public var shoulderCenter:Vector3D;
		/**
		 * 左肩
		 */
		public var shoulderLeft:Vector3D;
		/**
		 * 右肩
		 */
		public var shoulderRight:Vector3D;
		/**
		 * 左ひじ
		 */
		public var elbowLeft:Vector3D;
		/**
		 * 右ひじ
		 */
		public var elbowRight:Vector3D;
		/**
		 * 左手
		 */
		public var handLeft:Vector3D;
		/**
		 * 右手
		 */
		public var handRight:Vector3D;
		/**
		 * 尻の中央、へそ
		 */
		public var hipCenter:Vector3D;
		/**
		 * 背骨、体の中心、胸の下あたり
		 */
		public var spine:Vector3D;
		/**
		 * 左手首
		 */
		public var wristLeft:Vector3D;
		/**
		 * 右手首
		 */
		public var wristRight:Vector3D;
		/**
		 * 左の尻
		 */
		public var hipLeft:Vector3D;
		/**
		 * 左ひざ
		 */
		public var kneeLeft:Vector3D;
		/**
		 * 左足首
		 */
		public var ankleLeft:Vector3D;
		/**
		 * 左足の平
		 */
		public var footLeft:Vector3D;
		/**
		 * 右の尻
		 */
		public var hipRight:Vector3D;
		/**
		 * 右ひざ
		 */
		public var kneeRight:Vector3D;
		/**
		 * 右足首
		 */
		public var ankleRight:Vector3D;
		/**
		 * 右足の平
		 */
		public var footRight:Vector3D;
		
		public function SkeletonData() 
		{
			
		}
		
		public function getJointList():Vector.<Vector3D> {
			return new <Vector3D>[
				head,
				shoulderCenter,
				shoulderLeft,
				shoulderRight,
				elbowLeft,
				elbowRight,
				handLeft,
				handRight,
				hipCenter,
				spine,
				wristLeft,
				wristRight,
				hipLeft,
				kneeLeft,
				ankleLeft,
				footLeft,
				hipRight,
				kneeRight,
				ankleRight,
				footRight
				];
		}
		
		/**
		 * 値を正確に複製し、返します。元の値は変更されません。
		 * @return
		 */
		public function clone():SkeletonData {
			var result:SkeletonData = new SkeletonData();
			result.id = id;
			result.head = head?head.clone():null;
			result.shoulderCenter = shoulderCenter?shoulderCenter.clone():null;
			result.shoulderLeft = shoulderLeft?shoulderLeft.clone():null;
			result.shoulderRight = shoulderRight?shoulderRight.clone():null;
			result.elbowLeft = elbowLeft?elbowLeft.clone():null;
			result.elbowRight = elbowRight?elbowRight.clone():null;
			result.handLeft = handLeft?handLeft.clone():null;
			result.handRight = handRight?handRight.clone():null;
			result.hipCenter = hipCenter?hipCenter.clone():null;
			result.spine = spine?spine.clone():null;
			result.wristLeft = wristLeft?wristLeft.clone():null;
			result.wristRight = wristRight?wristRight.clone():null;
			result.hipLeft = hipLeft?hipLeft.clone():null;
			result.kneeLeft = kneeLeft?kneeLeft.clone():null;
			result.ankleLeft = ankleLeft?ankleLeft.clone():null;
			result.footLeft = footLeft?footLeft.clone():null;
			result.hipRight = hipRight?hipRight.clone():null;
			result.kneeRight = kneeRight?kneeRight.clone():null;
			result.ankleRight = ankleRight?ankleRight.clone():null;
			result.footRight = footRight?footRight.clone():null;
			return result;
		}
		
	}

}