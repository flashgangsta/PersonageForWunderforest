package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class DrunkHardPart extends DynamicPart {
		
		public function DrunkHardPart() {
			super.dispatch(DynamicPartEvent.DRUNK_HARD_PART_INIT);
		}
		
	}

}