--Player Class. Inherits from Car class.
local Car = require("Car")
local Player = Car:new({xPos = display.contentCenterX, yPos = display.contentHeight - 50, deltaY = 0, deltaX = 10, tag = "Player", physicsType = "kinematic", hp = 3});


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
local opt2 =
{
frames = {
      --idle pose-
       { x = 175, y = 190, width = 28, height = 34}, --frame 0 yellow
      { x = 0, y = 0, width = 59, height = 58}, --frame 1 yellow
      { x = 61, y = 0, width = 59, height = 58}, --frame 2 blue
      { x = 122, y = 0, width = 59, height = 58}, --frame 3 red
      { x = 185, y = 0, width = 59, height = 58}, --frame 4 green
      { x = 0, y = 65, width = 59, height = 58}, --frame 5 purple
     { x = 61, y = 65, width = 59, height = 58}, --frame 6 purple
     { x = 122, y = 65, width = 59, height = 58},--frame 7 purple
     { x = 185, y = 65, width = 59, height = 58},--frame 8 purple
     { x = 0, y = 130, width = 59, height = 58},--frame 9 purple
     { x = 61, y = 130, width = 59, height = 58},--frame 10 purple
     { x = 122, y = 130, width = 59, height = 58},--frame 11 purple
     { x = 185, y = 130, width = 59, height = 58},--frame 12 purple
     { x = 0, y = 190, width = 59, height = 58},--frame 13 purple
     { x = 61, y = 190, width = 59, height = 58},--frame 14 purple
     { x = 122, y = 190, width = 59, height = 58},--frame 15 purple
     { x = 185, y = 190, width = 59, height = 58},--frame 16 purple
     { x = 175, y = 190, width = 28, height = 34}, --frame 17 yellow
  }
}
local sheet2 = graphics.newImageSheet( "exp2.png", opt2);

local frameSeq2 = {
	{name = "explode", start = 1, count = 18, time= 300, loopCount = 1}
}
local anim2 = display.newSprite(sheet2,frameSeq2);
local opt3 =
{
frames = {
      --idle pose-
      { x = 60, y = 175, width = 173, height = 166}, --frame 0 blank
      { x = 24, y = 344, width = 200, height = 200}, --frame 1 green
      { x = 274, y = 344, width = 200, height = 200}, --frame 2 red
      { x = 60, y = 175, width = 173, height = 166}, --frame 3 blank
      { x = 524, y = 344, width = 200, height = 200}, --frame 3 blue
      
  }
}

local frameSeq3 = {
	{name = "powers", start = 4,count = 1, time= 1000, loop = 3}
}

local sheet3 = graphics.newImageSheet( "powerupspritesheet.png", opt3);
local anim3 = display.newSprite (sheet3, frameSeq3);


-- include sprite image sheet
local sheet = graphics.newImageSheet( "cars.png", opt);
local anim = display.newSprite (sheet, frameSeq);		
function Player:spawn()
		self.shape = anim;
		self.shape:setSequence("normal");
		--local joutline = graphics.newOutline(2, sheet, frameSeq);
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
		self.shape.isShielded = self.isShielded;
		anim2.y = self.shape.y - 50
		--Collision Stuff
		physics.addBody(self.shape, self.physicsType, {shape = {-15, -28,  15, -28,  15, 28,  -15, 28--[[joutline]]}} )
		
		local function playerCollision(event)
			if(event.phase == "began") then
				print("I hit Something!")
				
				if(event.other.tag == "Enemy") then
					print("I hit enemy!")
					self:sound();
					anim2.x = event.target.x
					anim2:setSequence("explode");
					anim2:play();
					if(self.shape.isShielded == false) then
						self.hp = self.hp - 1;
					end
					if(self.shape.isShielded == true) then
						print("Shielded")
					end
					HitPoints = self.hp;

					-- if(self.hp == 0) then
						-- self:delete();
					-- end
				end
				if(event.other.tag == "addTime") then
					print("I hit addTime Power-up!")
					score = score + 10;
					secondsLeft = secondsLeft - 5;
					self:powerupsound();
					anim2.x = event.target.x
					--anim2:setSequence("explode");
					--anim2:play();
					
					--self:delete();
				end
				if(event.other.tag == "addHeart") then
					print("I hit addHeart Power-up!")
					score = score + 1;
					self:powerupsound();
					anim2.x = event.target.x
					self.hp = self.hp + 1;
					HitPoints = self.hp;
					--anim2:setSequence("explode");
					--anim2:play();
					
					--self:delete();
				end
				if(event.other.tag == "addShield") then
					print("I hit addShield Power-up!")
					score = score + 1;
					self:powerupsound();
					self.shape.isShielded = true;
					anim2.x = event.target.x
					
					anim3.xScale = 0.50;
					anim3.yScale = 0.50
					anim3.x = self.shape.x
					anim3.y = self.shape.y
					anim3:setSequence("powers");
    					anim3:play();					
					local function listener( event )
    						print( "shield gone" )
    						self.shape.isShielded = false;
    						anim3:setSequence("powers");
    						anim3:play();
					end
					timer.performWithDelay(2000, listener)
					--anim2:setSequence("explode");
					--anim2:play();
					
					--self:delete();
				end
			end
		end
		self.shape:addEventListener("collision", playerCollision);
		
	
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
	anim3.x = self.shape.x
end

function Player:moveRight()
	self.shape.x = self.shape.x + self.deltaX;
	anim3.x = self.shape.x
end
physics.start( );
return Player;