--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:d2c1efb32e1f63d9cb1c675a049743ee:3f891151544a0b1a982b5204ce3c866a:f846fd83288d3c85344df998c61585cb$
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
            -- bich
            x=1,
            y=1,
            width=56,
            height=58,

            sourceX = 4,
            sourceY = 6,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- bichu
            x=1,
            y=61,
            width=56,
            height=56,

            sourceX = 4,
            sourceY = 8,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },

    sheetContentWidth = 64,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["bich"] = 1,
    ["bichu"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
