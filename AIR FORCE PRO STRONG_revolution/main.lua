-- Copyright (c) 2017 Corona Labs Inc.
-- Code is MIT licensed and can be re-used; see https://www.coronalabs.com/links/code/license
-- Other assets are licensed by their creators:
--    Art assets by Kenney: http://kenney.nl/assets
--    Music and sound effect assets by Eric Matyas: http://www.soundimage.org

local composer = require( "composer" )
ctrlType = 1
levelEnemy = 1
gamePaused = 1
b1defeat = false
b2defeat = false
-- Hide status bar
display.setStatusBar( display.HiddenStatusBar )


-- Seed the random number generator
math.randomseed( os.time() )
audio.reserveChannels( 1 )
audio.reserveChannels( 2 )
audio.reserveChannels( 3 )
audio.reserveChannels( 4 )
audio.reserveChannels( 5 )
-- Reduce the overall volume of the channel
audio.setVolume( 0.5, { channel=1 } )
audio.setVolume( 0.5, { channel=2 } )
audio.setVolume( 0.5, { channel=3 } )
audio.setVolume( 4, { channel=4 } )
audio.setVolume( 4, { channel=5 } )
-- Go to the menu screen

composer.gotoScene( "menu" )
