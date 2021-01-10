


local cel = app.activeCel
local cx0 = cel.position.x
local cy0 = cel.position.y
local cx1 = cel.bounds.width + cx0
local cy1 = cel.bounds.height + cy0


local curImg = cel.image


function PutPixel(x,y,c)
	app.useTool{
		tool="pencil",
		color=Color(c),
		brush=Brush(),
		points={ Point (x,y) },
		cel=cel,
		layer=cel.layer,
		frame=cel.frame
	}
end


for tx = 0, cx1, 8 do
	for ty = 0, cy1, 8 do
		--check if this tile has anything
		local present = false
		for x = tx, tx+7, 1 do
			for y = ty, ty + 7, 1 do
				if( x >= cx0 and y >= cy0 and x < cx1 and y < cy1) then
					if(curImg:getPixel(x-cx0,y-cy0)>0) then
						present = true
						break
					end
				end
			end
			if(present)then
				break
			end
		end
		
		if(present)then
			--process this tile
			for x = tx, tx + 7, 1 do
				for y = ty, ty + 7, 1 do
					if( x >= cx0 and y >= cy0 and x < cx1 and y < cy1) then
						if(curImg:getPixel(x-cx0,y-cy0)<16)then
							PutPixel(x,y,curImg:getPixel(x-cx0,y-cy0)+128)
						end
					else 
						PutPixel(x,y,128)
					end
				end				
			end		
		end
	end
end
--app.activeCel = cel
app.refresh()