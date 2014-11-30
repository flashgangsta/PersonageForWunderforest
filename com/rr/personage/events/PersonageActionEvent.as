package com.rr.personage.events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PersonageActionEvent extends Event {
		
		static public const ACTION_COMPLETE:String = "PersonageActionEventActionComplete";
		static public const PERSONAGE_DIED:String = "PersonageActionEventPessonageDied";
		static public const PERSONAGE_RESURRECTED:String = "PersonageActionEventPersonageResurrected";
		
		/**
		 * 
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 */
		
		public function PersonageActionEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			
		} 
		
		/**
		 * 
		 * @return
		 */
		
		public override function clone():Event { 
			return new PersonageActionEvent(type, bubbles, cancelable);
		} 
		
		/**
		 * 
		 * @return
		 */
		
		public override function toString():String { 
			return formatToString("PersonageEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}