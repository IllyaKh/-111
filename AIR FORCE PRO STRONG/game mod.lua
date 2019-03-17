
 
local composer = require( "composer" )

local scene = composer.newScene()

local json = require( "json" )
 
local filePath = system.pathForFile( "leven.json", system.DocumentsDirectory )

local ctrlmuse

curLevelTable = {}
-- -----------------------------------------------------------------------------------

local function gotoMenu()
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end


function ngame()
		score = 0
		tempscore = 0
		levelEnemy = 1
		local file = io.open( filePath, "w" )
		if file then
			file:write( json.encode( levelEnemy ) )
		end
		io.close( file )
		composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function cont()
	if (b1defeat == false and score == 300) then		
		score = 0
	end
	if (b2defeat == false and score == 600) then		
		score = 0
	end
	if (b3defeat == false and score == 900) then		
		score = 0
	end
	if (b4defeat == false and score == 1200) then		
		score = 0
	end
	if (b5defeat == false and score == 1500) then		
		score = 0
	end
	if (b6defeat == false and score == 1800) then		
		score = 0
	end
	if (b7defeat == false and score == 2100) then		
		score = 0
	end
	local file, errorString = io.open( filePath, "r" )
		if not file then
			-- Error occurred; output the cause
			print( "File error: " .. errorString )
		else
			-- Read data from file
			local contents = file:read( "*n" )
			-- Output the file contents
			levelEnemy = contents
			print("levenemy gamod continue:"..levelEnemy)
			-- Close the file handle
			io.close( file )
		end
	composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

function selev()
		lives = 3
		score = 0
		tempscore = 0
		local file, errorString = io.open( filePath, "r" )
		if not file then
			-- Error occurred; output the cause
			print( "File error: " .. errorString )
		else
			-- Read data from file
			local contents = file:read( "*n" )
			-- Output the file contents
			levelEnemy = contents
			print("levenemy gamod continue:"..levelEnemy)
			-- Close the file handle
			io.close( file )
		end
		if (levelEnemy == 2) then
			b1defeat = true
		end
		if (levelEnemy == 3) then
			b1defeat = true
			b2defeat = true
		end
		if (levelEnemy == 4) then
			b1defeat = true
			b2defeat = true
			b3defeat = true
		end
		if (levelEnemy == 5) then
			b1defeat = true
			b2defeat = true
			b3defeat = true
			b4defeat = true
		end
		if (levelEnemy == 6) then
			b1defeat = true
			b2defeat = true
			b3defeat = true
			b4defeat = true
			b5defeat = true
		end
		if (levelEnemy == 7) then
			b1defeat = true
			b2defeat = true
			b3defeat = true
			b4defeat = true
			b5defeat = true
			b6defeat = true
		end
		if (levelEnemy == 8) then
			b1defeat = true
			b2defeat = true
			b3defeat = true
			b4defeat = true
			b5defeat = true
			b6defeat = true
			b7defeat = true
		end
	composer.gotoScene( "levels", { time=800, effect="crossFade" } )
end



-- create()
function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect( sceneGroup, "background.png", 800, 1400 )
	background.x = display.contentCenterX
	background.y = display.contentCenterY
	


	local ngButton = display.newText( sceneGroup, "New Game", display.contentCenterX, 350, mainFont, 37 )
	ngButton:setFillColor( 255, 255, 0 )
	local coButton = display.newText( sceneGroup, "Continue", display.contentCenterX,450, mainFont, 37 )
	coButton:setFillColor( 255, 255, 0 )
	local slButton = display.newText( sceneGroup, "Select Level", display.contentCenterX, 550, mainFont, 37 )
	slButton:setFillColor( 255, 255, 0 )
	local mnButton = display.newText( sceneGroup, "Back", display.contentCenterX, 700, mainFont, 44 )
	mnButton:setFillColor( 255, 255, 0 )

	ngButton:addEventListener( "tap", ngame )
	coButton:addEventListener( "tap", cont )
	slButton:addEventListener( "tap", selev )
	ctrlmuse = audio.loadStream( "audio/settings.mp3")
	mnButton:addEventListener( "tap", gotoMenu )
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
				composer.removeScene( "game mod" )
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
