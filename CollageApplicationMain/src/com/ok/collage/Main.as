package com.ok.collage {

import com.ok.collage.config.CollageContext;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

public class Main extends Sprite {

    private var _context : CollageContext;

    public function Main():void
    {
        if (stage)
        {
            init();
        } else
        {
            addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
        }
    }

    private function handleAddedToStage(event : Event) : void
    {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        init();
    }

    private function init() : void
    {
        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        _context = new CollageContext(this);
    }
}
}
