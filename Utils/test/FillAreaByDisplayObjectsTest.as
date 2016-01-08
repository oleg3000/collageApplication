package {
import com.ok.collage.utils.Utils;
import com.ok.collage.utils.models.DisplayObjectTransformation;

import flash.display.DisplayObject;
import flash.display.Sprite;

import org.flexunit.assertThat;
import org.hamcrest.number.lessThanOrEqualTo;

public class FillAreaByDisplayObjectsTest {

	private var _displayObjects : Vector.<DisplayObject>;
	private var _areaWidth : int;
	private var _areaHeight : int;

	[Before]
	public function setup():void
	{
		_displayObjects = new <DisplayObject>[	mockDisplayObject(50, 50),
												mockDisplayObject(100, 50),
												mockDisplayObject(50, 100),
												mockDisplayObject(75, 75),
												mockDisplayObject(25, 25),
												mockDisplayObject(30, 30),
												mockDisplayObject(555, 777)	];

		_areaWidth = 640;
		_areaHeight = 480;
	}
	private function mockDisplayObject (width : Number, height : Number) : DisplayObject
	{
		var sprite : Sprite = new Sprite ();
		sprite.graphics.drawRect(0, 0, width, height);
		return sprite;
	}

	[Test]
	public function testResultedObjectsAreInsideSpecifiedArea():void
	{
		var result : Vector.<Vector.<DisplayObjectTransformation>> = Utils.fillAreaByDisplayObjects(_displayObjects, _areaWidth, _areaHeight);
		var maxRowWidth : Number = 0;
		var maxRowHeight : Number = 0;
		for each (var row : Vector.<DisplayObjectTransformation> in result)
		{
			var rowWidth : Number;
			var rowHeight : Number;

			for each (var transformation : DisplayObjectTransformation in row)
			{
				rowWidth += transformation.targetWidth;
				rowHeight += transformation.targetHeight;
			}

			if (maxRowWidth > rowWidth)
			{
				maxRowWidth = rowWidth
			}

			if (maxRowHeight > rowHeight)
			{
				maxRowHeight = rowHeight
			}
		}

		assertThat(maxRowWidth, lessThanOrEqualTo(_areaWidth));
		assertThat(maxRowHeight, lessThanOrEqualTo(_areaHeight));
	}
}
}
