local composer = require( "composer" )
local scene = composer.newScene()
 local GlobalMusic = audio.loadStream( "GlobalMusic.wav" )
 audio.setVolume( 0.35, { channel=1 } )
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
   local backgroundMusicChannel = audio.play( GlobalMusic, { channel=1, loops=-1, fadein=5000} )

   local bg = display.newImage ("bgmain.jpg", display.contentCenterX, display.contentCenterY);
   bg.xScale = display.contentWidth / bg.width; 
   bg.yScale = display.contentHeight / bg.height;
   sceneGroup:insert(bg)
   -- Create the menu buttons
   -- button to start playing the game
   local playButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY -50, 230, 60, 12);
   playButton:setFillColor(0.75, 0.09, 0.09)
   sceneGroup:insert(playButton);

   -- button to get to the options menu
   local optionsButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY +50, 230, 60, 12);
   optionsButton:setFillColor(0.1, 0.8, 0.1)
   sceneGroup:insert(optionsButton);

   -- button to get to the leaderboard
   local leaderboardButton = display.newRoundedRect(display.contentCenterX, display.contentCenterY +150, 230, 60, 12);
   leaderboardButton:setFillColor(0.4, 0.57, 0.85)
   sceneGroup:insert(leaderboardButton);

   -- display text
   local header = display.newText("HIGHWAY MADNESS", display.contentCenterX, display.contentCenterY -180, native.systemFont, 26 )
   sceneGroup:insert(header);
   local playText = display.newText("PLAY", display.contentCenterX, display.contentCenterY -50, native.systemFont, 26 )
   sceneGroup:insert(playText);
   local optionsText = display.newText("OPTIONS", display.contentCenterX, display.contentCenterY +50, native.systemFont, 26 )
   sceneGroup:insert(optionsText);
   local leaderboardText = display.newText("LEADERBOARD", display.contentCenterX, display.contentCenterY +150, native.systemFont, 26 )
   sceneGroup:insert(leaderboardText);

   -- function to start the game
   local function startGame (event)
      composer.gotoScene("scene2", {
         effect = "fade",
         time = 100
      });
   end
   playButton:addEventListener("tap", startGame);

   -- function to get to the options menu
   local function options (event)
      composer.gotoScene("scene3", {
         effect = "fade",
         time = 100,
      });
   end
   optionsButton:addEventListener("tap", options);

   -- function to get to the leaderboard
   local function leaderboard (event)
      composer.gotoScene("scene4", {
         effect = "fade",
         time = 100,
      });
   end
   leaderboardButton:addEventListener("tap", leaderboard);
end
 
-- "scene:show()"
function scene:show( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   elseif ( phase == "did" ) then
   end
end
 
-- "scene:hide()"
function scene:hide( event )
 
   local sceneGroup = self.view
   local phase = event.phase
 
   if ( phase == "will" ) then
   elseif ( phase == "did" ) then
   end
end
 
-- "scene:destroy()"
function scene:destroy( event )
   local sceneGroup = self.view
end
 
---------------------------------------------------------------------------------
 
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
---------------------------------------------------------------------------------
 
return scene