package com.rr.personage {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 */
	
	[SWF(frameRate="31", width="2800", height="1400")]
	
	public class Test extends Sprite {
		
		public function Test() {
			super();
			
			var modelObj:Object = {
				name: "Заяц",
				nickname: "Вася",
				sex: PersonageSex.MALE,
				color: "0x9b5eff",
				drunkLevel: 3,
				isPoisoned: true,
				path: "rabbit.swf"
				
			}
			
			var personageModel:PersonageModel = new PersonageModel(modelObj);
			var personageView:PersonageView = new PersonageView(personageModel);
			
			addChild(personageView);
			
			//personageView.showAction(PersonageActions.RESURRECTED);
			//personageView.showAction(PersonageActions.DRUNK);
			//personageView.showAction(PersonageActions.DRINKING);
			//personageView.showAction(PersonageActions.STROKING_BELLY);
			//personageView.showAction(PersonageActions.EATING);
			//personageView.showAction(PersonageActions.CONTUSED_BY_BOMB_DEATH);
			//personageView.showAction(PersonageActions.CONTUSED_BY_BOMB);
			//personageView.showAction(PersonageActions.POISONED_DEATH);
			//personageView.showAction(PersonageActions.POISONED);
			//personageView.showAction(PersonageActions.SHAKING);
			//personageView.showAction(PersonageActions.SCARED);
			//personageView.showAction(PersonageActions.LOOKS_ARROUND);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_DEATH);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOT_DEATH);
			//personageView.showAction(PersonageActions.DISSATISFIED);
			//personageView.showAction(PersonageActions.GIGGLES);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.SHOOT_SHOT_SURVIVED);
			//personageView.showAction(PersonageActions.CONTUSED);
			//personageView.showAction(PersonageActions.REVOLVING);
			//personageView.showAction(PersonageActions.JOY);
			//personageView.showAction(PersonageActions.PLEASURE);
			//personageView.showAction(PersonageActions.CARDIAC_ARREST);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.SHOOT_SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.SHOOT_MISFIRE);
			//personageView.showAction(PersonageActions.TOOK_OUT_GUN_FOR_REVOLVE);
			//personageView.showAction(PersonageActions.TOOK_OUT_GUN_FOR_SHOT);
			//personageView.showAction(PersonageActions.WAVING);
			//personageView.showAction(PersonageActions.SHOOT_SHOT_DEATH);
			
			personageView.x = stage.stageWidth / 2;
			personageView.y = stage.stageHeight / 2;
			//personageView.scaleX = personageView.scaleY = 4.5;
			
		}
		
	}

}