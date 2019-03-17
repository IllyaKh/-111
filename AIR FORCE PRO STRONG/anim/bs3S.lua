--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:c526ad5c7ed5e41c7b26afb8cbc48ffe:37e81a0535dff675d0d05dcafd7e53e3:062ec848d4fe0c69c444db5f9525f552$
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
            -- bich3
            x=1,
            y=1,
            width=62,
            height=54,

            sourceX = 2,
            sourceY = 10,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bich3ua
            x=1,
            y=59,
            width=62,
            height=54,

            sourceX = 2,
            sourceY = 10,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },

    sheetContentWidth = 64,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["bich3"] = 1,
    ["bich3ua"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
