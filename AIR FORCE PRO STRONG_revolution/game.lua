
local composer = require( "composer" )

local scene = composer.newScene()


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )
system.setAccelerometerInterval( 60)
-- Configure image sheet
local sheetOptions =
{
	frames =
	{
		{   -- 1) asteroid 1
			x = 0,
			y = 0,
			width = 102,
			height = 85
		},
		{   -- 2) asteroid 2
			x = 0,
			y = 85,
			width = 90,
			height = 83
		},
		{   -- 3) asteroid 3
			x = 0,
			y = 168,
			width = 100,
			height = 97
		},
		{   -- 4) ship
			x = 0,
			y = 265,
			width = 98,
			height = 79
		},
		{   -- 5) laser
			x = 98,
			y = 265,
			width = 14,
			height = 40
		},
	},
}
local objectSheet = graphics.newImageSheet( "gameObjects.png", sheetOptions )

-- Initialize variables

local intervalShip=60
local bdirection = 1
local lives = 3
local b1lives = 10
local bactive = false
local bs1S
local score = 0
local died = false
local enemyShips = {}
local shootEnemyShips = {}
local whoCanShoot = {}
local enemyBullets = {}
local isInvisible = false
local shootEnemySpeed = 10
local isShield = false
local velocityEnemy = 100
local enemyFireTimer
local bTimer
local enemyTable = {}

local ship
local gameLoopTimer
local bfLoopTimer
local bmLoopTimer
local livesText
local scoreText


local backGroup
local mainGroup
local uiGroup

local explosionSound
local fireSound
local musicTrack
local speed = 30

local function updateText()
	livesText.text = "Lives: " .. lives
	scoreText.text = "Score: " .. score
end
function scene:resumeGame()
	--code to resume game
end

local options = {
	isModal = true,
	effect = "fade",
	time = 400,
	params = {
		sampleVar = "my sample variable"
	}
}
local function gotoPause()
	transition.pause("animationBlock")
	composer.showOverlay("pause",options)
end

function sleep(ms)
	local b = os.clock()*1000
	while os.clock()*1000-b <= ms do end
end

function create1BS()

	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs1S, { y=200, time=2000,
			onComplete = function()
			end
		} )
		bactive = true
end

function bMove()
	if (bactive == true) then
		bdirection= bdirection+1
		if (math.fmod(bdirection, 2) == 0) then
			transition.to( bs1S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
				end
			} )	
			else
			transition.to( bs1S, { x=200, time=2000,
				onComplete = function()
				end
			} )	
		end
	end
end

