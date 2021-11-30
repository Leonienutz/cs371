local composer = require( "composer" )
local scene = composer.newScene()
local csv = require("csv");
---------------------------------------------------------------------------------
-- All code outside of the listener functions will only be executed ONCE
-- unless "composer.removeScene()" is called.
---------------------------------------------------------------------------------
 
-- local forward references should go here

---------------------------------------------------------------------------------
 
-- "scene:create()"
function scene:create( event )
 
   local sceneGroup = self.view
 
   -- Initialize the scene here.
  local buttonBack = widget.newButton(
    {
        left = display.contentCenterX - 50,
        top = 10,
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

   local function back (event)
      composer.gotoScene("scene1", options);
   end

   buttonBack:addEventListener("tap", back);
   
   --Create/Open LEADERBOARD Record File ////////////////////////////////
   local path = system.pathForFile("pointsRecord.csv", system.DocumentsDirectory);
   f = csv.open(path, {separator = ",", header = true});
   if(f == nil) then
		print("Making new CSV file")
		local file = io.open(path, "w");
		file:write("NAME, POINTS,\nJim, 2000")
		file:write("\nVic, 1800")
		io.close(file)
		file = nil;
		f = csv.open(path, {separator = ",", header = true});
		--print("f equals: " .. f);
		print(path);
   end
   
   --Create LeaderBoard GUI ///////////////////////////////////
   local leaderBoardText = display.newText("LEADERBOARD", display.contentCenterX, display.contentCenterY -100, native.systemFont, 30 )
   sceneGroup:insert(leaderBoardText);
   

   
   --Print sorted entries
   local counter = 1;
   for record in f:lines() do
		local recordName = display.newText(record.NAME, display.contentCenterX - 60, display.contentCenterY -80 + (20*counter), native.systemFont, 20 )
		local recordPoints = display.newText(record.POINTS, display.contentCenterX + 60, display.contentCenterY -80 + (20*counter), native.systemFont, 20 )
		sceneGroup:insert(recordName);
		sceneGroup:insert(recordPoints);
		counter = counter + 1;
   end
   
   
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
