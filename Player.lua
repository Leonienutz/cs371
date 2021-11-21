--Player Class. Inherits from Car class.
local Car = require("Car")
local Player = Car:new({xPos = display.contentCenterX, yPos = display.contentHeight - 50, deltaY = 0, tag = "Player", physicsType = "kinematic"});


local opt =
{
frames = {
      --idle pose-
      { x = 0, y = 0, width = 75, height = 130}, --frame 1 yellow
      { x = 74, y = 4, width = 81, height = 124}, --frame 1 blue
      { x = 152, y = 1, width = 80, height = 127}, --frame 1 red
      { x = 229, y = 0, width = 81, height = 128}, --frame 1 green
      { x = 306, y = 0, width = 78, height = 128}, --frame 1 purple
     
  }
}
-- include sprite image sheet
local sheet = graphics.newImageSheet( "cars.png", opt);
			
function Player:spawn()
		if(self.color == "yellow") then
			self.shape = display.newImage(sheet, 1);
		elseif(self.color == "blue") then
			self.shape = display.newImage(sheet, 2);
		elseif(self.color == "red") then
			self.shape = display.newImage(sheet, 3);
		elseif(self.color == "green") then
			self.shape = display.newImage(sheet, 4);
		elseif(self.color == "purple") then
			self.shape = display.newImage(sheet, 5);
		end
		self.shape.pp = self;  
		self.shape.tag = self.tag; 
		self.shape.x = self.xPos;
		self.shape.y = self.yPos;
		--self.outline = graphics.newOutline(2, sheet, 1)
	
end


physics.start( );
return Player;