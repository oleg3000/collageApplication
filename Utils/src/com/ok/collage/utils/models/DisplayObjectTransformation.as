package com.ok.collage.utils.models {
import flash.display.DisplayObject;
import flash.geom.Point;

public class DisplayObjectTransformation {

	private var _displayObject : DisplayObject;

	public var targetHeight : Number;

	public function get displayObject() : DisplayObject
	{
		return _displayObject;
	}

	public function get targetWidth() : Number
	{
		return targetHeight * proportion;
	}

	public function get proportion() : Number
	{
		return _displayObject.width / _displayObject.height;
	}


	//---------------------------------------
	//Static methods
	//---------------------------------------


	public static function fromDisplayObject (displayObject : DisplayObject) : DisplayObjectTransformation
	{
		const instance : DisplayObjectTransformation = new DisplayObjectTransformation();
		instance._displayObject = displayObject;
		return instance;
	}

}
}
