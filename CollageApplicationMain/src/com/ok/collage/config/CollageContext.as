package com.ok.collage.config {
import com.ok.collage.commands.CreateCollageCommand;
import com.ok.collage.commands.LoadImagesCommand;
import com.ok.collage.commands.UnloadImageCommand;
import com.ok.collage.models.CollageDataModel;
import com.ok.collage.services.ImageLoaderMaxService;
import com.ok.collage.services.interfaces.IImageProviderService;
import com.ok.collage.signals.CreateCollageSignal;
import com.ok.collage.signals.ImageRemovedSignal;
import com.ok.collage.signals.ImagesLoadedSignal;
import com.ok.collage.view.mediators.CollageView;
import com.ok.collage.view.mediators.CollageViewMediator;

import flash.display.DisplayObjectContainer;

import org.robotlegs.base.ContextEvent;

import org.robotlegs.mvcs.SignalContext;

public class CollageContext extends SignalContext {
	public function CollageContext(contextView : DisplayObjectContainer = null, autoStartup : Boolean = true)
	{
		super(contextView, autoStartup);
	}

	override public function startup() : void
	{
		injector.mapSingleton(CreateCollageSignal);
		injector.mapSingleton(CollageDataModel);

		commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadImagesCommand, ContextEvent, true);

		signalCommandMap.mapSignalClass(ImagesLoadedSignal, CreateCollageCommand);
		signalCommandMap.mapSignalClass(ImageRemovedSignal, UnloadImageCommand);

		injector.mapSingletonOf(IImageProviderService, ImageLoaderMaxService);

		mediatorMap.mapView(CollageView, CollageViewMediator);

		contextView.addChild(new CollageView());

		super.startup();
	}
}
}
