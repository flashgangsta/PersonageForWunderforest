package com.rr.personage {
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PersonageModel {
		
		static private const MAX_DRUNK_LEVEL:int = 3;
		
		private var _path:String;
		private var _color:uint;
		private var _strokeColor:uint;
		private var _brightColor:uint;
		private var _sex:String;
		private var _drunkLevel:int = 0; //from 0 to MAX_DRUNK_LEVEL
		private var _isPoisoned:Boolean;
		
		/**
		 * 
		 * @param	data
		 */
		
		public function PersonageModel(data:Object) {
			_path = data.path;
			_sex = data.sex;
			_color = data.color;
			_drunkLevel = Math.min(data.drunkLevel, MAX_DRUNK_LEVEL);
			_isPoisoned = data.isPoisoned;
			
			setPartColors();
		}
		
		/**
		 * calculate stroke and bright colors by basic personage color
		 */
		
		private function setPartColors():void {
			const rgb:String = _color.toString(16);
			const r:String = rgb.substr(0, 2);
			const g:String = rgb.substr(2, 2);
			const b:String = rgb.substr(4, 2);
			const strokeR:String = Math.max(uint("0x" + r) - 65, 0).toString(16);
			const strokeG:String = Math.max(uint("0x" + g) - 75, 0).toString(16);
			const brightR:String = Math.min(uint("0x" + r) + 31, 255).toString(16);
			
			_strokeColor = uint("0x" +  strokeR + strokeG + b);
			_brightColor = uint("0x" +  brightR + g + b);
			
		}
		
		public function get path():String {
			return _path;
		}
		
		public function get color():uint {
			return _color;
		}
		
		public function get strokeColor():uint {
			return _strokeColor;
		}
		
		public function get brightColor():uint {
			return _brightColor;
		}
		
		public function get sex():String {
			return _sex;
		}
		
		public function get drunkLevel():int {
			return _drunkLevel;
		}
		
		public function get isPoisoned():Boolean {
			return _isPoisoned;
		}
		
	}

}