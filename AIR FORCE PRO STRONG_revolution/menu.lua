 mainFont = "/fonts/8bit_font.ttf"
local composer = require( "composer" )

local scene = composer.newScene()
local menuSound
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function gotoLevels()
	composer.gotoScene( "levels", { time=800, effect="crossFade" } )
end

local function gotoHighScores()
	composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
end

local function gotoSettings()
	composer.gotoScene( "settings", { time=800, effect="crossFade" } )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	local background = display.newImageRect( sceneGroup, "background.png", display.contentWidth, display.contentHeight )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local title = display.newImageRect( sceneGroup, "title.png", 500, 80 )
	title.x = display.contentCenterX
	title.y = 200
	local title_pro = display.newImageRect( sceneGroup, "title_pro.png", 150, 60 )
	title_pro.x = display.contentCenterX + 200
	title_pro.y = 270

	local playButton = display.newText( sceneGroup, "Play game", display.contentCenterX, 360, mainFont, 35 )
	playButton:setFillColor( 255, 255, 0 )
	
	local ctrlButton = display.newText( sceneGroup, "Settings", display.contentCenterX, 450,mainFont, 35 )
	ctrlButton:setFillColor( 255, 255, 0 )

	local highScoresButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 540, mainFont , 35 )
	highScoresButton:setFillColor( 255, 255, 0 )

	playButton:addEventListener( "tap", gotoLevels )
	highScoresButton:addEventListener( "tap", gotoHighScores )
	ctrlButton:addEventListener( "tap", gotoSettings )
	menuSound = audio.loadStream( "audio/Escape_Looping.wav")
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
	audio.play( menuSound, { channel=2, loops=-1 } )
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
		audio.stop( 2 )

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
