package com.ok.collage.view.mediators {
import com.greensock.TweenMax;
import com.ok.collage.utils.Utils;
import com.ok.collage.utils.models.DisplayObjectTransformation;

import flash.display.Bitmap;

import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.osflash.signals.Signal;

public class CollageView extends Sprite {
	private const REMOVE_TWEEN_DURATION : Number = .25;
	private const UPDATE_LOCATION_TWEEN_DURATION : Number = .5;

	public var removeImageAnimationCompleteSignal : Signal = new Signal(Bitmap);
	public var stageResizedSignal : Signal = new Signal();

	public function CollageView()
	{
		super();
	}

	public function init() : void
	{
		addEventListener(MouseEvent.CLICK, handleImageClicked);
		addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);

		stage.addEventListener(Event.RESIZE, handleStageResize);
	}

	public function addImages(images : Vector.<Bitmap>) : void
	{
		images.forEach(function (image : Bitmap, ...args) : void
		{
			addChild(image);
		})
	}

	public function removeImage(image : Bitmap) : void
	{
		TweenMax.to(image, REMOVE_TWEEN_DURATION, {
			alpha: 0,
			onComplete: imagesHiddenHandler, onCompleteParams: [image]
		})
	}

	public function updatePositions(images : Vector.<Bitmap>) : void
	{
		var transformations : Vector.<Vector.<DisplayObjectTransformation>> =
				Utils.fillAreaByDisplayObjects(Utils.convertToDisplayObjectsVector(images), stage.stageWidth, stage.stageHeight);

		var rowYPosition = 0;

		for (var i : int = 0; i < transformations.length; i++)
		{
			var row : Vector.<DisplayObjectTransformation> = transformations[i];

			var rowXPosition = 0;

			for (var j : int = 0; j < row.length; j++)
			{
				var transformation : DisplayObjectTransformation = row[j];
				TweenMax.to(transformation.displayObject, UPDATE_LOCATION_TWEEN_DURATION,
						{
							width: transformation.targetWidth, height: transformation.targetHeight,
							x: rowXPosition, y: rowYPosition
						});

				rowXPosition += transformation.targetWidth;
			}

			rowYPosition += transformation.targetHeight;
		}

	}

	//---------------------------------------
	//Event handlers
	//---------------------------------------

	private function imagesHiddenHandler(image : Bitmap) : void
	{
		removeChild(image);
		removeImageAnimationCompleteSignal.dispatch(image);
		addEventListener(MouseEvent.CLICK, handleImageClicked);
	}

	private function handleImageClicked(event : MouseEvent) : void
	{
		removeEventListener(MouseEvent.CLICK, handleImageClicked);

		var bitmap : Bitmap = stage.getObjectsUnderPoint(new Point(event.stageX, event.stageY))[0] as Bitmap;
		removeImage(bitmap);
	}

	private function handleStageResize(event : Event) : void
	{
		stageResizedSignal.dispatch();
	}

	private function handleRemovedFromStage(event : Event) : void
	{
		removeEventListener(MouseEvent.CLICK, handleImageClicked);
		removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
		removeEventListener(Event.RESIZE, handleStageResize);
	}
}

}

