package com.ok.collage.signals {
import flash.display.Bitmap;

import org.osflash.signals.Signal;

public class ImageRemovedSignal extends Signal {

	public function ImageRemovedSignal()
	{
		super (Bitmap);
	}

}
}
