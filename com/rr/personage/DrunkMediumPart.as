package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class DrunkMediumPart extends DynamicPart {
		
		public function DrunkMediumPart() {
			super.dispatch(DynamicPartEvent.DRUNK_MEDIUM_PART_INIT);
		}
		
	}

}