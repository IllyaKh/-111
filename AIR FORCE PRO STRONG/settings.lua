
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



local function gotoCtrl()
	composer.gotoScene( "control", { time=800, effect="crossFade" } )
end

local function gotoMenu()
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end

function sndlvlp()
		sndButtonm.isVisible = true
		sndButtonm.isBodyActive = true
		sndButtonp.isVisible = false
		sndButtonp.isBodyActive = false
audio.setVolume( 0 )
end

function sndlvlm()
		sndButtonm.isVisible = false
		sndButtonm.isBodyActive = false
		sndButtonp.isVisible = true
		sndButtonp.isBodyActive = true
audio.setVolume( 0.5 )
end
-- create()
function scene:create( event )
  
	local sceneGroup = self.view
	local sndGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY


	
	sndButtonm = display.newImageRect(sndGroup, "soundoff.png", 250, 60 )
	sndButtonm.x = display.contentCenterX
	sndButtonm.y = 300
	
	sndButtonp = display.newImageRect(sndGroup, "soundon.png", 230, 60  )
	sndButtonp.x = display.contentCenterX
	sndButtonp.y = 300
	
	if (audio.getVolume()~=0) then
	sndButtonm.isVisible = false
	sndButtonm.isBodyActive = false
	sndButtonp.isVisible = true
	sndButtonp.isBodyActive = true
	end 
	
	if (audio.getVolume()==0) then
	sndButtonm.isVisible = true
	sndButtonm.isBodyActive = true
	sndButtonp.isVisible = false
	sndButtonp.isBodyActive = false
	end



	local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
	title.x = display.contentCenterX
	title.y = 200

	local mnButton = display.newText( sceneGroup, "Back", display.contentCenterX, 540, mainFont, 44 )
	mnButton:setFillColor( 255, 255, 0 )



	local ctrlButton = display.newText( sceneGroup, "Control", display.contentCenterX, 450, mainFont, 44 )
	ctrlButton:setFillColor( 255, 255, 0 )

	setmuse = audio.loadStream( "audio/settings.mp3")
	mnButton:addEventListener( "tap", gotoMenu )
	sndButtonp:addEventListener( "tap", sndlvlp )
	sndButtonm:addEventListener( "tap", sndlvlm )
	ctrlButton:addEventListener( "tap", gotoCtrl )

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
				composer.removeScene( "settings" )
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
