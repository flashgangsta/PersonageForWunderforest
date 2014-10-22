package com.rr.personage {
	import com.flashgangsta.utils.MovieClipUtil;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	public class PersonageInstance extends Sprite {
		
		private var actionInstancesListByActionClass:Dictionary = new Dictionary();
		
		public function PersonageInstance() {
			super();
		}
		
		public function getActionInstance(actionName:String):MovieClip {
			var className:String = "com.rr.personage.actions." + actionName;
			var actionClass:Class;
			
			actionClass = loaderInfo.applicationDomain.getDefinition(className) as Class;
			
			if (!actionInstancesListByActionClass[actionClass]) {
				actionInstancesListByActionClass[actionClass] = new actionClass();
				MovieClipUtil.stopAllMovieClips(MovieClip(actionInstancesListByActionClass[actionClass]));
			}
			
			return actionInstancesListByActionClass[actionClass];
		}
		
		
	}

}