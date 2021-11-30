--Parent Class for all Car charcters
local physics = require("physics");

local Car = {tag="Car", HP=1, xPos=0, yPos=0, deltaX = 0, deltaY = 5, physicsType = "dynamic", color = "yellow", transition = nil, isShielded = false};

function Car:new (o)    --constructor
  o = o or {}; 
  setmetatable(o, self);
  self.__index = self;
  return o;
end

function Car:spawn()
	self.shape=display.newCircle(self.xPos, self.yPos,20);
	self.shape.pp = self;  -- parent object
	self.shape.tag = self.tag; 
	self.shape:setFillColor (1,1,0);
	physics.addBody(self.shape, self.physicsType, {bounce=0.3}); 
end

function Car:delete()
	if(self.shape ~= nil) then
		self.shape:removeSelf();
		self.shape = nil;
	end
end

function Car:sound()
	local soundEffect = audio.loadSound( "CarCrash.wav" ) --https://mixkit.co/free-sound-effects/crash/
	audio.play( soundEffect )
end

function Car:powerupsound()
	local soundEffect2 = audio.loadSound( "PowerUp_Sound.wav" ) --https://mixkit.co/free-sound-effects/crash/
	audio.play( soundEffect2 )
end

return Car;