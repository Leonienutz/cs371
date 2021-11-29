local composer = require( "composer" )
local scene = composer.newScene()

local Player = require("Player");
local Enemy = require("Enemy");
score =0

local enemies = {}; --Table to hold all newly created enemies;
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here

---------------------------------------------------------------------------------
local function spawnEnemy()
	local enemy1 = Enemy:new({yPos = -60});
	enemy1:spawn(scene.view);
	enemy1:Fall();
	table.insert(enemies, enemy1.shape) -- Maybe enemy.shape
end

local function enterFrame()
	local temp = math.random(1,1000);
	if(temp <= 10) then
		spawnEnemy();
	end

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
 
local scoreText= display.newText("Score ", display.contentWidth -15, 10, native.systemFont, 10)

sceneGroup:insert(scoreText);

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


   
	
end

-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).
	player:setColor(composer.getVariable("playerColor"));
   elseif ( phase == "did" ) then

 local scoreValueText= display.newText(score, display.contentWidth -14, 22, native.systemFont, 10)
sceneGroup:insert(scoreValueText);
   
   function update()
   scoreValueText.text = score;
   end
 
  timer.performWithDelay(10,update,0, "score_timer")


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
      timer.cancel( "score_timer" )
      -- Called when the scene is on screen (but is about to go off screen).
      -- Insert code here to "pause" the scene.
      -- Example: stop timers, stop animation, stop audio, etc.
	   physics.pause()

        for i, v in ipairs(enemies) do
          if v.removeSelf then
            v:removeSelf()
          end
        end

        enemies = {}
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

Runtime:addEventListener("enterFrame", enterFrame)
---------------------------------------------------------------------------------
 
return scene
