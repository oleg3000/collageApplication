package com.ok.collage.signals {
import flash.display.Bitmap;

import org.osflash.signals.Signal;

public class ImagesLoadedSignal extends Signal {

	public function ImagesLoadedSignal()
	{
		super (Vector.<Bitmap>);
	}
}
}
