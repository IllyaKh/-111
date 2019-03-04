
local composer = require( "composer" )

local scene = composer.newScene()

local json = require( "json" )
 
local filePath = system.pathForFile( "leven.json", system.DocumentsDirectory )


-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local physics = require( "physics" )
physics.start()
physics.setGravity( 0, 0 )
system.setAccelerometerInterval( 60)
-- Configure image sheet
local bs1S_info = require("anim.bs1S")
local bs1S_sheet = graphics.newImageSheet("anim/bs1S.png",bs1S_info:getSheet())
local bs1S_data =
{
	{
		name = "active",
		sheet = bs1S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}
local bs2S_info = require("anim.bs2S")
local bs2S_sheet = graphics.newImageSheet("anim/bs2S.png",bs2S_info:getSheet())
local bs2S_data =
{
	{
		name = "active",
		sheet = bs2S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}

local bs3S_info = require("anim.bs3S")
local bs3S_sheet = graphics.newImageSheet("anim/bs3S.png",bs3S_info:getSheet())
local bs3S_data =
{
	{
		name = "active",
		sheet = bs3S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}


local bs4S_info = require("anim.bs4S")
local bs4S_sheet = graphics.newImageSheet("anim/bs4S.png",bs4S_info:getSheet())
local bs4S_data =
{
	{
		name = "active",
		sheet = bs4S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}


local bs5S_info = require("anim.bs5S")
local bs5S_sheet = graphics.newImageSheet("anim/bs5S.png",bs5S_info:getSheet())
local bs5S_data =
{
	{
		name = "active",
		sheet = bs5S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}
local bs6S_info = require("anim.bs6S")
local bs6S_sheet = graphics.newImageSheet("anim/bs6S.png",bs6S_info:getSheet())
local bs6S_data =
{
	{
		name = "active",
		sheet = bs6S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}

local bs7S_info = require("anim.bs7S")
local bs7S_sheet = graphics.newImageSheet("anim/bs7S.png",bs7S_info:getSheet())
local bs7S_data =
{
	{
		name = "active",
		sheet = bs7S_sheet,
		start = 1,
		count = 2,
		time = 200,
		loopcount = 0

	}

}
local mn_info = require("anim.mn")
local mn_sheet = graphics.newImageSheet("anim/mn.png",mn_info:getSheet())
local mn_data =
{
    {
        name = "active",
        sheet = mn_sheet,
        start = 1,
        count = 2,
        time = 200,
        loopcount = 0

    }

}


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
local bs1S
local bs2S
local bs3S
local bs4S
local bs5S
local bs61S
local bs62S
local mn
--ILLYA NEW VARIABLES UP
local intervalShip=60
local bdirection = 1
local b1direction = 1
local b2direction = 1
local b1lives = 20
local b2lives = 30
local b3lives = 40
local b4lives = 40
local b5lives = 20
local b6lives = 30
local b7lives = 60
local b1max = b1lives
local b2max = b2lives
local b3max = b3lives
local b4max = b4lives
local b5max = b5lives
local b6max = b6lives
local b7max = b7lives
local b7speed = 3000
local b61active = false
local b62active = false
local died = false
local enemyShips = {}
local whoCanShoot = {}
local enemyBullets = {}
local isInvisible = false
local shootEnemySpeed = 10
local isShield = false
local velocityEnemy = 100
local enemyFireTimer
local bTimer
enemyTable = {}

local levelText
local ship
local gameLoopTimer
local bfLoopTimer
local bmLoopTimer
local livesText
local scoreText
local b1hb
local lengthRect
instat = 3

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
	gamePaused = 1
	transition.pause("animationBlock")
	composer.showOverlay("pause",options)
end

function sleep(ms)
	local b = os.clock()*1000
	while os.clock()*1000-b <= ms do end
end

function levnum()
	local levbutt = display.newText(uiGroup,"LEVEL #".. levelEnemy  , display.contentCenterX,450, mainFont, 37 )
	levbutt:setFillColor( 255, 255, 0 )
	levbutt.alpha=0
			transition.to( levbutt, { alpha=1, time=1000,
			onComplete = function()
			transition.to( levbutt, { alpha=0, time=1000,
			onComplete = function()
			display.remove(levbutt)
			end
		} )
			end,tag = "animationBlock"
		} )


end

function create1BS()
	bs1S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs1S, { y=200, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function create2BS()
	bs2S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs2S, { y=300, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function create3BS()
	bs3S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs3S, { y=200, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function create4BS()
	bs4S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs4S, { y=200, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function create5BS()
	bs5S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs5S, { y=200, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function create6BS()
	bs61S.x = display.contentCenterX
	bs62S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs61S, { y=300, time=2000,
			onComplete = function()
			transition.to( bs61S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
			end,tag = "animationBlock"
		} )
		end})
		b61active = true
		transition.to( bs62S, { y=100, time=2000,
			onComplete = function()
			transition.to( bs62S, { x=200, time=2000,
				onComplete = function()
			end,tag = "animationBlock"
		} )
		end})
		bactive = true
end

function create7BS()
	bs7S.x = display.contentCenterX
	for i = #enemyTable, 1, -1 do
		local thisAsteroid = enemyTable[i]
		display.remove( thisAsteroid )
		table.remove( enemyTable, i )
	end
		transition.to( bs7S, { y=200, time=2000,
			onComplete = function()
			end,tag = "animationBlock"
		} )
		bactive = true
end

function b1Move()
	if (bactive == true) then
		bdirection= bdirection+1
		if (math.fmod(bdirection, 2) == 0) then
			transition.to( bs1S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
			else
			transition.to( bs1S, { x=200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
	end
	if(bactive == false) then
		display.remove(b1hb)
	end
end

function b7Move()
	if (bactive == true) then
		bdirection= bdirection+1
		if (math.fmod(bdirection, 2) == 0) then
			transition.to( bs7S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
			else
			transition.to( bs7S, { x=200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
	end
	if(bactive == false) then
		display.remove(b1hb)
	end
end

function b2Move()
	if (bactive == true) then
		bdirection= math.random(1,4)
		if (bdirection == 1) then
			transition.to( bs2S, { x=display.contentWidth-200, time=2500,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
		if (bdirection == 2) then
			transition.to( bs2S, { x=200, time=2500,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
		if (bdirection == 3) then
			transition.to( bs2S, { y = 400, time=2500,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
		if (bdirection == 4) then
			transition.to( bs2S, { y=200, time=2500,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
	end
end

function b7Inv()
	b7lives = b7lives-0.5
		transition.to( bs7S, { alpha=0.5, time=500,
			onComplete = function()
				bs7S.isBodyActive = false
					transition.to( bs7S, { alpha=1, time=15000,
			onComplete = function()
				bs7S.isBodyActive = true
			end,tag = "animationBlock"
		} )
		end,tag = "animationBlock"
		} )
	end

function b7Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local BossBullet1 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet1, "dynamic", { isSensor=true } )
				BossBullet1.isBullet = true
				BossBullet1.myName = "enemyBullet"
				BossBullet1.x = bs7S.x
				BossBullet1.y = bs7S.y
					transition.to( BossBullet1, { y = (display.contentHeight+300) , time=3000,
					onComplete = function() display.remove( BossBullet1 ) end,tag = "animationBlock"
				} )
				
				local BossBullet2 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet2, "dynamic", { isSensor=true } )
				BossBullet2.isBullet = true
				BossBullet2.myName = "enemyBullet"
				BossBullet2.x = bs7S.x
				BossBullet2.y = bs7S.y
					transition.to( BossBullet2, { y = (display.contentHeight+300), x = bs7S.x+300 , time=3000,
					onComplete = function() display.remove( BossBullet2 ) end,tag = "animationBlock"
				} )
				
				local BossBullet3 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet3, "dynamic", { isSensor=true } )
				BossBullet3.isBullet = true
				BossBullet3.myName = "enemyBullet"
				BossBullet3.x = bs7S.x
				BossBullet3.y = bs7S.y
					transition.to( BossBullet3, { y = (display.contentHeight+300), x = bs7S.x-300 , time=3000,
					onComplete = function() display.remove( BossBullet3 ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function b3Inv()
	instat = instat+1
	if (math.fmod (instat,2) == 0) then
		transition.to( bs3S, { alpha=1, time=500,
			onComplete = function()
				bs3S.isBodyActive = true
			end,tag = "animationBlock"
		} )
	else
		transition.to( bs3S, { alpha=0, time=500,
			onComplete = function()
				bs3S.isBodyActive = false
			end,tag = "animationBlock"
		} )
	end
end
function b4Inv()
	instat = instat+1
	if (math.fmod (instat,2) == 0) then
		transition.to( bs4S, { alpha=1, time=500,
			onComplete = function()
				bs4S.isBodyActive = true
			end,tag = "animationBlock"
		} )
	else
		transition.to( bs4S, { alpha=0, time=500,
			onComplete = function()
				bs4S.isBodyActive = false
			end,tag = "animationBlock"
		} )
	end
end
function b5regen()
	if (b5lives<b5max+4)then
		b5lives = b5lives+4
	end
end
function b5Move()
	if (bactive == true)then
		transition.to( bs5S, { y = 500, time=1000,
		onComplete = function()
			transition.to( bs5S, { x = display.contentWidth - 200, time=1000,
			onComplete = function()
				transition.to( bs5S, { y = 200, time=1000,
				onComplete = function()
					transition.to( bs5S, { x = 200, time=1000,
					onComplete = function()
						transition.to( bs5S, { y = 500, time=1000,
						onComplete = function()
							transition.to( bs5S, { x = display.contentCenterX, time=1000,
							onComplete = function()
								transition.to( bs5S, { y = 300, time=1000,
								onComplete = function()
		end} )
		end} )
		end} )
		end} )
		end} )
		end} )
		end,tag = "animationBlock"} )
	end	
end

function b3Move()
	if (bactive == true) then
		bdirection= bdirection+1
		if (math.fmod(bdirection, 2) == 0) then
			transition.to( bs3S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
			else
			transition.to( bs3S, { x=200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
	end
end

function b4Move()
	if (bactive == true) then
		bdirection= bdirection+1
		if (math.fmod(bdirection, 2) == 0) then
			transition.to( bs4S, { x=display.contentWidth-200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
			else
			transition.to( bs4S, { x=200, time=2000,
				onComplete = function()
				end,tag = "animationBlock"
			} )	
		end
	end
end

function b5Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local BossBullet1 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet1, "dynamic", { isSensor=true } )
				BossBullet1.isBullet = true
				BossBullet1.myName = "enemyBullet"
				BossBullet1.x = bs5S.x-30
				BossBullet1.y = bs5S.y
					transition.to( BossBullet1, { y = (display.contentHeight+300) , time=3000,
					onComplete = function() display.remove( BossBullet1 ) end,tag = "animationBlock"
				} )
				
				local BossBullet2 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet2, "dynamic", { isSensor=true } )
				BossBullet2.isBullet = true
				BossBullet2.myName = "enemyBullet"
				BossBullet2.x = bs5S.x+30
				BossBullet2.y = bs5S.y
					transition.to( BossBullet2, { y = (display.contentHeight+300) , time=3000,
					onComplete = function() display.remove( BossBullet2 ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function b1Fire()
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

function b61Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local tempBossBullet = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( tempBossBullet, "dynamic", { isSensor=true } )
				tempBossBullet.isBullet = true
				tempBossBullet.myName = "enemyBullet"
				tempBossBullet.x = bs61S.x
				tempBossBullet.y = bs61S.y
					transition.to( tempBossBullet, { y = (display.contentHeight+300) , time=2000,
					onComplete = function() display.remove( tempBossBullet ) end,tag = "animationBlock"
				} )
			end
		end
	end
end



function b62Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local tempBossBullet = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( tempBossBullet, "dynamic", { isSensor=true } )
				tempBossBullet.isBullet = true
				tempBossBullet.myName = "enemyBullet"
				tempBossBullet.x = bs62S.x
				tempBossBullet.y = bs62S.y
					transition.to( tempBossBullet, { y = (display.contentHeight+300) , time=2000,
					onComplete = function() display.remove( tempBossBullet ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function b6Fire()
if(b61active == true) then
b61Fire()
end
b62Fire()
end

function b61Move()
	if (died == false) then
		if (b61active == true) then
				transition.to( bs61S, { x=display.contentWidth-200, time=1500,
					onComplete = function()
									transition.to( bs61S, { x=200, time=1500,
					onComplete = function()
					end,tag = "animationBlock"
				} )	
				end,tag = "animationBlock"
				} )	
			end
		end
		if(bactive == false) then
			display.remove(b1hb)
		end
end

function b62Move()
	if (died == false) then
		if (bactive == true) then
				transition.to( bs62S, { x=200, time=1500,
					onComplete = function()					
									transition.to( bs62S, { x=display.contentWidth-200, time=1500,
					onComplete = function()
					end,tag = "animationBlock"
				} )	
				end,tag = "animationBlock"
				} )	
			end
		end
		if(bactive == false) then
			display.remove(b1hb)
		end
end

function b6Move()
if (bactive == true)then
	if(b61active == true) then
		b61Move()
	end
	b62Move()
	end
end
function b2Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local BossBullet1 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet1, "dynamic", { isSensor=true } )
				BossBullet1.isBullet = true
				BossBullet1.myName = "enemyBullet"
				BossBullet1.x = bs2S.x
				BossBullet1.y = bs2S.y
					transition.to( BossBullet1, { y = (display.contentHeight+300) , time=3000,
					onComplete = function() display.remove( BossBullet1 ) end,tag = "animationBlock"
				} )
				
				local BossBullet2 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet2, "dynamic", { isSensor=true } )
				BossBullet2.isBullet = true
				BossBullet2.myName = "enemyBullet"
				BossBullet2.x = bs2S.x
				BossBullet2.y = bs2S.y
					transition.to( BossBullet2, { y = (display.contentHeight+300), x = bs2S.x+300 , time=3000,
					onComplete = function() display.remove( BossBullet2 ) end,tag = "animationBlock"
				} )
				
				local BossBullet3 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet3, "dynamic", { isSensor=true } )
				BossBullet3.isBullet = true
				BossBullet3.myName = "enemyBullet"
				BossBullet3.x = bs2S.x
				BossBullet3.y = bs2S.y
					transition.to( BossBullet3, { y = (display.contentHeight+300), x = bs2S.x-300 , time=3000,
					onComplete = function() display.remove( BossBullet3 ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function bFire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local BossBullet1 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet1, "dynamic", { isSensor=true } )
				BossBullet1.isBullet = true
				BossBullet1.myName = "enemyBullet"
				BossBullet1.x = bs3S.x+30
				BossBullet1.y = bs3S.y
					transition.to( BossBullet1, { y = (display.contentHeight+300) , time=2000,
					onComplete = function() display.remove( BossBullet1 ) end,tag = "animationBlock"
				} )
				
				local BossBullet2 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet2, "dynamic", { isSensor=true } )
				BossBullet2.isBullet = true
				BossBullet2.myName = "enemyBullet"
				BossBullet2.x = bs3S.x-30
				BossBullet2.y = bs3S.y
					transition.to( BossBullet2, { y = (display.contentHeight+300) , time=2000,
					onComplete = function() display.remove( BossBullet2 ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

function b3Fire()

			timer.performWithDelay(300,bFire,3)


end

function b4Fire()
	if (died == false) then
		if (bactive == true) then
			if (gamePaused == 0 ) then
				local BossBullet1 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet1, "dynamic", { isSensor=true } )
				BossBullet1.isBullet = true
				BossBullet1.myName = "enemyBullet"
				BossBullet1.x = bs4S.x-20
				BossBullet1.y = bs4S.y
					transition.to( BossBullet1, { y = (display.contentHeight+300) , time=3000,
					onComplete = function() display.remove( BossBullet1 ) end,tag = "animationBlock"
				} )
				
				local BossBullet2 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet2, "dynamic", { isSensor=true } )
				BossBullet2.isBullet = true
				BossBullet2.myName = "enemyBullet"
				BossBullet2.x = bs4S.x
				BossBullet2.y = bs4S.y
					transition.to( BossBullet2, { y = (display.contentHeight+300), x = bs4S.x+400 , time=3000,
					onComplete = function() display.remove( BossBullet2 ) end,tag = "animationBlock"
				} )
				
				local BossBullet3 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet3, "dynamic", { isSensor=true } )
				BossBullet3.isBullet = true
				BossBullet3.myName = "enemyBullet"
				BossBullet3.x = bs4S.x
				BossBullet3.y = bs4S.y
					transition.to( BossBullet3, { y = (display.contentHeight+300), x = bs4S.x-400 , time=3000,
					onComplete = function() display.remove( BossBullet3 ) end,tag = "animationBlock"
				} )
				
				local BossBullet4 = display.newImageRect( mainGroup, "laser.png", 75 , 145 )
				physics.addBody( BossBullet4, "dynamic", { isSensor=true } )
				BossBullet4.isBullet = true
				BossBullet4.myName = "enemyBullet"
				BossBullet4.x = bs4S.x+20
				BossBullet4.y = bs4S.y
					transition.to( BossBullet4, { y = (display.contentHeight+300), time=3000,
					onComplete = function() display.remove( BossBullet3 ) end,tag = "animationBlock"
				} )
			end
		end
	end
end

local function createEnemyShip()
	if (bactive == false) then
		newEnemy = display.newImageRect( mainGroup,"putin.png", 102, 85 )
		table.insert( enemyTable, newEnemy )
		physics.addBody( newEnemy, "dynamic", { radius=40, bounce = 10 } )
		newEnemy.myName = "asteroid"

		if ( levelEnemy == 1) then


			for i= 0 ,levelEnemy do

				newEnemy.x = math.random( display.contentWidth )
				newEnemy.y =-100
				transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
		} )

				end

		elseif ( levelEnemy == 2) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})
		elseif ( levelEnemy == 3) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})
		elseif ( levelEnemy == 4) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})
		elseif ( levelEnemy == 5) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})
		elseif ( levelEnemy == 6) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})
		elseif ( levelEnemy == 7) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})	
		elseif ( levelEnemy == 8) then
			newEnemy.x = math.random( display.contentWidth )
			newEnemy.y = -60
			transition.to( newEnemy, { y=display.contentHeight + 200, time=4000,
				onComplete = function()
				end,tag = "animationBlock"
			})	
		end
	end
end
function levelComplete()
	sleep(10000)
end

function fireEnemyBullet()
	if (died == false) then
		if (gamePaused == 0 ) then
			if (bactive == false)then
				if(#enemyTable > 0) then
					local randomIndex = math.random(#enemyTable)
					local randomEnemy = enemyTable[randomIndex]
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
			end,tag = "animationBlock"
		} )
	end


	local function endGameLoose()

		composer.setVariable( "finalScore", score )
		composer.gotoScene( "lose", { time=800, effect="crossFade" } )
	end
	
	local function endGameWin()
		bactive = false
	 	levelEnemy = levelEnemy+1
		transition.pause("animationBlock")
		print("curlevelEnemy endgame :"..levelEnemy)
	    local file = io.open( filePath, "w" )
		if file then
			file:write( json.encode( levelEnemy ) )
		end
		composer.gotoScene( "victory", { time=800, effect="crossFade" } )
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
						if (score - tempscore == 300) then
							create1BS()
							
						end
					end
					if (levelEnemy == 2) then
						if (score - tempscore == 300) then
							create2BS()
						end
					end
					if (levelEnemy == 3) then
						if (score - tempscore == 300) then
							create3BS()
						end
					end
					if (levelEnemy == 4) then
						if (score - tempscore == 300) then
							create4BS()
						end
					end
					if (levelEnemy == 5) then
						if (score - tempscore == 300) then
							create5BS()
						end
					end
					if (levelEnemy == 6) then
						if (score - tempscore == 300) then
							create6BS()
						end
					end
					if (levelEnemy == 7) then
						if (score - tempscore == 300) then
							create7BS()
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
						if (levelEnemy == 7) then
							b7lives = b7max
						end
				        if(lives == 3) then
							hb = display.newImageRect( uiGroup, "imgcontent/hp1.png", 200,200 )
							hb.x = 190
							hb.y = 80
						elseif(lives == 2) then
							hb = display.newImageRect( uiGroup, "imgcontent/hp2.png", 200,200 )
							hb.x = 190
							hb.y = 80
						elseif(lives == 1) then
							hb = display.newImageRect( uiGroup, "imgcontent/hp3.png", 200,200 )
							hb.x = 190
							hb.y = 80
						end
						if ( lives == 0 ) then
							display.remove(b1hb)
							display.remove( ship )
							timer.performWithDelay( 2000, endGameLoose )
						else
							ship.alpha = 0
							timer.performWithDelay( 500, restoreShip )
						end
					end
				end
				if( (obj1.myName == "laser" and obj2.myName == "boss") or
				( obj1.myName == "boss" and obj2.myName == "laser")) then
					audio.play( explosionSound )
					if (obj1.myName == "laser")  then
							display.remove( obj1 )
						end
						if (obj2.myName == "laser")  then
							display.remove( obj2 )
						end
					if (levelEnemy == 1) then
						b1lives = b1lives - 0.5
						if(b1lives>0) then
							display.remove(b1hb)
							lengthRect = (display.contentWidth*b1lives)/b1max
							b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
							b1hb:setFillColor(0, 255, 0)
							if(b1lives>b1max/2) then
								b1hb:setFillColor(0,255,0)

							elseif(b1lives<=b1max/2 and b1lives>=(b1max/2) - (b1max/3)) then
								b1hb:setFillColor(255, 237, 0)
							elseif(b1lives<b1max/3) then
								b1hb:setFillColor(255, 0, 0)
							end

						elseif(b1lives==0 or b1lives< 0) then
							display.remove(b1hb)
						end
						if (obj1.myName == "laser")  then
							display.remove( obj1 )
						end
						if (obj2.myName == "laser")  then
							display.remove( obj2 )
						end
						if ( b1lives == 0 or b1lives<0 ) then
							display.remove(b1hb)
							display.remove( bs1S )
							b1defeat = true
							if (levelEnemy==8) then
								create2BS()
							end
							if (levelEnemy==1) then
								timer.performWithDelay( 100, endGameWin )
							end
						end
					end
					if (levelEnemy == 2) then
						b2lives = b2lives - 0.5
						if(b2lives>0) then
							display.remove(b1hb)
							lengthRect = (display.contentWidth*b2lives)/b2max
							b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
							b1hb:setFillColor(0, 255, 0)
							if(b2lives>b2max/2) then
								b1hb:setFillColor(0,255,0)

							elseif(b2lives<=b2max/2 and b2lives>=(b2max/2) - (b2max/3)) then
								b1hb:setFillColor(255, 237, 0)
							elseif(b2lives<b2max/3) then
								b1hb:setFillColor(255, 0, 0)
							end

						elseif(b2lives==0 or b2lives< 0) then
							display.remove(b1hb)
						end
						if ( b2lives == 0 or b2lives<0 ) then
							display.remove(b1hb)
							display.remove( bs2S )
							b2defeat = true
							if (levelEnemy==8) then
								create3BS()
							end
							if (levelEnemy == 2) then
								timer.performWithDelay( 100, endGameWin )
							end
						end
					end
					if (levelEnemy == 3) then
						if (bs3S. alpha>0) then
							b3lives = b3lives - 0.5
							if(b3lives>0) then
								display.remove(b1hb)
								lengthRect = (display.contentWidth*b3lives)/b3max
								b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
								b1hb:setFillColor(0, 255, 0)
								if(b3lives>b3max/2) then
									b1hb:setFillColor(0,255,0)

								elseif(b3lives<=b3max/2 and b3lives>=(b3max/2) - (b3max/3)) then
									b1hb:setFillColor(255, 237, 0)
								elseif(b3lives<b3max/3) then
									b1hb:setFillColor(255, 0, 0)
								end

							elseif(b3lives==0 or b3lives< 0) then
								display.remove(b1hb)
							end
							if ( b3lives == 0 or b3lives<0 ) then
								display.remove(b1hb)
								display.remove( bs3S )
								b3defeat = true
							if (levelEnemy==8) then
								create4BS()
							end
							if (levelEnemy == 3) then
								timer.performWithDelay( 100, endGameWin )
							end
							end
						end
					end
					if (levelEnemy == 4) then
						if (bs4S. alpha>0) then
							b4lives = b4lives - 0.5
							if(b4lives>0) then
								display.remove(b1hb)
								lengthRect = (display.contentWidth*b4lives)/b4max
								b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
								b1hb:setFillColor(0, 255, 0)
								if(b4lives>b4max/2) then
									b1hb:setFillColor(0,255,0)

								elseif(b4lives<=b4max/2 and b4lives>=(b4max/2) - (b4max/3)) then
									b1hb:setFillColor(255, 237, 0)
								elseif(b4lives<b4max/3) then
									b1hb:setFillColor(255, 0, 0)
								end

							elseif(b4lives==0 or b4lives< 0) then
								display.remove(b1hb)
							end
							if ( b4lives == 0 or b4lives<0 ) then
								display.remove(b1hb)
								display.remove( bs4S )
								b4defeat = true
								if (levelEnemy==8) then
								create5BS()
							end
							if (levelEnemy == 4) then
								timer.performWithDelay( 100, endGameWin )
							end
							end
						end
					end
					if (levelEnemy == 5) then
						b5lives = b5lives - 0.5
						if(b5lives>0) then
							display.remove(b1hb)
							lengthRect = (display.contentWidth*b5lives)/b5max
							b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
							b1hb:setFillColor(0, 255, 0)
							if(b5lives>b5max/2) then
								b1hb:setFillColor(0,255,0)

							elseif(b5lives<=b5max/2 and b5lives>=(b5max/2) - (b5max/3)) then
								b1hb:setFillColor(255, 237, 0)
							elseif(b5lives<b5max/3) then
								b1hb:setFillColor(255, 0, 0)
							end

						elseif(b5lives==0 or b5lives< 0) then
							display.remove(b1hb)
						end
						if ( b5lives == 0 or b5lives<0 ) then
							display.remove(b1hb)
							display.remove( bs5S )
							b5defeat = true
							timer.performWithDelay( 100, endGameWin )
						end
					end
					if (levelEnemy == 6) then
						b6lives = b6lives - 0.5
						if(b6lives>0) then
							display.remove(b1hb)
							lengthRect = (display.contentWidth*b6lives)/b6max
							b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
							b1hb:setFillColor(0, 255, 0)
							if(b6lives>b6max/2) then
								b1hb:setFillColor(0,255,0)
							elseif(b6lives<=b6max/2 and b6lives>=(b6max/2) - (b6max/3)) then
							if (b61active == true) then
								b61active = false
								display.remove(bs61S)
								b6lives = b6max
							end
								b1hb:setFillColor(255, 237, 0)
							elseif(b6lives<b6max/3) then
								b1hb:setFillColor(255, 0, 0)
							end

						elseif(b6lives==0 or b6lives< 0) then
							display.remove(b1hb)
						end
						if ( b6lives == 0 or b6lives<0 ) then
							display.remove(b1hb)
							display.remove( bs6S )
							b6defeat = true
							timer.performWithDelay( 100, endGameWin )
						end
					end
					if (levelEnemy == 7) then
						b7lives = b7lives - 0.5
						if(b5lives>0) then
							display.remove(b1hb)
							lengthRect = (display.contentWidth*b7lives)/b7max
							b1hb = display.newRect(uiGroup,lengthRect/2,10,lengthRect,20)
							b1hb:setFillColor(0, 255, 0)
							if(b7lives==b7max/2 or b7lives==b7max/3) then
								b7speed = 1500
								bfLoopTimer._delay = b7speed
								b7Inv()
							end
							if(b7lives>b7max/2) then
								b7speed = 3000
								bfLoopTimer._delay = b7speed
								b1hb:setFillColor(0,255,0)

							elseif(b7lives<b5max/2 and b7lives>(b7max/2) - (b7max/3)) then
								b7speed = 3000
								bfLoopTimer._delay = b7speed
								b1hb:setFillColor(255, 237, 0)
							elseif(b7lives<b7max/3) then
								b7speed = 3000
								bfLoopTimer._delay = b7speed
								b1hb:setFillColor(255, 0, 0)
							end

						elseif(b7lives==0 or b7lives< 0) then
							display.remove(b1hb)
						end
						if ( b7lives == 0 or b7lives<0 ) then
							display.remove(b1hb)
							display.remove( bs7S )
							b7defeat = true
							timer.performWithDelay( 100, endGameWin )		
					
						end
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

			local bgImage = { type="image", filename="background1.png" }
			local bgImage2 = { type="image", filename="background2.png" }
			local bgImage3 = { type="image", filename="background3.png" }

			-- Add First bg image
			bg1 = display.newRect(backGroup,0, 0, display.contentWidth, display.actualContentHeight)
			bg1.fill = bgImage
			if(levelEnemy>=3 and levelEnemy<=5) then

				bg1.fill  = bgImage2

			elseif(levelEnemy>=6 and levelEnemy<=8) then

				bg1.fill  = bgImage3
			end
			bg1.x = display.contentCenterX
			bg1.y = display.contentCenterY

			-- Add Second bg image
			bg2 = display.newRect(backGroup,0, 0, display.contentWidth, display.actualContentHeight)
			bg2.fill = bgImage
			if(levelEnemy>=3 and levelEnemy<=5) then

				bg2.fill  = bgImage2

			elseif(levelEnemy>=6 and levelEnemy<=8) then

				bg2.fill  = bgImage3
			end
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
		
        if(lives == 3) then
			hb = display.newImageRect( uiGroup, "imgcontent/hp1.png", 200,200 )
			hb.x = 190
			hb.y = 80
		elseif(lives == 2) then
			hb = display.newImageRect( uiGroup, "imgcontent/hp2.png", 200,200 )
			hb.x = 190
			hb.y = 80
        elseif(lives == 1) then
			hb = display.newImageRect( uiGroup, "imgcontent/hp3.png", 200,200 )
			hb.x = 190
			hb.y = 80
		end
		local pauseButton = display.newImageRect(mainGroup,"stop.png",80,80)
		pauseButton.x = display.contentWidth-150
		pauseButton.y = 100

		ship = display.newSprite( sceneGroup, mn_sheet, mn_data)
        ship:scale(2,2)
		ship.x = display.contentCenterX
		ship.y = display.contentHeight - 100
		physics.addBody( ship, { radius=30, isSensor=true } )
		ship.myName = "ship"
        ship:setSequence("active")
        ship:play()
		
		if (levelEnemy == 1) then

			bs1S = display.newSprite( mainGroup, bs1S_sheet,bs1S_data)
			bs1S:scale(4,4)
			physics.addBody( bs1S, "dynamic", { radius=120, bounce = 0 } )
			bs1S.myName = "boss"
			bs1S.x = display.contentCenterX
			bs1S.y = - 300
			bs1S:setSequence("active")
			bs1S:play()

		end
		if (levelEnemy == 2) then
			bs2S = display.newSprite( mainGroup, bs2S_sheet,bs2S_data)
			bs2S:scale(4,4)
			physics.addBody( bs2S, "dynamic", { radius=120, bounce = 0 } )
			bs2S.myName = "boss"
			bs2S.x = display.contentCenterX
			bs2S.y = - 300
			bs2S:setSequence("active")
			bs2S:play()
		end
		if (levelEnemy == 3) then
			bs3S = display.newSprite( mainGroup, bs3S_sheet,bs3S_data)
			bs3S:scale(4,4)
			physics.addBody( bs3S, "dynamic", { radius=120, bounce = 0 } )
			bs3S.myName = "boss"
			bs3S.x = display.contentCenterX
			bs3S.y = - 300
			bs3S:setSequence("active")
			bs3S:play()
		end
		if (levelEnemy == 4) then
			bs4S = display.newSprite( mainGroup, bs4S_sheet,bs4S_data)
			bs4S:scale(4,4)
			physics.addBody( bs4S, "dynamic", { radius=120, bounce = 0 } )
			bs4S.myName = "boss"
			bs4S.x = display.contentCenterX
			bs4S.y = - 300
			bs4S:setSequence("active")
			bs4S:play()
		end
		if (levelEnemy == 5) then
			bs5S = display.newSprite( mainGroup, bs5S_sheet,bs5S_data)
			bs5S:scale(4,4)
			physics.addBody( bs5S, "dynamic", { radius=120, bounce = 0 } )
			bs5S.myName = "boss"
			bs5S.x = display.contentCenterX
			bs5S.y = - 300
			bs5S:setSequence("active")
			bs5S:play()
		end
		if (levelEnemy == 6) then
			bs61S = display.newSprite( mainGroup, bs6S_sheet,bs6S_data)
			bs61S:scale(1.8,1.8)
			physics.addBody( bs61S, "dynamic", { radius=60, bounce = 0 } )
			bs61S.myName = "boss"
			bs61S.x = display.contentCenterX+100
			bs61S.y = - 300
			bs61S:setSequence("active")
			bs61S:play()
			bs62S = display.newSprite( mainGroup, bs6S_sheet,bs6S_data)
			bs62S:scale(1.8,1.8)
			physics.addBody( bs62S, "dynamic", { radius=60, bounce = 0 } )
			bs62S.myName = "boss"
			bs62S.x = display.contentCenterX-100
			bs62S.y = - 300
			bs62S:setSequence("active")
			bs62S:play()
		end
		if (levelEnemy == 7) then
            bs7S = display.newSprite( mainGroup, bs7S_sheet,bs7S_data)
            bs7S:scale(4,4)
			physics.addBody( bs7S, "dynamic", { radius=120, bounce = 0 } )
			bs7S.myName = "boss"
			bs7S.x = display.contentCenterX
			bs7S.y = - 300
            bs7S:setSequence("active")
            bs7S:play()

		end

		
		-- Display lives and score
	--	hb = display.newImageRect( uiGroup, "imgcontent/hp1.png", 200,200 )
	--	hb.x = 190
	--	hb.y = 80

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
			levnum()
			gameLoopTimer = timer.performWithDelay( 500, gameLoop, 0 )
			enemyFireTimer = timer.performWithDelay( 500, fireEnemyBullet, 0 )
			if (levelEnemy==1) then
				bfLoopTimer = timer.performWithDelay( 1500, b1Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 4000, b1Move, 0 )
			if (b1defeat == true) then
				timer.cancel(bfLoopTimer)
				timer.cancel(bmLoopTimer)
			end
			end
			if (levelEnemy==2) then
				bfLoopTimer = timer.performWithDelay( 4000, b2Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 2000, b2Move, 0 )

			end
			if (levelEnemy==3) then
				bfLoopTimer = timer.performWithDelay( 4000, b3Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 2000, b3Move, 0 )
				local biLoopTimer = timer.performWithDelay( math.random(2000,4000), b3Inv, 0 )
			end
			if (levelEnemy==4) then
				bfLoopTimer = timer.performWithDelay( 3000, b4Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 1000, b4Move, 0 )
				local biLoopTimer = timer.performWithDelay( math.random(1000,5000), b4Inv, 0 )
			end
			if (levelEnemy==5) then
				bfLoopTimer = timer.performWithDelay( 1500, b5Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 6000, b5Move, 0 )
				local biLoopTimer = timer.performWithDelay( 4000, b5regen, 0 )
			end
			if (levelEnemy==6 ) then
				bfLoopTimer = timer.performWithDelay( 1000, b6Fire, 0 )
				bmLoopTimer = timer.performWithDelay( 3000, b6Move, 0 )
			end
			if (levelEnemy==7) then
				bfLoopTimer = timer.performWithDelay( b7speed, b7Fire, 0 )		
				bmLoopTimer = timer.performWithDelay( 3000, b7Move, 0 )
			end
			
			
			
			end
			
			
			audio.play( musicTrack, { channel=1, loops=-1 } )
	--		Runtime:addEventListener( "collision", onCollision )
		end


	-- hide()
	function scene:hide( event )

		local sceneGroup = self.view
		local phase = event.phase

		if ( phase == "will" ) then
			-- Code here runs when the scene is on screen (but is about to go off screen)
			if (levelEnemy ~= 8) then
				timer.cancel(bfLoopTimer)
				timer.cancel(bmLoopTimer)
			end
			timer.cancel( gameLoopTimer )
			timer.cancel( enemyFireTimer )


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
