package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PoisonedPart extends DynamicPart {
		
		public function PoisonedPart() {
			super.dispatch(DynamicPartEvent.POISONED_PART_INIT);
		}
		
	}

}