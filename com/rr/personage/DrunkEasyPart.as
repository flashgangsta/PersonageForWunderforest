package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class DrunkEasyPart extends DynamicPart {
		
		public function DrunkEasyPart() {
			super.dispatch(DynamicPartEvent.DRUNK_EASY_PART_INIT);
		}
		
	}

}