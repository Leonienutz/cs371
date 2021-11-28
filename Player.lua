--Player Class. Inherits from Car class.
local Car = require("Car")
local Player = Car:new({xPos = display.contentCenterX, yPos = display.contentHeight - 50, deltaY = 0, deltaX = 10, tag = "Player", physicsType = "kinematic"});


local opt =
{
frames = {
      --idle pose-
      { x = 0, y = 0, width = 75, height = 130}, --frame 1 yellow
      { x = 74, y = 4, width = 81, height = 124}, --frame 2 blue
      { x = 152, y = 1, width = 80, height = 127}, --frame 3 red
      { x = 229, y = 0, width = 81, height = 128}, --frame 4 green
      { x = 306, y = 0, width = 78, height = 128}, --frame 5 purple
     
  }
}

local frameSeq = {
	{name = "normal", start = 1, count = 5, time= 300}
}
-- include sprite image sheet
local sheet = graphics.newImageSheet( "cars.png", opt);
local anim = display.newSprite (sheet, frameSeq);		
function Player:spawn()
		self.shape = anim;
		self.shape:setSequence("normal");
		self.shape.xScale = 0.5;
		self.shape.yScale = 0.5;
		if(self.color == "yellow") then
			self.shape:setFrame(1);
		elseif(self.color == "blue") then
			self.shape:setFrame(2)
		elseif(self.color == "red") then
			self.shape:setFrame(3)
		elseif(self.color == "green") then
			self.shape:setFrame(4)
		elseif(self.color == "purple") then
			self.shape:setFrame(5)
		end
		self.shape.pp = self;  
		self.shape.tag = self.tag; 
		self.shape.x = self.xPos;
		self.shape.y = self.yPos;
		--self.outline = graphics.newOutline(2, sheet, 1)
	
end

function Player:setColor(color)
	if(color == "yellow") then
			self.shape:setFrame(1);
	elseif(color == "blue") then
		self.shape:setFrame(2)
	elseif(color == "red") then
		self.shape:setFrame(3)
	elseif(color == "green") then
		self.shape:setFrame(4)
	elseif(color == "purple") then
		self.shape:setFrame(5)
	end
end

function Player:moveLeft()
	self.shape.x = self.shape.x - self.deltaX;
end

function Player:moveRight()
	self.shape.x = self.shape.x + self.deltaX;
end
physics.start( );
return Player;