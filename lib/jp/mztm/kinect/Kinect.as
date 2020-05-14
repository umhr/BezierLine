package jp.mztm.kinect
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author ...
	 */
	public class Kinect extends Sprite
	{
		
		private var _fileName:String = 'SkeletalViewer.exe';
		private var _file:File;
		private var _cacheByte:ByteArray;
		private var _nativeProcess:NativeProcess;
		public var skeleton:Skeleton;
		public var stageWidth:Number;
		public var stageHeight:Number;
		public var useDammyData:Boolean;
		/**
		 * 何回目の呼び出しか。ダミーモードの場合使用。
		 */
		private var count:int = 0;
		
		
		public function Kinect(stageWidth:Number, stageHeight:Number, useDammyData:Boolean = false) 
		{
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			this.useDammyData = useDammyData;
			//init(stageWidth, stageHeight, isDammyData);
		}
		
		/**
		 * 読み取りを実行します。
		 */
		public function execute():void 
		{
			skeleton = new Skeleton(stageWidth, stageHeight);
			
			if (useDammyData) {
				addEventListener(Event.ENTER_FRAME, onEnter);
				return;
			}
			
			if(File){
				_file = File.applicationDirectory.resolvePath(_fileName);
			}
			
			_cacheByte = new ByteArray();
			var arguments:Vector.<String>;
			var nativeProcessStartupInfo:NativeProcessStartupInfo;
			if (NativeProcess.isSupported && _file.exists) {
				
				// 引数（不要）
				arguments = new Vector.<String>();
				arguments[0] = 'from Adobe AIR';
				
				nativeProcessStartupInfo = new NativeProcessStartupInfo();
				nativeProcessStartupInfo.arguments = arguments;
				nativeProcessStartupInfo.executable = _file;
				
				_nativeProcess = new NativeProcess();
				_nativeProcess.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
				
				_nativeProcess.start(nativeProcessStartupInfo);
				trace("NativeProcess.isSupported : " + NativeProcess.isSupported);
				trace("file.exists : " + _file.exists);
				trace("nativeProcess.running : " + _nativeProcess.running);
			}
			
		}
		
		
		/**
		 * ダミーモードの場合、この関数が実行されます。
		 * @param	e
		 */
		private function onEnter(e:Event):void 
		{
			var value:String = "26:Head,0.1089498,0.1841381,1.853028/ShoulderCenter,0.1241989,-0.02875383,1.868474/ShoulderLeft,-0.03666145,-0.14188,1.887856/ShoulderRight,0.2836685,-0.1392247,1.8554/ElbowLeft,-0.1444282,-0.3273673,1.940639/ElbowRight,0.4163824,-0.2914144,1.843579/HandLeft,-0.3401649,-0.3148984,1.637908/HandRight,0.4858286,-0.3613162,1.532444/HipCenter,0.134674,-0.3988586,1.784101/Spine,0.1373303,-0.3480311,1.837639/WristLeft,-0.2743414,-0.3258367,1.729143/WristRight,0.4648975,-0.3495679,1.606502/HipLeft,0.06436305,-0.4697149,1.764556/KneeLeft,0.02793358,-0.8516603,1.691184/AnkleLeft,0.000518674,-1.139092,1.621357/FootLeft,-0.01236304,-1.163656,1.531696/HipRight,0.2087507,-0.4689369,1.76703/KneeRight,0.3545828,-0.8279117,1.726023/AnkleRight,0.4643283,-1.098057,1.680552/FootRight,0.4760403,-1.126634,1.591927";
			
			value = DammyData.list[count];
			
			skeleton.parseByString(value);
			
			this.dispatchEvent(new KinectEvent(skeleton, "update"));
			
			count ++;
			count = count % DammyData.list.length;
		}
		
		/**
		 * 人の形を認識すると呼び出されます。
		 * @param	event
		 */
        private function onOutputData (event:ProgressEvent):void
        {
			_nativeProcess.standardOutput.readBytes(_cacheByte, _cacheByte.length, _nativeProcess.standardOutput.bytesAvailable);
			parseData();
		}
		
		
		// データのヘッドをパース
		private function parseData ():void
		{
			
			_cacheByte.position = 0;
			var str:String = _cacheByte.readMultiByte(_cacheByte.bytesAvailable, 'shift-jis');
			var pattern:RegExp = /^hdr:([0-9]+?)\r\n/;
			var result:Object = pattern.exec(str);
			if (!result) {
				return;
			} else {
				var contentLength:uint = uint(result[1]);
			}
			var headerByte:ByteArray = new ByteArray();
			headerByte.writeMultiByte('hdr:' + String(contentLength) + '\r\n', 'shift-jis');
			var headerLength:uint = headerByte.length;
			// キャッシュがヘッダ容量＋コンテンツ容量を上回るか？
			if (_cacheByte.length < headerLength + contentLength) {
				return;
			} else {
				_cacheByte.position = headerByte.length;
			}
			var bodyByte:ByteArray = new ByteArray();
			_cacheByte.readBytes(bodyByte, 0, contentLength);
			parseBody(bodyByte);
			
			var remainder:ByteArray = new ByteArray();
			remainder.writeBytes(_cacheByte, headerLength + contentLength, _cacheByte.bytesAvailable);
			_cacheByte.length = 0;
			_cacheByte.writeBytes(remainder, 0, remainder.bytesAvailable);
			
			if (_cacheByte.length > 0) {
				parseData();
			}
		}
		
		private function parseBody(bodyByte:ByteArray):void
		{
			skeleton.parseByByteArray(bodyByte);
			
			this.dispatchEvent(new KinectEvent(skeleton, "update"));
		}
		
	}

}