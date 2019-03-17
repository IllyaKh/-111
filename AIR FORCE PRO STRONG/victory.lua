
local composer = require( "composer" )

local scene = composer.newScene()

local setmuse

local json = require( "json" )
 
local filePath = system.pathForFile( "leven.json", system.DocumentsDirectory )
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



local function gotoGame()
		local file, errorString = io.open( filePath, "r" )
		if not file then
			-- Error occurred; output the cause
			print( "File error: " .. errorString )
		else
			-- Read data from file
			local contents = file:read( "*a" )
			-- Output the file contents
			LevelEnemy = json.decode(contents)
			-- Close the file handle
			io.close( file )
		end
	tempscore = score
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoMenu()
    composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end


-- create()
function scene:create( event )
  
	local sceneGroup = self.view
	local sndGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY



	local vicButton = display.newText( sceneGroup, "VICTORY", display.contentCenterX, 200, mainFont, 44 )
	vicButton:setFillColor( 255, 255, 0 )

	local mnButton = display.newText( sceneGroup, "Menu", display.contentCenterX, 540, mainFont, 44 )
	mnButton:setFillColor( 255, 255, 0 )



	local coButton = display.newText( sceneGroup, "Continue", display.contentCenterX, 450, mainFont, 44 )
	coButton:setFillColor( 255, 255, 0 )

	setmuse = audio.loadStream( "audio/settings.mp3")
	mnButton:addEventListener( "tap", gotoMenu )
	coButton:addEventListener( "tap", gotoGame	)

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
