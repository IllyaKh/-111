
 
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

-- Initialize variables
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function gotoMenu()
	composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end


local function gotoGame()
	gamePaused = 0
	transition.resume("animationBlock")
	composer.hideOverlay( "fade", 400 )
end



-- create()
function scene:create( event )
  
	local sceneGroup = self.view
	gamePaused = 1
	
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local playButton = display.newText( sceneGroup, "Продовжити", display.contentCenterX, 700, native.systemFont, 44 )
    playButton:setFillColor( 0.75, 0.78, 1 )
 
	local mnButton = display.newText( sceneGroup, "Menu", display.contentCenterX, 810, native.systemFont, 44 )
    mnButton:setFillColor( 0.75, 0.78, 1 )
	

	mnButton:addEventListener( "tap", gotoMenu )
	playButton:addEventListener( "tap", gotoGame )
	scene:addEventListener( "hide", scene )
	end




	
	
-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase
	local parent = event.parent
	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
		parent:resumeGame()
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
