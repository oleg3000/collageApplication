package com.ok.collage.utils {
import com.ok.collage.utils.models.DisplayObjectTransformation;

import flash.display.DisplayObject;

public class Utils {


	/**
	 * Creates a table to be used for displayObject allocation in collage-style
	 * @param displayObjects - Vector/Array of DisplayObjects
	 * @param areaWidth
	 * @param areaHeight
	 * @return two-dimensional vector of DisplayObjectTransformation
	 */
	public static function fillAreaByDisplayObjects (displayObjects : Vector.<DisplayObject>, areaWidth : Number, areaHeight : Number) : Vector.<Vector.<DisplayObjectTransformation>>
	{
		var proportionsSum : Number = 0;

		displayObjects.forEach(function (image : DisplayObject, ...args) : void{
			proportionsSum += image.width / image.height;
		});

		const stageArea : Number = areaWidth * areaHeight;
		var displayObjectHeight : Number = Math.sqrt(stageArea / proportionsSum);

		var numRows : int = Math.round(areaHeight / displayObjectHeight);

		//Fit height
		displayObjectHeight = areaHeight / numRows;

		var sortedImages : Vector.<DisplayObject> = displayObjects.concat().sort(function (bitmap1 : DisplayObject, bitmap2 : DisplayObject) : int
		{
			return bitmap1.width / bitmap1.height > bitmap2.width / bitmap2.height ? 1 : -1;
		});

		var rowWidths : Vector.<Number> = new Vector.<Number>(numRows);
		var displayObjectsTable : Vector.<Vector.<DisplayObjectTransformation>> = new Vector.<Vector.<DisplayObjectTransformation>>(numRows);

		var shortestRowLength : Number = Number.MAX_VALUE;
		var shortestRowId : Number = 0;

		var maxRowWidth : Number = 0;

		var currentRow : int = 0;

		while (sortedImages.length)
		{
			if (displayObjectsTable[currentRow] == null)
			{
				displayObjectsTable[currentRow] = new Vector.<DisplayObjectTransformation>();
				rowWidths[currentRow] = 0;
			}

			if (rowWidths[currentRow] < shortestRowLength)
			{
				shortestRowLength = rowWidths[currentRow];
				shortestRowId = currentRow;
			}

			if (currentRow + 1 == numRows)
			{
				const displayObject : DisplayObject = sortedImages.pop();
				const transformation : DisplayObjectTransformation = DisplayObjectTransformation.fromDisplayObject(displayObject);
				transformation.targetHeight = displayObjectHeight;
				displayObjectsTable[shortestRowId].push(transformation);
				rowWidths[shortestRowId] += transformation.targetWidth;

				if (rowWidths[shortestRowId] > maxRowWidth)
				{
					maxRowWidth = rowWidths[shortestRowId];
				}

				shortestRowLength = Number.MAX_VALUE;
				shortestRowId = 0;

				currentRow = 0;
			}else{
				currentRow++;
			}
		}

		var additionalScale : Number = 1;


		//Reduce scale to get rid of cropped areas
		if (areaWidth < maxRowWidth)
		{
			additionalScale = areaWidth / maxRowWidth;
			displayObjectsTable.forEach(function (transformations : Vector.<DisplayObjectTransformation>, ...args) : void
			{
				transformations.forEach(function (transformation : DisplayObjectTransformation, ...args) : void
				{
					transformation.targetHeight *= additionalScale;
				});
			});
		}

		return displayObjectsTable
	}

	public static function convertToDisplayObjectsVector(array: *) : Vector.<DisplayObject>
	{
		const result : Vector.<DisplayObject> = new <DisplayObject>[];
		array.forEach(function (element : DisplayObject, ...args)
		{
			result.push(element);
		});
		return result;
	}
}
}
