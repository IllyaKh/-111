
 
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

function filev()
	levelEnemy = 1
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function selev()
	levelEnemy = 2
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function thlev()
	levelEnemy = 3
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function folev()
	levelEnemy = 4
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function fivlev()
	levelEnemy = 5
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function silev()
	levelEnemy = 6
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function sevlev()
	levelEnemy = 7
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function eilev()
	levelEnemy = 8
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

local function gotoMenu()
	composer.gotoScene( "menu", { time=800, effect="crossFade" } )
end
-- create()
function scene:create( event )
  
	local sceneGroup = self.view
	local sndGroup = self.view
	
	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local chLevel = display.newText( sceneGroup, "Choose level", display.contentCenterX, 100, mainFont, 37 )
	chLevel:setFillColor( 255, 255, 0 )
	
	local fiButton = display.newText( sceneGroup, "1. Return to castle", display.contentCenterX, 200, mainFont, 25 )
	fiButton:setFillColor( 255,255, 0 )
	
	local seButton = display.newText( sceneGroup, "2. New friends", display.contentCenterX, 270, mainFont, 25 )
	seButton:setFillColor( 255,255, 0 )

	local thButton = display.newText( sceneGroup, "3. Nice choise, pilot", display.contentCenterX, 340, mainFont, 25 )
	thButton:setFillColor( 255,255, 0 )
	
	local foButton = display.newText( sceneGroup, "4. Peanuts for you", display.contentCenterX, 410, mainFont, 25 )
	foButton:setFillColor( 255,255, 0 )
	
	local fivButton = display.newText( sceneGroup, "5. Rocks in your heart", display.contentCenterX, 480, mainFont, 25 )
	fivButton:setFillColor( 255,255, 0 )

	local siButton = display.newText( sceneGroup, "6. Out of ammo", display.contentCenterX, 550, mainFont, 25 )
	siButton:setFillColor( 255,255, 0 )
	
	local sevButton = display.newText( sceneGroup, "7. Dangerous cage", display.contentCenterX, 620, mainFont, 25 )
	sevButton:setFillColor( 255,255, 0 )
	
	local eiButton = display.newText( sceneGroup, "8. Infinity Pain", display.contentCenterX, 690, mainFont, 25 )
	eiButton:setFillColor( 255,255, 0 )
	
	local mnButton = display.newText( sceneGroup, "Back", display.contentCenterX, 790, mainFont, 37 )
    mnButton:setFillColor( 255, 255, 0 )

	ctrlmuse = audio.loadStream( "audio/settings.mp3")
	fiButton:addEventListener( "tap", filev )
		seButton:addEventListener( "tap", selev )
		thButton:addEventListener( "tap", thlev )
		foButton:addEventListener( "tap", folev )
		fivButton:addEventListener( "tap", fivlev )
		siButton:addEventListener( "tap", silev )
		sevButton:addEventListener( "tap", sevlev )
		eiButton:addEventListener( "tap", eilev )
	mnButton:addEventListener("tap", gotoMenu)
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
