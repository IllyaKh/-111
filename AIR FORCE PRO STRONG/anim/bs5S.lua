--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:12104cfec379e8757038ddcc3c452361:3c3bb84e18e3a5058f2d7c2d56163d04:c3b7ccdb65df0358a1abed92d540029d$
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
            -- bich5
            x=1,
            y=63,
            width=67,
            height=56,

            sourceX = 0,
            sourceY = 3,
            sourceWidth = 71,
            sourceHeight = 62
        },
        {
            -- бббд
            x=1,
            y=1,
            width=67,
            height=60,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 71,
            sourceHeight = 62
        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["bich5"] = 1,
    ["бббд"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
