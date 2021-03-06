--Enemy Car Class
local Car = require("Car")

local Enemy = Car:new({xPos = display.contentCenterX, yPos = -50, deltaY = 10, deltaX = 0, tag = "Enemy", physicsType = "dynamic"}); 
--NOTE: Maybe could make as a "static" type so we dont have to worry about gravity
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

	
function Enemy:spawn(grp)
		local sheet = graphics.newImageSheet( "cars.png", opt);
		local anim = display.newSprite (sheet, frameSeq);
		--local joutline = graphics.newOutline(2, sheet, frameSeq);
		self.shape = anim;
		self.shape:setSequence("normal");
		self.shape.xScale = 0.5;
		self.shape.yScale = 0.5;
		
		--Set Color of the image
		self.shape:setFrame(math.random(1, 5));

		--set SPAWN POINT
		mySpawnPoint = math.random(1,3);
		if(mySpawnPoint == 1) then
			self.xPos = 75;
		elseif(mySpawnPoint == 2) then
			self.xPos = 150;
		elseif(mySpawnPoint == 3) then
			self.xPos = 230;
		end
		self.shape.pp = self;  
		self.shape.tag = self.tag; 
		self.shape.x = self.xPos;
		self.shape.y = self.yPos;
		
		if grp then grp:insert(self.shape) end
		
		physics.addBody(self.shape, self.physicsType,{shape = {-15, -28,  15, -28,  15, 28,  -15, 28--[[joutline]]}} )
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

function Enemy:Fall()
	self.transition = transition.to(self.shape, { time=2500, x=self.shape.x, y=display.contentHeight}) --good speed 1500
self.transition._onComplete = function () self:delete() score= score + 1 end
end

physics.start( );
return Enemy;
