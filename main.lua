
local widget = require( "widget" );
_W, _H = display.viewableContentWidth, display.viewableContentHeight;
display.setDefault( "background", 255, 255, 255 );

local function newBars(dobars, w, h, segcolor, x, y)
    local retBar = {};
    local barSegments = {};
    local newbargroup = display.newGroup();
    local xgap = 2;
    local xinc = w/dobars;
    for i=1,dobars do
        local barSeg = display.newRect((i-1)*xinc, 0, xinc - xgap, 50)
        barSeg.strokeWidth = 0
        barSeg:setFillColor(segcolor[1],  segcolor[2], segcolor[3]);
        barSeg.alpha = 0.1;
        barSegments[i] = barSeg;
        newbargroup:insert(barSeg);
    end
    newbargroup.x = x;
    newbargroup.y = y;
    retBar[1] = newbargroup;
    retBar[2] = barSegments;
    return retBar;
end

local function scaleBar(theseBars, thisPercent)
    local barSegments = theseBars[2];
    local barCount = #barSegments;
    if thisPercent > 100 then thisPercent = 100; end;
    if thisPercent < 0 then thisPercent = 0; end;
    local fullBars = barCount * (thisPercent/100);
    for i=1, barCount do
        if i <= fullBars then
            barSegments[i].alpha = 1;
        else
            barSegments[i].alpha = 0.1;
        end
    end
end

local mybars = newBars(40, _W*0.8, 60, {142, 68, 173}, _W*0.1, _H*0.2);

local function sliderListener( e )
    scaleBar(mybars, e.value);
end

local slider = widget.newSlider
{
    top = _H*0.5,
    left = _W*0.1,
    width = _W*0.7,
    value = 0;
    listener = sliderListener
}
