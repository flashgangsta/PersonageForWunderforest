package com.rr.personage.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PersonageActionEvent extends Event {
		
		static public const ACTION_COMPLETE:String = "PersonageActionComplete";
		
		public function PersonageActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		public override function clone():Event { 
			return new PersonageActionEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("PersonageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}