function bFire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local tempBossBullet = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( tempBossBullet, "dynamic", { isSensor=true } )
				tempBossBullet.isBullet = true
				tempBossBullet.myName = "enemyBullet"
				tempBossBullet.x = bs1S.x
				tempBossBullet.y = bs1S.y
					transition.to( tempBossBullet, { y = (display.contentHeight+300) , time=2000,
					onComplete = function() display.remove( tempBossBullet ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function bLoop()
	bFire()
	bMove()
end

local function createEnemyShip()
	if (bactive == false) then
		newEnemy = display.newImageRect( mainGroup,"putin.png", 102, 85 )
		table.insert( enemyTable, newEnemy )
		physics.addBody( newEnemy, "dynamic", { radius=40, bounce = 10 } )
		newEnemy.myName = "asteroid"
		table.insert( shootEnemyShips, newEnemy )

		if ( levelEnemy == 1) then


			for i= 0 ,levelEnemy do

				newEnemy.x = math.random( display.contentWidth )
				newEnemy.y =-100
				newEnemy:setLinearVelocity( 0, velocityEnemy )

				end

		elseif ( levelEnemy == 2) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			newEnemy:setLinearVelocity( 0, velocityEnemy )
		elseif ( levelEnemy == 3) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			newEnemy:setLinearVelocity( 0, velocityEnemy )
		elseif ( levelEnemy == 4) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			newEnemy:setLinearVelocity( 0, velocityEnemy )

		end
	end
end
function levelComplete()
	sleep(10000)
end

function fireEnemyBullet()
	if (gamePaused == 0 ) then
		if(#shootEnemyShips > 0) then
			local randomIndex = math.random(#shootEnemyShips)
			local randomEnemy = shootEnemyShips[randomIndex]
			
			local tempEnemyBullet = display.newImageRect( mainGroup, "laser.png", 40 , 70 )
			physics.addBody( tempEnemyBullet, "dynamic", { isSensor=true } )
			tempEnemyBullet.isBullet = true
			tempEnemyBullet.myName = "enemyBullet"
			tempEnemyBullet.x = randomEnemy.x
			tempEnemyBullet.y = randomEnemy.y
				transition.to( tempEnemyBullet, { y= (display.contentWidth+300), time=1000,
				onComplete = function() display.remove( tempEnemyBullet ) end,tag = "animationBlock"
			} )
		end
	end
end
	local function fireLaser()
		audio.play( fireSound )
		local newLaser = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
		physics.addBody( newLaser, "dynamic", { isSensor=true } )
		newLaser.isBullet = true
		newLaser.myName = "laser"

		newLaser.x = ship.x-20
		newLaser.y = ship.y
		transition.to( newLaser, { y=-40, time=800,
			onComplete = function() display.remove( newLaser ) end,tag = "animationBlock"
		} )
		local newLaser1 = display.newImageRect( mainGroup, objectSheet, 5, 14, 40 )
		physics.addBody( newLaser1, "dynamic", { isSensor=true } )
		newLaser1.isBullet = true
		newLaser1.myName = "laser"

		newLaser1.x = ship.x+20
		newLaser1.y = ship.y
		transition.to( newLaser1, { y=-40, time=800,
			onComplete = function() display.remove( newLaser1 ) end,tag = "animationBlock"
		} )
	end


	local function moveRight( event )
		if (died == false) then
			if(ship.x < 0 or ship.x== 0 ) then
				ship.x = 0

			elseif(ship.x > display.contentWidth or ship.x == display.contentWidth) then
				ship.x = display.width

			end
			ship.x = ship.x+speed

		end
	end

	local function moveLeft( event )
		if (died == false) then
			if(ship.x < 0 or ship.x== 0 ) then
				ship.x = 0

			elseif(ship.x > display.contentWidth or ship.x == display.contentWidth) then
				ship.x = display.width

			end
			ship.x = ship.x-speed
		end
	end

	local function dragShip( event )

		local ship = event.target
		local phase = event.phase

		if ( "began" == phase ) then
			-- Set touch focus on the ship
			display.currentStage:setFocus( ship )
			-- Store initial offset position
			ship.touchOffsetX = event.x - ship.x

		elseif ( "moved" == phase ) then
			-- Move the ship to the new touch position
			ship.x = event.x - ship.touchOffsetX

		elseif ( "ended" == phase or "cancelled" == phase ) then
			-- Release touch focus on the ship
			display.currentStage:setFocus( nil )
		end

		return true  -- Prevents touch propagation to underlying objects
	end

	local function accel( event )
		if (died==false) then
			ship.x = ship.x + event.xGravity*10
			if ship.x > display.contentWidth then
				ship.x = display.contentWidth
			end
			if ship.x < 0 then
				ship.x = 0
			end
		end
	end


	local function gameLoop()

		-- Create new asteroid
		if (gamePaused == 0 ) then
			createEnemyShip()
			if (died==false) then
				fireLaser()
			end
			-- Remove asteroids which have drifted off screen
			for i = #enemyTable, 1, -1 do
				local thisAsteroid = enemyTable[i]

				if ( thisAsteroid.x < -100 or
						thisAsteroid.x > display.contentWidth + 100 or
						thisAsteroid.y < -100 or
						thisAsteroid.y > display.contentHeight + 100 )
				then
					display.remove( thisAsteroid )
					table.remove( enemyTable, i )
				end
			end
		end
	end


	local function restoreShip()

		ship.isBodyActive = false
		ship.x = display.contentCenterX
		ship.y = display.contentHeight - 100

		-- Fade in the ship
		transition.to( ship, { alpha=1, time=500,
			onComplete = function()
				ship.isBodyActive = true
				died = false
			end
		} )
	end


	local function endGameLoose()
		composer.setVariable( "finalScore", score )
		composer.gotoScene( "highscores", { time=800, effect="crossFade" } )
	end
	
	local function endGameWin()
		b1defeat = true
		composer.gotoScene( "levels", { time=800, effect="crossFade" } )
	end


	local function onCollision( event )
		if (gamePaused == 0 ) then
			if ( event.phase == "began" ) then

				local obj1 = event.object1
				local obj2 = event.object2
				if ( ( obj1.myName == "laser" and obj2.myName == "asteroid" ) or
						( obj1.myName == "asteroid" and obj2.myName == "laser" ) )
				then
					-- Remove both the laser and asteroid
					display.remove( obj1 )
					display.remove( obj2 )
					audio.play( explosionSound )
					for i = #enemyTable, 1, -1 do
						if ( enemyTable[i] == obj1 or enemyTable[i] == obj2 ) then
							table.remove( enemyTable, i )
							break
						end
					end
					-- Increase score
					score = score + 50
					scoreText.text = "Score: " .. score
					if (levelEnemy == 1) then
						if (score == 300) then
							create1BS()
						end
					end
				end
				if ( ( obj1.myName == "ship" and obj2.myName == "asteroid" ) or
						( obj1.myName == "asteroid" and obj2.myName == "ship" ) or
						( obj1.myName == "ship" and obj2.myName == "enemyBullet") or
							( obj1.myName == "enemyBullet" and obj2.myName == "ship"))
				then
					if ( died == false ) then
						died = true
						audio.play( explosionSound )
						-- Update lives
						lives = lives - 1
						display.remove( hb )
                        if(lives == 3) then
                            hb = display.newImageRect( uiGroup, "imgcontent/hp1.png", 200, 200 )
                            hb.x = 190
                            hb.y = 80
                        elseif(lives == 2) then
                            hb = display.newImageRect( uiGroup, "imgcontent/hp2.png", 200, 200 )
                            hb.x = 190
                            hb.y = 80
                        elseif(lives == 1) then
                             hb = display.newImageRect( uiGroup, "imgcontent/hp3.png", 200, 200 )
                            hb.x = 190
                            hb.y = 80

						end
						if ( lives == 0 ) then
							display.remove( ship )
							timer.performWithDelay( 2000, endGameLoose )
						else
							ship.alpha = 0
							timer.performWithDelay( 1000, restoreShip )
						end
					end
				end
				if( (obj1.myName == "laser" and obj2.myName == "boss") or
				( obj1.myName == "boss" and obj2.myName == "laser")) then
					audio.play( explosionSound )
					b1lives = b1lives - 1
					display.remove( laser )
					if ( b1lives == 0 or b1lives<0 ) then
						display.remove( bs1S )
						timer.performWithDelay( 2000, endGameWin )
					end
				end
			end
		end
	end



	-- -----------------------------------------------------------------------------------
	-- Scene event functions
	-- -----------------------------------------------------------------------------------

	-- create()
	function scene:create( event )

		local sceneGroup = self.view
		-- Code here runs when the scene is first created but has not yet appeared on screen

		physics.pause()  -- Temporarily pause the physics engine
		gamePaused = 0
		-- Set up display groups
		backGroup = display.newGroup()  -- Display group for the background image
		sceneGroup:insert( backGroup )  -- Insert into the scene's view group

		mainGroup = display.newGroup()  -- Display group for the ship, asteroids, lasers, etc.
		sceneGroup:insert( mainGroup )  -- Insert into the scene's view group

		uiGroup = display.newGroup()    -- Display group for UI objects like the score
		sceneGroup:insert( uiGroup )    -- Insert into the scene's view group

		-- Load the background
		local bg1
		local bg2
		local runtime = 0
		local scrollSpeed = 1.4
		local function addScrollableBg()
			local bgImage = { type="image", filename="background.png" }

			-- Add First bg image
			bg1 = display.newRect(backGroup,0, 0, display.contentWidth, display.actualContentHeight)
			bg1.fill = bgImage
			bg1.x = display.contentCenterX
			bg1.y = display.contentCenterY

			-- Add Second bg image
			bg2 = display.newRect(backGroup,0, 0, display.contentWidth, display.actualContentHeight)
			bg2.fill = bgImage
			bg2.x = display.contentCenterX
			bg2.y = display.contentCenterY - display.actualContentHeight
		end

		local function moveBg(dt)
			if (bg1.y ~= nil and bg2.y ~= nil) then
				bg1.y = bg1.y + scrollSpeed * dt
				bg2.y = bg2.y + scrollSpeed * dt
				if (bg1.y - display.contentHeight/2) > display.actualContentHeight then
					bg1:translate(0, -bg1.contentHeight * 2)
				end
				if (bg2.y - display.contentHeight/2) > display.actualContentHeight then
					bg2:translate(0, -bg2.contentHeight * 2)
				end
			end
		end

		local function getDeltaTime()
			local temp = system.getTimer()
			local dt = (temp-runtime) / (1000/60)
			runtime = temp
			return dt
		end

		local function enterFrame()
			local dt = getDeltaTime()
			moveBg(dt)
		end
		function init()
			addScrollableBg()
			Runtime:addEventListener("enterFrame", enterFrame)
		end
		init()
		if (ctrlType == 1) then
			local rarr = display.newImageRect(mainGroup,"arrowright.png",80,80)
			rarr.x = display.contentCenterX+225
			rarr.y = 950
			physics.addBody( rarr, "dynamic", { isSensor=true } )

			local larr = display.newImageRect(mainGroup,"arrowleft.png",80,80)
			larr.x = display.contentCenterX-225
			larr.y = 950
			physics.addBody( larr, "dynamic", { isSensor=true } )
			rarr:addEventListener("touch", moveRight)
			larr:addEventListener("touch", moveLeft)
		end

		local pauseButton = display.newImageRect(mainGroup,"stop.png",50,50)
		pauseButton.x = display.contentWidth-130
		pauseButton.y = 37

		ship = display.newImageRect( sceneGroup, "blacok.png", 128, 128 )
		ship.x = display.contentCenterX
		ship.y = display.contentHeight - 100
		physics.addBody( ship, { radius=60, isSensor=true } )
		ship.myName = "ship"
		
		bs1S = display.newImageRect( mainGroup, "bich.png", 256, 256 )
		physics.addBody( bs1S, "dynamic", { radius=120, bounce = 10 } )
		bs1S.myName = "boss"
		bs1S.x = display.contentCenterX
		bs1S.y = - 300

		-- Display lives and score
         hb = display.newImageRect( uiGroup, "imgcontent/hp1.png", 200,200 )
            hb.x = 190
            hb.y = 80

		scoreText = display.newText( uiGroup, "Score:" .. score, 340, 35, mainFont, 20 )
        scoreText:setFillColor(255,255,0)
		explosionSound = audio.loadSound( "audio/explosion.wav" )
		fireSound = audio.loadSound( "audio/fire.wav" )
		musicTrack = audio.loadStream( "audio/main_track.mp3")

		if (ctrlType == 2) then
			ship:addEventListener( "touch", dragShip )
		end
		if (ctrlType == 3) then
			if (gamePaused == 0) then
				Runtime:addEventListener( "accelerometer", accel )
			end
		end
		pauseButton:addEventListener("touch", gotoPause)
	end


	-- show()
	function scene:show( event )


		local sceneGroup = self.view
		local phase = event.phase

		if ( phase == "will" ) then
			-- Code here runs when the scene is still off screen (but is about to come on screen)
		elseif ( phase == "did" ) then
			-- Code here runs when the scene is entirely on screen
			physics.start()
			Runtime:addEventListener( "collision", onCollision )
			gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
			bfLoopTimer = timer.performWithDelay( 1500, bFire, 0 )
			bmLoopTimer = timer.performWithDelay( 4000, bMove, 0 )
			audio.play( musicTrack, { channel=1, loops=-1 } )
	--		Runtime:addEventListener( "collision", onCollision )
			if (bactive == false) then
				enemyFireTimer = timer.performWithDelay(750, fireEnemyBullet, 0)
			end
		end
	end


	-- hide()
	function scene:hide( event )

		local sceneGroup = self.view
		local phase = event.phase

		if ( phase == "will" ) then
			-- Code here runs when the scene is on screen (but is about to go off screen)
			timer.cancel( gameLoopTimer )
			timer.cancel( enemyFireTimer )
			timer.cancel(bfLoopTimer)
			timer.cancel(bmLoopTimer)

		elseif ( phase == "did" ) then
			-- Code here runs immediately after the scene goes entirely off screen
			Runtime:removeEventListener( "collision", onCollision )
			physics.pause()
			audio.stop( 1 )
			composer.removeScene( "game" )
		end
	end


	-- destroy()
	function scene:destroy( event )

		local sceneGroup = self.view
		-- Code here runs prior to the removal of scene's view
		audio.dispose( explosionSound )
		audio.dispose( fireSound )
		audio.dispose( musicTrack )
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
