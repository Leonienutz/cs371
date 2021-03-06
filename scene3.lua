local composer = require( "composer" )
local scene = composer.newScene()
 
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here

---------------------------------------------------------------------------------
 
local opt =
{
frames = {
      --idle pose-
      { x = 0, y = 0, width = 75, height = 130}, --frame 1
      { x = 0, y = 0, width = 150, height = 130}, --frame 1
      { x = 0, y = 0, width = 225, height = 130}, --frame 1
      { x = 0, y = 0, width = 300, height = 130}, --frame 1
      { x = 0, y = 0, width = 375, height = 130}, --frame 1
     
  }
}
-- include sprite image sheet
local sheet = graphics.newImageSheet( "cars.png", opt);


local function onSwitchPress(event)
	if(event.target.id == "yello") then
		composer.setVariable("playerColor", "yellow")
	elseif(event.target.id == "green") then
		composer.setVariable("playerColor", "green")
	elseif(event.target.id == "blue") then
		composer.setVariable("playerColor", "blue")
	elseif(event.target.id == "red") then
		composer.setVariable("playerColor", "red")
	elseif(event.target.id == "purple") then
		composer.setVariable("playerColor", "purple")
	end
end

-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
   local buttonBack = widget.newButton(
    {
        left = display.contentCenterX - 50,
        top = 1,
        id = "back",
        label = "Back",
        labelColor = { default={ 0, 0, 0 }, over={ 0.5, 0.5, 0.5, 0.5 } },
        onEvent = back,
        emboss = false,
        -- Properties for a rounded rectangle button
        shape = "roundedRect",
        width = 100,
        height = 30,
        cornerRadius = 4,
        fillColor = { default={1,1,1,1}, over={1,1,1,0.4} },
        strokeColor = { default={0.6,0.5,0.5,1}, over={0.8,0.8,1,1} },
        strokeWidth = 2
    }
)
   sceneGroup:insert(buttonBack);
   
   local options = {
      effect = "fade",
      time = 100
   }

   local colorText = display.newText("Car Color", display.contentCenterX, display.contentCenterY -180, native.systemFont, 20 )
   sceneGroup:insert(colorText);

local radButYellow = widget.newSwitch(
    {
        left = 100,
        top = display.contentCenterY -145,
        style = "radio",
		id = "yellow",
        initialSwitchState = true,
        onPress = onSwitchPress,
    }
)
radButYellow:scale( 0.7, 0.7 )
sceneGroup:insert(radButYellow);
 local YellowText = display.newText("Yellow", display.contentCenterX, display.contentCenterY -129, native.systemFont, 15 )
 sceneGroup:insert(YellowText);

local radButBlue = widget.newSwitch(
    {
        left = 100,
        top = display.contentCenterY -105,
        style = "radio",
		id = "blue",
        initialSwitchState = false,
        onPress = onSwitchPress,
    }
)
radButBlue:scale( 0.7, 0.7 )
sceneGroup:insert(radButBlue);
 local BlueText = display.newText("Blue", display.contentCenterX, display.contentCenterY -89, native.systemFont, 15)
 sceneGroup:insert(BlueText);

local radButRed = widget.newSwitch(
    {
        left = 100,
        top = display.contentCenterY -65,
        style = "radio",
		id = "red",
        initialSwitchState = false,
        onPress = onSwitchPress,
    }
)
radButRed:scale( 0.7, 0.7 )
 sceneGroup:insert(radButRed);
 local RedText = display.newText("Red", display.contentCenterX, display.contentCenterY -49, native.systemFont, 15 )
 sceneGroup:insert(RedText);

local radButGreen = widget.newSwitch(
    {
        left = 100,
        top = display.contentCenterY -27,
        style = "radio",
		id = "green",
        initialSwitchState = false,
        onPress = onSwitchPress,
    }
)
radButGreen:scale( 0.7, 0.7 )
sceneGroup:insert(radButGreen);
 local GreenText = display.newText("Green", display.contentCenterX, display.contentCenterY -10, native.systemFont, 15 )
 sceneGroup:insert(GreenText);

local radButPurple = widget.newSwitch(
    {
        left = 100,
        top = display.contentCenterY+17,
        style = "radio",
        id = "purple",
        initialSwitchState = false,
        onPress = onSwitchPress,
    }
)
radButPurple:scale( 0.7, 0.7 )
sceneGroup:insert(radButPurple);
 local PurpleText = display.newText("Purple", display.contentCenterX, display.contentCenterY +33, native.systemFont, 15 )
 sceneGroup:insert(PurpleText);








   local function back (event)
      composer.gotoScene("scene1", options);
   end

   buttonBack:addEventListener("tap", back);
   
end

-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase

   if ( phase == "will" ) then
      -- Called when the scene is still off screen (but is about to come on screen).

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
