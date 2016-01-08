package com.ok.collage.services.interfaces {
import flash.display.Bitmap;

public interface IImageProviderService {
	function loadImages(urls : Vector.<String>) : void;

	function unload(image : Bitmap) : void;
}
}
