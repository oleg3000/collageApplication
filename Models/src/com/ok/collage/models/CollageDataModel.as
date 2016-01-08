package com.ok.collage.models {
import flash.display.Bitmap;

import org.robotlegs.mvcs.Actor;

public class CollageDataModel extends Actor {

	private var _images : Vector.<Bitmap>;

	public function CollageDataModel()
	{
		super();
	}

	public function addImages (images : Vector.<Bitmap>) : void
	{
		_images = images;
	}

	public function get images() : Vector.<Bitmap>
	{
		return _images;
	}

	public function removeImage(image : Bitmap) : void
	{
		_images.splice(_images.indexOf(image), 1);


	}
}
}
