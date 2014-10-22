package com.flashgangsta.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 * @version 0.09 23/10/2014
	 */
	
	public class MovieClipUtil {
		
		/**
		 *
		 */
		
		public function MovieClipUtil() {
		
		}
		
		/**
		 * Stops all movieclips contained in target display object container.
		 * @param	target parent of all animations to be stoped
		 * @param	stopOnCurrenFrame if this attribute is true, all movie clips will be stoped on current frame
		 * @param	stopOnFrame if parameter "stopOnCurrenFrame" is false, all movie clips will be stoped on frame equal this parameter value
		 */
		
		static public function stopAllMovieClips(target:DisplayObjectContainer, stopOnCurrenFrame:Boolean = true, stopOnFrame:int = 0):void {
			var numChildren:int = target.numChildren;
			var child:DisplayObject;
			var movieClip:MovieClip;
			
			for (var i:int = 0; i < numChildren; i++) {
				child = target.getChildAt(i);
				if (child is MovieClip) {
					movieClip = child as MovieClip;
					if (stopOnCurrenFrame) {
						movieClip.stop();
					} else {
						movieClip.gotoAndStop(stopOnFrame);
					}
				}
				
				if (child is DisplayObjectContainer) {
					MovieClipUtil.stopAllMovieClips(child as DisplayObjectContainer, stopOnCurrenFrame, stopOnFrame);
				}
			}
			
			if (target is MovieClip) {
				movieClip = target as MovieClip;
				movieClip.gotoAndStop(stopOnFrame ? stopOnFrame : movieClip.currentFrame);
			}
		}
		
		/**
		 * Start playing all movieclips contained in target display object container
		 * @param	target parent of all animations to be played
		 * @param	playFromCurrentFrame if this attribute is true, all movie clips will be started from current frame
		 * @param	playFromFrame if parameter "playFromCurrentFrame" is false, all movie clips will be started from frame equal this parameter value
		 */
		
		static public function playAllMovieClips(target:DisplayObjectContainer, playFromCurrentFrame:Boolean = true, playFromFrame:int = 0):void {
			var numChildren:int = target.numChildren;
			var child:DisplayObject;
			var movieClip:MovieClip;
			
			for (var i:int = 0; i < numChildren; i++) {
				child = target.getChildAt(i);
				if (child is DisplayObjectContainer) {
					MovieClipUtil.playAllMovieClips(child as DisplayObjectContainer, playFromCurrentFrame, playFromFrame);
				}
				
			}
			
			if (target is MovieClip) {
				movieClip = target as MovieClip;
				movieClip.gotoAndPlay(playFromCurrentFrame ? playFromCurrentFrame : movieClip.currentFrame);
			}
		
		}
		
		/**
		 *
		 */
		
		static public function playClipBack(movieClip:MovieClip):void {
			movieClip.addEventListener(Event.ENTER_FRAME, goToLastFrame);
		}
		
		/**
		 * 
		 * @param	event
		 */
		
		static private function goToLastFrame(event:Event):void {
			var movieClip:MovieClip = event.target as MovieClip;
			MovieClipUtil.stopAllMovieClips(movieClip, false, movieClip.currentFrame - 1);
			if (movieClip.currentFrame === 1) {
				movieClip.removeEventListener(Event.ENTER_FRAME, goToLastFrame);
			}
		}
	
	}

}