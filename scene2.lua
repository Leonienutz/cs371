local composer = require( "composer" )
local scene = composer.newScene()

local Player = require("Player");
local Enemy = require("Enemy");

local enemies = {}; --Table to hold all newly created enemies;
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here

---------------------------------------------------------------------------------
local function updateEnemies()
	 for j,enemy in ipairs(enemies) do
		if(enemy ~= nil) then
			enemy:Fall();
		end
	 end
end

local function spawnEnemy(sceneGroup)
	enemy = Enemy:new();
	enemy:spawn();
	table.insert(enemies, enemy) -- Maybe enemy.shape
	sceneGroup:insert(enemy.shape);
	timer.performWithDelay(100, updateEnemies, 0);
end


local function moveLeft()
	if(player.shape.x < 80) then
		return
	end
	player:moveLeft();
end

local function moveRight()
	if(player.shape.x > display.contentWidth - 80) then
		return
	end
	player:moveRight();
end

	local function leftHandler(event)
		
		if event.phase == "began" then
			myTimer = timer.performWithDelay(100, moveLeft, 0);
			print(myTimer)
			--player:moveLeft();
			print("Move left")
		elseif event.phase == "ended" then
			timer.cancel( myTimer )
		end
		
	end
	
	local function rightHandler(event)
		
		if event.phase == "began" then
			myTimer = timer.performWithDelay(100, moveRight, 0);
			print(myTimer)
			--player:moveLeft();
			print("Move left")
		elseif event.phase == "ended" then
			timer.cancel( myTimer )
		end
		
	end
 
-- "scene:create()"
function scene:create( event )
   
   local sceneGroup = self.view
   
   --Create BackGround
	local bg = display.newImage ("road.png", display.contentCenterX, display.contentCenterY);
	bg.xScale = display.contentWidth / bg.width; 
	bg.yScale = display.contentHeight / bg.height;
	sceneGroup:insert(bg);
	bg:toBack() 
   -- Initialize the scene here.
   local buttonBack = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "back",
        label = "X",
        labelColor = { default={ 0, 0, 0 }, over={ 0.5, 0.5, 0.5, 0.5 } },
        onEvent = back,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 30,
        height = 30,
        cornerRadius = 4,
        fillColor = { default={1,1,1,0.5}, over={1,1,1,0.4} },
        strokeColor = { default={0.6,0.5,0.5,1}, over={0.8,0.8,1,1} },
        strokeWidth = 2
    }
)

   sceneGroup:insert(buttonBack);
   
   --Create Player Move Button
      local buttonLeft = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "left",
        label = "<=",
        labelColor = { default={ 0, 0, 0, 0.5 }, over={ 0.5, 0.5, 0.5, 0.5 } },
        onEvent = leftHandler,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 30,
        height = 30,
        cornerRadius = 4,
        fillColor = { default={1,1,1,0.5}, over={1,1,1,0.4} },
        strokeColor = { default={0.6,0.5,0.5,1}, over={0.8,0.8,1,1} },
        strokeWidth = 2
    })
	buttonLeft.x = 30;
	buttonLeft.y = display.contentHeight;
	sceneGroup:insert(buttonLeft);
	
	local buttonRight = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "right",
        label = "=>",
        labelColor = { default={ 0, 0, 0, 0.5 }, over={ 0.5, 0.5, 0.5, 0.5 } },
        onEvent = rightHandler,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 30,
        height = 30,
        cornerRadius = 4,
        fillColor = { default={1,1,1,0.5}, over={1,1,1,0.4} },
        strokeColor = { default={0.6,0.5,0.5,1}, over={0.8,0.8,1,1} },
        strokeWidth = 2
    })
	buttonRight.x = display.contentWidth - 30;
	buttonRight.y = display.contentHeight;
	sceneGroup:insert(buttonRight);
	
   local options = {
      effect = "fade",
      time = 100
   }

   local function back (event)
      composer.gotoScene("scene1", options);
   end

   buttonBack:addEventListener("tap", back);
   
   --Create Player
   player = Player:new({color = composer.getVariable("playerColor")});
   player:spawn();
   sceneGroup:insert(player.shape);
   
   local myClosure = function() return spawnEnemy( sceneGroup ) end
   eSpawnTimer = timer.performWithDelay(1000, myClosure, 0);

	
end

-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
	player:setColor(composer.getVariable("playerColor"));
   elseif ( phase == "did" ) then
      -- Called when the scene is now on screen.
      -- Insert code here to make the scene come alive.
      -- Example: start timers, begin animation, play audio, etc.
	  
   end
end

-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
   elseif ( phase == "did" ) then
      -- Called immediately after scene goes off screen.
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
 
   local sceneGroup = self.view
 
   -- Called prior to the removal of scene's view ("sceneGroup").
   -- Insert code here to clean up the scene.
   -- Example: remove display objects, save state, etc.
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener("create", scene )
scene:addEventListener("show", scene )
scene:addEventListener("hide", scene )
scene:addEventListener("destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene
