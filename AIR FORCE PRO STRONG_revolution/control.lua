
 
local composer = require( "composer" )

local scene = composer.newScene()

local ctrlmuse
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Initialize variables
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function gotoSettings()
	composer.gotoScene( "settings", { time=800, effect="crossFade" } )
end


function arCon()
	ctrlType = 1
	composer.gotoScene( "settings", { time=800, effect="crossFade" } )
end

function crCon()
	ctrlType = 2
	composer.gotoScene( "settings", { time=800, effect="crossFade" } )
end

function acCon()
	ctrlType = 3
	composer.gotoScene( "settings", { time=800, effect="crossFade" } )
end



-- create()
function scene:create( event )
  
	local sceneGroup = self.view
	local sndGroup = self.view
	
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local arButton = display.newImageRect(sceneGroup, "arrows.png", 250,250)
	arButton.x = display.contentCenterX
	arButton.y = 180
 
	local crButton = display.newImageRect(sceneGroup, "cursor.png", 250,250)
	crButton.x = display.contentCenterX
	crButton.y = 450
	
	local acButton = display.newImageRect(sceneGroup, "screen.png", 150,250)
	acButton.x = display.contentCenterX
	acButton.y = 700

	
	local ctrlButton = display.newText( sceneGroup, "Back", display.contentCenterX, 900, native.systemFont, 44 )
    ctrlButton:setFillColor( 0, 0, 0 )

	arButton:addEventListener( "tap", arCon )
	crButton:addEventListener( "tap", crCon )
	acButton:addEventListener( "tap", acCon )
	ctrlmuse = audio.loadStream( "audio/ctrlsound.wav")
	ctrlButton:addEventListener( "tap", gotoSettings )
end




	
	
-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
				audio.play( ctrlmuse, { channel=5, loops=-1 } )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
					audio.stop( 5 )
				composer.removeScene( "control" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
