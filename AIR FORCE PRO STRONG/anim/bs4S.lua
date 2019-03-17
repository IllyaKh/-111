--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:82c20134aa1c29984a72769cd4d7bc40:f0ec89eb49e74a86414ba24ee3dd9605:4693d41787e295b5de982eba6e39f18e$
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
            -- bich4
            x=1,
            y=1,
            width=64,
            height=62,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- аопоа
            x=1,
            y=65,
            width=64,
            height=56,

            sourceX = 0,
            sourceY = 6,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["bich4"] = 1,
    ["аопоа"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
