package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class GenderPart extends DynamicPart {
		
		public function GenderPart() {
			super.dispatch(DynamicPartEvent.EYELASHES_INIT);
		}
		
	}

}