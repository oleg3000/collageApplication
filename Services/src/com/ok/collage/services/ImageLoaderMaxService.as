package com.ok.collage.services {
import com.greensock.events.LoaderEvent;
import com.greensock.loading.ImageLoader;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.display.ContentDisplay;
import com.ok.collage.services.interfaces.IImageProviderService;
import com.ok.collage.signals.ImagesLoadedSignal;

import flash.display.Bitmap;

public class ImageLoaderMaxService implements IImageProviderService{

	private const QUEUE_IDENTIFIER : String = "mainQueue";

	private var queue : LoaderMax;

	//---------------------------------------
	//Signals
	//---------------------------------------

	[Inject]
	public var imagesLoadedSignal: ImagesLoadedSignal;

	public function ImageLoaderMaxService()
	{
		init();
	}

	public function init () : void
	{
		queue = new LoaderMax({name: QUEUE_IDENTIFIER, onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
	}

	public function loadImages(urls : Vector.<String>) : void
	{
		urls.forEach(function (url : String, ...args) : void
		{
			queue.append(new ImageLoader(url));
		});
		queue.load();
	}

	public function unload(image : Bitmap) : void
	{
		var contentDisplay : ContentDisplay = getContentDisplayByData(image);
		queue.getLoader(contentDisplay.name).unload();
	}

	private function getContentDisplayByData(data : Object) : ContentDisplay
	{
		var result : ContentDisplay;

		(queue.content as Array).forEach(function (element : ContentDisplay, ...args) : void
		{
			if (element.rawContent == data)
			{
				result = element;
			}
		});

		return result;
	}


	//---------------------------------------
	//Event handlers
	//---------------------------------------

	private function progressHandler(event : LoaderEvent) : void
	{
		trace("progress: " + event.target.progress);
	}

	private function completeHandler(event : LoaderEvent) : void
	{
		trace(event.target + " is complete!");

		var images : Vector.<Bitmap> = new <Bitmap>[];
		(queue.content as Array).forEach(function (element : ContentDisplay, ...args) : void
		{
			images.push(element.rawContent);
		});

		imagesLoadedSignal.dispatch(images);
	}

	private function errorHandler(event : LoaderEvent) : void
	{
		trace("error occured with " + event.target + ": " + event.text);
	}
}
}
