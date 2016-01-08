package com.ok.collage.commands {
import com.ok.collage.models.ImageEnum;
import com.ok.collage.services.interfaces.IImageProviderService;

import org.robotlegs.mvcs.Command;

public class LoadImagesCommand extends Command {

	[Inject]
	public var service : IImageProviderService;

	public function LoadImagesCommand()
	{
		super();
	}

	override public function execute() : void
	{
		service.loadImages(ImageEnum.FILES_LIST);
	}
}
}
