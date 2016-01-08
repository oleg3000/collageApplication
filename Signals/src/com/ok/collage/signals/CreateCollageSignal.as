package com.ok.collage.signals {
import flash.display.Bitmap;

import org.osflash.signals.Signal;

public class CreateCollageSignal extends Signal {

	public function CreateCollageSignal()
	{
		super (Vector.<Bitmap>);
	}
}
}
