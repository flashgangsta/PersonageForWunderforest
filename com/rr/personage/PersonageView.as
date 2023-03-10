package com.rr.personage {
	import com.flashgangsta.utils.MovieClipUtil;
	import com.flashgangsta.utils.Queue;
	import com.rr.Dispatcher;
	import com.rr.personage.events.DynamicPartEvent;
	import com.rr.personage.events.PersonageActionEvent;
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
		private var actionsQueue:Queue = new Queue();
		private var multipartActionQueue:Queue = new Queue();
		
		/**
		 * 
		 * @param	model
		 */
		
		public function PersonageView(model:PersonageModel) {
			super();
			this.model = model;
			
			Test.log("<-------------------------");
			Test.log("poison:", model.alco);
			Test.log("poison:", model.poison);
			Test.log(">-------------------------");
			
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
			
			if (model.isDead && actionName !== PersonageActions.RESURRECTED) {
				Test.log("Personage dead. For playing this action, personage must be resurrected.");
				return;
			} else if (!model.isDead && actionName === PersonageActions.RESURRECTED) {
				Test.log("Personage has not dead. For playing this action, personage must be dead");
				return;
			}
			
			if (currentAction) {
				if (currentAction !== instance.getActionInstance(PersonageActions.DEFAULT) && actionName !== PersonageActions.DEFAULT && actionName !== PersonageActions.RESURRECTED) {
					Test.log("add action to queue and break", currentAction);
					actionsQueue.push(showAction, actionName);
					return;
				}
				
				Test.log("remove action", currentAction);
				
				currentAction.addFrameScript(0, null);
				currentAction.addFrameScript(currentAction.totalFrames - 1, null);
				MovieClipUtil.stopAllMovieClips(currentAction, false, 1);
				removeChild(currentAction);
				currentAction = null;
			}
			
			if (!multipartActionQueue.length && checkAndInitMultipartAction(actionName)) {
				multipartActionQueue.push(onActionComplete);
				return;
			}
			
			currentAction = instance.getActionInstance(actionName);
			
			Test.log("start new action", currentAction);
			
			if(actionName !== PersonageActions.DEFAULT) {
				currentAction.addFrameScript(currentAction.totalFrames - 1, onActionLastFrame);
			}
			
			MovieClipUtil.playAllMovieClips(currentAction, false, 2);
			addChild(currentAction);
		}
		
		/**
		 * 
		 * @param	actionName
		 */
		
		private function checkAndInitMultipartAction(actionName:String):Boolean {
			if (multipartActionQueue.length) {
				return false;
			}
			
			switch(actionName) {
				case PersonageActions.SHOOT_MISFIRE:
				case PersonageActions.SHOOT_SHOOT_MISFIRE:
				case PersonageActions.SHOOT_SHOOT_SHOOT_MISFIRE:
				case PersonageActions.SHOOT_SHOT_SURVIVED:
				case PersonageActions.SHOOT_SHOOT_SHOT_SURVIVED:
				case PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_SURVIVED:
					showAction(PersonageActions.TOOK_OUT_GUN_TO_TEMPLE);
					multipartActionQueue.push(showAction, actionName);
					multipartActionQueue.push(showAction, PersonageActions.HIDE_GUN_FROM_TEMPLE);
					return true;
				case PersonageActions.REVOLVING:
					showAction(PersonageActions.TOOK_OUT_GUN);
					multipartActionQueue.push(showAction, actionName);
					multipartActionQueue.push(showAction, PersonageActions.HIDE_GUN);
					return true;
				case PersonageActions.SHOOT_SHOT_DEATH:
				case PersonageActions.SHOOT_SHOOT_SHOT_DEATH:
				case PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_DEATH:
					showAction(PersonageActions.TOOK_OUT_GUN_TO_TEMPLE);
					multipartActionQueue.push(showAction, actionName);
					return true;
				default :
					return false;
			}
		}
		
		/**
		 * 
		 */
		
		private function onActionLastFrame():void {
			Test.log("last frame of action", currentAction);
			
			switch(currentAction) {
				case instance.getActionInstance(PersonageActions.STROKING_BELLY):
				case instance.getActionInstance(PersonageActions.SHAKING):
				case instance.getActionInstance(PersonageActions.EATING):
				case instance.getActionInstance(PersonageActions.DRINKING):
				case instance.getActionInstance(PersonageActions.SCARED):
				case instance.getActionInstance(PersonageActions.GIGGLES):
				case instance.getActionInstance(PersonageActions.WAVING):
				case instance.getActionInstance(PersonageActions.LOOKS_ARROUND):
				case instance.getActionInstance(PersonageActions.SCARED):
				case instance.getActionInstance(PersonageActions.PLEASURE):
				case instance.getActionInstance(PersonageActions.JOY):
				case instance.getActionInstance(PersonageActions.DISSATISFIED):
				case instance.getActionInstance(PersonageActions.POISONED):
					onActionComplete();
					break;
				case instance.getActionInstance(PersonageActions.RESURRECTED):
					model.dispatchEvent(new PersonageActionEvent(PersonageActionEvent.PERSONAGE_RESURRECTED));
					onActionComplete();
					break;
				case instance.getActionInstance(PersonageActions.TOOK_OUT_GUN_TO_TEMPLE):
				case instance.getActionInstance(PersonageActions.HIDE_GUN_FROM_TEMPLE):
				case instance.getActionInstance(PersonageActions.SHOOT_MISFIRE):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_MISFIRE):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_SHOOT_MISFIRE):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOT_SURVIVED):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_SHOT_SURVIVED):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_SURVIVED):
				case instance.getActionInstance(PersonageActions.REVOLVING):
				case instance.getActionInstance(PersonageActions.TOOK_OUT_GUN):
				case instance.getActionInstance(PersonageActions.HIDE_GUN):
					onMultipartActionPartComplete();
					break;
				case instance.getActionInstance(PersonageActions.SHOOT_SHOT_DEATH):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_SHOT_DEATH):
				case instance.getActionInstance(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_DEATH):
				case instance.getActionInstance(PersonageActions.CARDIAC_ARREST):
				case instance.getActionInstance(PersonageActions.POISONED_DEATH):
					onActionDeathComplete();
					break;
				default:
					playActionBack();
					break;
			}
		}
		
		/**
		 * 
		 */
		
		private function playActionBack():void {
			Test.log("play action back started", currentAction);
			currentAction.addFrameScript(currentAction.currentFrame - 1, null);
			currentAction.addFrameScript(0, onActionBackToFirstFrame);
			MovieClipUtil.stopAllMovieClips(currentAction);
			MovieClipUtil.playClipBack(currentAction);
		}
		
		/**
		 * 
		 */
		
		private function onActionBackToFirstFrame():void {
			Test.log("action is back to first frame", currentAction);
			if (multipartActionQueue.length) {
				multipartActionQueue.dispose();
			}
			onActionComplete();
		}
		
		/**
		 * 
		 */
		
		private function onActionComplete():void {
			dispatchEvent(new PersonageActionEvent(PersonageActionEvent.ACTION_COMPLETE));
			if (multipartActionQueue.length) {
				multipartActionQueue.dispose();
			}
			showAction(PersonageActions.DEFAULT);
			if (actionsQueue.length) {
				Test.log("apply firs element in actionsQueue");
				actionsQueue.applyFirst();
			}
		}
		
		/**
		 * 
		 */
		
		private function onMultipartActionPartComplete():void {
			MovieClipUtil.stopAllMovieClips(currentAction);
			showAction(PersonageActions.DEFAULT);
			if(multipartActionQueue.length) {
				multipartActionQueue.applyFirst();
			} else {
				multipartActionQueue.dispose();
			}
		}
		
		/**
		 * 
		 */
		
		private function onActionDeathComplete():void {
			currentAction.stop();
			if (multipartActionQueue.length) {
				multipartActionQueue.dispose();
			}
			model.dispatchEvent(new PersonageActionEvent(PersonageActionEvent.PERSONAGE_DIED));
			dispatchEvent(new PersonageActionEvent(PersonageActionEvent.ACTION_COMPLETE));
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
			event.part.visible = model.sex === PersonageSex.FEMALE;
			/*const ct:ColorTransform = new ColorTransform();
			ct.color = 0x00FF00;
			event.part.transform.colorTransform = ct;*/
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
			event.part.visible = model.alco === 1;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onDrunkMediumPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.alco === 2;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function onDrunkHardPartInit(event:DynamicPartEvent):void {
			event.part.visible = model.alco === 3;
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		private function poisonedPartInit(event:DynamicPartEvent):void {
			event.part.visible = Boolean(model.poison);
		}
		
	}

}