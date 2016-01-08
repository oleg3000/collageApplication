package com.ok.collage.commands {

import com.ok.collage.models.CollageDataModel;
import com.ok.collage.signals.CreateCollageSignal;

import flash.display.Bitmap;

import org.robotlegs.mvcs.SignalCommand;

public class CreateCollageCommand extends SignalCommand {

	[Inject]
	public var images : Vector.<Bitmap>;

	[Inject]
	public var collageDataModel : CollageDataModel;

	[Inject]
	public var createCollageSignal : CreateCollageSignal;

	public function CreateCollageCommand()
	{
		super();
	}

	override public function execute() : void
	{
		collageDataModel.addImages(images);
		createCollageSignal.dispatch(images);
	}
}
}
