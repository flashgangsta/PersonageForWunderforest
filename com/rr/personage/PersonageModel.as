package com.rr.personage {
	import com.rr.personage.events.PersonageActionEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PersonageModel extends EventDispatcher {
		
		static private const MAX_ALCO:Number = 3;
		static private const MAX_POISON:Number = 2;
		
		private var _path:String;
		private var _color:uint;
		private var _strokeColor:uint;
		private var _brightColor:uint;
		private var _sex:String;
		private var _alco:Number = 0; //from 0 to MAX_ALCO
		private var _poison:Number = 0; //frim 0 to MAX_POISON
		private var _isDead:Boolean = false;
		
		/**
		 * 
		 * @param	data
		 */
		
		public function PersonageModel(data:Object) {
			this.data = data;
			addEventListener(PersonageActionEvent.PERSONAGE_DIED, onPersonageDied);
			addEventListener(PersonageActionEvent.PERSONAGE_RESURRECTED, onPersonageResurrected);
		}
		
		public function set data(data:Object):void {
			_path = data.path;
			_sex = data.sex;
			_color = data.color;
			_alco = Math.min(data.alco, MAX_ALCO);
			_poison = Math.min(data.poison, MAX_POISON);
			
			calculatePartsColors();
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
		
		public function get alco():Number {
			return _alco;
		}
		
		public function get poison():Number {
			return _poison;
		}
		
		/**
		 * 
		 */
		
		public function get isDead():Boolean {
			return _isDead;
		}
		
		/**
		 * calculate stroke and bright colors by basic personage color
		 */
		
		private function calculatePartsColors():void {
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
		
		private function onPersonageDied(event:PersonageActionEvent):void {
			Test.log("Personage is died");
			_isDead = true;
		}
		
		private function onPersonageResurrected(event:PersonageActionEvent):void {
			Test.log("Personage is resurrected");
			_isDead = false;
		}
		
	}

}