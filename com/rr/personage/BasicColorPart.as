package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class BasicColorPart extends DynamicPart {
		
		public function BasicColorPart() {
			super.dispatch(DynamicPartEvent.COLOR_PART_BASIC_INIT);
		}
		
	}

}