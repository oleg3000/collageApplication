package com.ok.collage.view.mediators {
import com.ok.collage.models.CollageDataModel;
import com.ok.collage.signals.CreateCollageSignal;
import com.ok.collage.signals.ImageRemovedSignal;

import flash.display.Bitmap;

import org.robotlegs.mvcs.Mediator;

public class CollageViewMediator extends Mediator {
	[Inject]
	public var collageView : CollageView;

	[Inject]
	public var collageDataModel : CollageDataModel;

	//---------------------------------------
	//Signals
	//---------------------------------------

	[Inject]
	public var createCollageSignal : CreateCollageSignal;

	[Inject]
	public var imageRemovedSignal : ImageRemovedSignal;

	//---------------------------------------

	public function CollageViewMediator()
	{
		super();
	}

	[PostConstruct]
	public function init () : void
	{
		collageView.init();
		collageView.removeImageAnimationCompleteSignal.add(handleImageRemoved);
		collageView.stageResizedSignal.add(handleStageResized);
	}

	[PreDestroy]
	public function destroy () : void
	{
		collageView.removeImageAnimationCompleteSignal.remove(handleImageRemoved);
		collageView.stageResizedSignal.remove(handleStageResized);
	}

	override public function onRegister():void
	{
		createCollageSignal.add(handleCollageCreated);
	}

	//---------------------------------------
	//Event handlers
	//---------------------------------------

	private function handleImageRemoved(image : Bitmap) : void
	{
		imageRemovedSignal.dispatch(image);

		collageView.updatePositions(collageDataModel.images);
	}

	private function handleCollageCreated(images : Vector.<Bitmap>) : void
	{
		collageView.addImages(images);
		collageView.updatePositions(images);
	}

	private function handleStageResized() : void
	{
		collageView.updatePositions(collageDataModel.images);
	}
}
}
