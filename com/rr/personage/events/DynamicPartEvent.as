package com.rr.personage.events {
	import com.rr.personage.DynamicPart;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class DynamicPartEvent extends Event {
		
		static public const COLOR_PART_BASIC_INIT:String = "colorPartBasicInit";
		static public const COLOR_PART_BRIGHT_INIT:String = "colorPartBrightInit";
		static public const COLOR_PART_STROKE_INIT:String = "colorPartStrokeInit";
		static public const DRUNK_EASY_PART_INIT:String = "drunkEasePartInit";
		static public const DRUNK_MEDIUM_PART_INIT:String = "drunkMediumPartInit";
		static public const DRUNK_HARD_PART_INIT:String = "drunkHardPartInit";
		static public const EYELASHES_INIT:String = "eyelashesInit";
		static public const POISONED_PART_INIT:String = "poisonedPartInit";
		
		private var _part:DynamicPart;
		
		public function DynamicPartEvent(type:String, part:DynamicPart, bubbles:Boolean=false, cancelable:Boolean=false) { 
			_part = part;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new DynamicPartEvent(type, part, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("DynamicPartEvent", "type", "part", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get part():DynamicPart {
			return _part;
		}
		
	}
	
}