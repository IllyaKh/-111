--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:470670c3238ba927ff0bf2a5301de306:6dc8536327c48ad6a80d1cc02d1fd0c2:50c811a0491c5e7fa09601b59aaeae42$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- bich2
            x=1,
            y=59,
            width=50,
            height=56,

            sourceX = 6,
            sourceY = 4,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- вертолет3
            x=1,
            y=1,
            width=52,
            height=56,

            sourceX = 5,
            sourceY = 4,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },

    sheetContentWidth = 64,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["bich2"] = 1,
    ["вертолет3"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
