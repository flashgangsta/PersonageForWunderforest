package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class BrightColorPart extends DynamicPart {
		
		public function BrightColorPart() {
			super.dispatch(DynamicPartEvent.COLOR_PART_BRIGHT_INIT);
		}
		
	}

}