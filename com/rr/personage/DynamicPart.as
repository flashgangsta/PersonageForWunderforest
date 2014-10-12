package com.rr.personage {
	import com.rr.Dispatcher;
	import com.rr.personage.events.DynamicPartEvent;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class DynamicPart extends MovieClip {
		
		public function DynamicPart() {
			super();
		}
		
		protected function dispatch(eventType:String):void {
			Dispatcher.getInstance().dispatchEvent(new DynamicPartEvent(eventType, this));
		}
		
	}

}