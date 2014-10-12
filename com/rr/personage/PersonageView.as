package com.rr.personage {
	import com.flashgangsta.utils.MovieClipUtil;
	import com.rr.Dispatcher;
	import com.rr.personage.events.DynamicPartEvent;
	import flash.display.BlendMode;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	
	public class PersonageView extends Sprite {
		private var model:PersonageModel;
		private var instance:PersonageInstance;
		private var dispatcher:Dispatcher = Dispatcher.getInstance();
		private var basicColorPartColorTransform:ColorTransform = new ColorTransform();
		private var brightColorPartColorTransform:ColorTransform = new ColorTransform();
		private var strokeColorPartColorTransform:ColorTransform = new ColorTransform();
		private var currentAction:MovieClip;
		private var neededActionName:String;
		
		public function PersonageView(model:PersonageModel) {
			super();
			this.model = model;
			
			trace("drunk:", model.drunkLevel);
			
			basicColorPartColorTransform.color = model.color;
			brightColorPartColorTransform.color = model.brightColor;
			strokeColorPartColorTransform.color = model.strokeColor;
			
			loadPersonage();
		}
		
		/**
		 * 
		 * @param	default
		 */
		
		public function showAction(actionName:String):void {
			if (!instance) {
				neededActionName = actionName;
				return;
			}
			
			trace(currentAction);
			if (currentAction) {
				MovieClipUtil.stopAllMovieClips(currentAction);
			}
			currentAction = instance.getActionInstance(actionName);
			
			if(actionName !== PersonageActions.DEFAULT) {
				currentAction.addFrameScript(currentAction.totalFrames - 1, onActionLastFrame);
			}
			
			MovieClipUtil.playAllMovieClips(currentAction, false, 1);
			addChild(currentAction);
		}
		
		/**
		 * 
		 */
		
		private function onActionLastFrame():void {
			MovieClipUtil.stopAllMovieClips(currentAction);
		}
		
		/**
		 * 
		 */
		
		private function loadPersonage():void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onPersonageLoaded);
			loader.load(new URLRequest(model.path));
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onPersonageLoaded(event:Event):void {
			var loader:Loader = LoaderInfo(event.target).loader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onPersonageLoaded);
			instance = loader.content as PersonageInstance;
			
			dispatcher.addEventListener(DynamicPartEvent.COLOR_PART_BASIC_INIT, onColorPartBasicInit);
			dispatcher.addEventListener(DynamicPartEvent.COLOR_PART_BRIGHT_INIT, onColorPartBrightInit);
			dispatcher.addEventListener(DynamicPartEvent.COLOR_PART_STROKE_INIT, onColorPartStrokeInit);
			dispatcher.addEventListener(DynamicPartEvent.EYELASHES_INIT, onGenderPartInit);
			dispatcher.addEventListener(DynamicPartEvent.DRUNK_EASY_PART_INIT, onDrunkEasyPartInit);
			dispatcher.addEventListener(DynamicPartEvent.DRUNK_MEDIUM_PART_INIT, onDrunkMediumPartInit);
			dispatcher.addEventListener(DynamicPartEvent.DRUNK_HARD_PART_INIT, onDrunkHardPartInit);
			dispatcher.addEventListener(DynamicPartEvent.POISONED_PART_INIT, poisonedPartInit);
			
			showAction(neededActionName ? neededActionName : PersonageActions.DEFAULT);
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onGenderPartInit(event:DynamicPartEvent):void {
			//event.part.visible = model.sex === PersonageSex.FEMALE;
			const ct:ColorTransform = new ColorTransform();
			ct.color = 0x00FF00;
			event.part.transform.colorTransform = ct;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onColorPartBasicInit(event:DynamicPartEvent):void {
			BasicColorPart(event.part).getChildAt(0).transform.colorTransform = basicColorPartColorTransform;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onColorPartBrightInit(event:DynamicPartEvent):void {
			BrightColorPart(event.part).getChildAt(0).transform.colorTransform = brightColorPartColorTransform;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onColorPartStrokeInit(event:DynamicPartEvent):void {
			StrokeColorPart(event.part).getChildAt(0).transform.colorTransform = strokeColorPartColorTransform;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onDrunkEasyPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.drunkLevel === 1;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onDrunkMediumPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.drunkLevel === 2;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onDrunkHardPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.drunkLevel === 3;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function poisonedPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.isPoisoned;
		}
		
	}

}