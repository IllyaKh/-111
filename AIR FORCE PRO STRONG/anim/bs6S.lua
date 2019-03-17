--
-- created with TexturePacker - https://www.codeandweb.com/texturepacker
--
-- $TexturePacker:SmartUpdate:1f4176e189b38067ec6680e6ee46726f:ff84886cedd1d9a8501809349d44765c:b02ba9455066b36f290e028c9fa35581$
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
            -- 22)
            x=1,
            y=65,
            width=58,
            height=62,

            sourceX = 2,
            sourceY = 0,
            sourceWidth = 64,
            sourceHeight = 64
        },
        {
            -- 123(4)
            x=1,
            y=1,
            width=58,
            height=62,

            sourceX = 2,
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

    ["22)"] = 1,
    ["123(4)"] = 2,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
