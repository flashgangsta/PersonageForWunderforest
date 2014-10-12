package com.rr.personage {
	import com.rr.personage.events.DynamicPartEvent;
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class StrokeColorPart extends DynamicPart {
		
		public function StrokeColorPart() {
			super.dispatch(DynamicPartEvent.COLOR_PART_STROKE_INIT);
		}
		
	}

}