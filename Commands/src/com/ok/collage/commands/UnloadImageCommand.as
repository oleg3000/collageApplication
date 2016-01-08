package com.ok.collage.commands {
import com.ok.collage.models.CollageDataModel;
import com.ok.collage.services.interfaces.IImageProviderService;

import flash.display.Bitmap;

import org.robotlegs.mvcs.Command;

public class UnloadImageCommand extends Command {

	[Inject]
	public var collageDataModel : CollageDataModel;

	[Inject]
	public var service : IImageProviderService;

	[Inject]
	public var image : Bitmap;

	public function UnloadImageCommand()
	{
		super();
	}

	override public function execute() : void
	{
		collageDataModel.removeImage(image);

		service.unload(image);
	}
}
}
