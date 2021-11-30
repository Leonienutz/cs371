--Overlay for GameOver
local composer = require( "composer" )
local scene = composer.newScene()
 local csv = require("csv");
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here
 
---------------------------------------------------------------------------------
 local options = {
 	effect = "fade",
 	time = 500
 }
 local function back2 (event)
 	composer.hideOverlay(true, "fade", 10)
 end


 local function overLayButtonEvent(event)
	if(event.phase == "began") then
		local path = system.pathForFile("pointsRecord.csv", system.DocumentsDirectory);
		local file = io.open(path, "a");
		print(path);
		print(file);
		file:write("\n" .. myTextField.text .. ", ")
		file:write(score)
		io.close(file)
		file = nil;
		myTextField.text = "";
	end
 end
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
   myTextField = native.newTextField(display.contentCenterX, display.contentCenterY, display.contentWidth, 50) --(centerX, centerY, width, height);
   --myTextField:addEventListener("userInput", textListener); --userInput events are used to listen to text input events caused by user interaction with TextField and TextBox objects.
   sceneGroup:insert(myTextField); --DONT FORGET TO ADD THE ITEM TO THE sceneGroup
   
      --Create Button with Shapes
   local overLayButton = widget.newButton( 

				{
					left = 10;
					top = 100;
					id = button1;
					width = 100;
					height = 50;
					label = "SUBMIT";
					shape = "roundedRect";
					fillColor= { default={0,0.5,0.9,0.3}, over={1,0.1,0.7,0.4} };
					onEvent = overLayButtonEvent;

				} 
			);
	overLayButton.x = display.contentWidth-60;
	overLayButton.y = display.contentCenterY + 50;
	sceneGroup:insert(overLayButton);
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
 local buttonBack = widget.newButton(
    {
        left = 0,
        top = 0,
        id = "back",
        label = "X",
        labelColor = { default={ 0, 0, 0 }, over={ 0.5, 0.5, 0.5, 0.5 } },
        onEvent = back2,
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
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene