package com.flashgangsta.utils {
	
	/**
	 * ...
	 * @author Sergey Krivtsov (flashgangsta@gmail.com)
	 * @version	0.03 23/10/2014
	 */
	
	public class Queue {
		
		private var methods:Array = [];
		private var args:Array = [];
		
		/**
		 *
		 */
		
		public function Queue() {
		
		}
		
		/**
		 *
		 * @param	method
		 * @param	...args
		 */
		
		public function push(method:Function, ... args):void {
			methods.push(method);
			this.args.push(args);
		}
		
		public function unshift(method:Function, ...args):void {
			methods.unshift(method);
			this.args.unshift(args);
		}
		
		/**
		 *
		 */
		
		public function applyAll():void {
			while (methods.length) {
				applyFirst();
			}
		}
		
		/**
		 *
		 */
		
		public function applyFirst():void {
			if (!methods.length)
				return;
			var method:Function = methods.shift() as Function;
			method.apply(null, args.shift() as Array);
		}
		
		/**
		 *
		 */
		
		public function get length():int {
			return methods.length;
		}
	
	}

}