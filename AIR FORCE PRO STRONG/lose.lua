
local composer = require( "composer" )

local scene = composer.newScene()

local setmuse
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Initialize variables
local sndButtonm
local sndButtonp
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------





local function gotoHS()
    composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

function scene:create( event )
  
	local sceneGroup = self.view
	local sndGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY



	local vicButton = display.newText( sceneGroup, "YOU LOSE!", display.contentCenterX, 200, mainFont, 44 )
	vicButton:setFillColor( 255, 255, 0 )

	timer.performWithDelay( 3000, gotoHS, 1	)

end




	
	
-- show()
function scene:show( event )

	local sceneGroup = self.view
	local sndGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		audio.play( setmuse, { channel=4, loops=-1 } )

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local sndGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
				audio.stop( 4 )
				composer.removeScene( "victory" )
	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	local sndGroup = self.view
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
