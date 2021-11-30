--Enemy Car Class
local Car = require("Car")

local addTime = Car:new({xPos = display.contentCenterX, yPos = -50, deltaY = 10, deltaX = 0, tag = "addTime", physicsType = "dynamic"}); 
--NOTE: Maybe could make as a "static" type so we dont have to worry about gravity
local opt =
{
frames = {
      --idle pose-
      { x = 24, y = 344, width = 200, height = 200}, --frame 1 green
      { x = 274, y = 344, width = 200, height = 200}, --frame 2 red
      { x = 524, y = 344, width = 200, height = 200}, --frame 3 blue
  }
}

local frameSeq = {
	{name = "powers", start = 1, count = 3, time= 300}
}

	
function addTime:spawn(grp)
		local sheet = graphics.newImageSheet( "powerupspritesheet.png", opt);
		local anim = display.newSprite (sheet, frameSeq);
		--local joutline = graphics.newOutline(2, sheet, frameSeq);
		self.shape = anim;
		self.shape:setSequence("powers");
		self.shape.xScale = 0.15;
		self.shape.yScale = 0.15;
		
		--Set Color of the image
		self.shape:setFrame(1);

		--set SPAWN POINT
		mySpawnPoint = math.random(1,3);
		if(mySpawnPoint == 1) then
			self.xPos = 90;
		elseif(mySpawnPoint == 2) then
			self.xPos = 170;
		elseif(mySpawnPoint == 3) then
			self.xPos = 250;
		end
		self.shape.pp = self;  
		self.shape.tag = self.tag; 
		self.shape.x = self.xPos;
		self.shape.y = self.yPos;
		
		if grp then grp:insert(self.shape) end
		
		physics.addBody(self.shape, self.physicsType,{shape = {-10, -10,  10, -10,  10, 10,  -10, 10--[[joutline]]}} )
		physics.setGravity(0, 0)
		local function enemyCollision(event)
			if(event.phase == "began") then
				if(event.other.tag == "Player") then
					transition.cancel( self.transition )
					self:delete();
				end
			end
		end
		self.shape:addEventListener("collision", enemyCollision);
		
		 return self.shape
		--self.outline = graphics.newOutline(2, sheet, 1)
	
end

function addTime:Fall()
	self.transition = transition.to(self.shape, { time=2500, x=self.shape.x, y=display.contentHeight}) --good speed 1500
self.transition._onComplete = function () self:delete() --[[score= score + 1]] end
end

physics.start( );
return addTime;
