
 
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


	local ccButton = display.newText( sceneGroup, "Сontrols", display.contentCenterX, 200, mainFont, 44 )
	ccButton:setFillColor( 255, 255, 0 )

	local arButton = display.newText( sceneGroup, "Arrows", display.contentCenterX, 350, mainFont, 37 )
	arButton:setFillColor( 255, 255, 0 )
	local crButton = display.newText( sceneGroup, "Touchscreen", display.contentCenterX,450, mainFont, 37 )
	crButton:setFillColor( 255, 255, 0 )
	local acButton = display.newText( sceneGroup, "Accelerometer", display.contentCenterX, 550, mainFont, 37 )
	acButton:setFillColor( 255, 255, 0 )
	local ctrlButton = display.newText( sceneGroup, "Back", display.contentCenterX, 700, mainFont, 44 )
	ctrlButton:setFillColor( 255, 255, 0 )

	arButton:addEventListener( "tap", arCon )
	crButton:addEventListener( "tap", crCon )
	acButton:addEventListener( "tap", acCon )
	ctrlmuse = audio.loadStream( "audio/settings.mp3")
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
