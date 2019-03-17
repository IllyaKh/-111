--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:11fe643326b99fbcacfa7912c116283e:4ad7231641c47382a5418f1ea18623f2:d1b095f17a00e24a143a5b86270a915a$
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
            -- гл(ф)
            x=1,
            y=67,
            width=62,
            height=60,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- гл22(ф)
            x=1,
            y=1,
            width=62,
            height=64,

            sourceX = 0,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
    },

    sheetContentWidth = 64,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["гл(ф)"] = 1,
    ["гл22(ф)"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
