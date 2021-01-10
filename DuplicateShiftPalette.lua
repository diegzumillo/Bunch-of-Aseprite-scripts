
local pal = app.activeSprite.palettes[1]

for i=0, 15, 1 do
	pal:setColor(i+128, pal:getColor(i))
end
