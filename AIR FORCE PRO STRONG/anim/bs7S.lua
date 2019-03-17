--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:bb878a267d0933a8ec709e2079f8e567:ab8fc9a1280acbe9bb9cd080534f64db:e9507aa73171d468e83ec12707c02c97$
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
            -- 222(1)
            x=1,
            y=1,
            width=67,
            height=57,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 75,
            sourceHeight = 75
        },
        {
            -- 22222(1)
            x=1,
            y=60,
            width=67,
            height=57,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 75,
            sourceHeight = 75
        },
    },

    sheetContentWidth = 128,
    sheetContentHeight = 128
}

SheetInfo.frameIndex =
{

    ["222(1)"] = 1,
    ["22222(1)"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
