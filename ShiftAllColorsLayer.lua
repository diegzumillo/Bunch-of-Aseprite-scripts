


-- -- select second layer
-- for i,layer in ipairs(app.activeSprite.layers) do
-- 	if(layer.stackIndex==2)then
-- 		app.activeCel = layer:cel(1);
-- 	end
-- end



-- local cel = app.activeCel
local cel = app.activeLayer:cel(1)
local cx0 = cel.position.x
local cy0 = cel.position.y
local cx1 = cel.bounds.width + cx0 
local cy1 = cel.bounds.height + cy0 


local curImg = cel.image
local imgclone = curImg:clone()

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


function ProcessImage()

	for tx = 0, cx1+cx0, 8 do
		for ty = 0, cy1+cy0, 8 do
			--check if this tile has anything
			local present = false
			
			for x = tx, tx+7, 1 do
				for y = ty, ty + 7, 1 do
					if( x >= cx0 and y >= cy0 and x < cx1 and y < cy1) then
						if(imgclone:getPixel(x-cx0,y-cy0)>0) then
							present = true
							-- print("tile present in "..x..", "..y..": "..imgclone:getPixel(x-cx0,y-cy0))
							-- print("tx: "..tx..", ty: "..ty)
							
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
				for xx = tx, tx + 7, 1 do
					for yy = ty, ty + 7, 1 do
						if( xx >= cx0 and yy >= cy0 and xx < cx1 and yy < cy1) then
							
							if(imgclone:getPixel(xx-cx0,yy-cy0)>0) then
								PutPixel(xx,yy, imgclone:getPixel(xx-cx0,yy-cy0)+128)
														
							else								
								PutPixel(xx,yy,128)
							end
						else							
							PutPixel(xx,yy,128)							
						end
						
					end				
				end		
			end
		end
		
	end
	
end


app.transaction(	
	function()
		ProcessImage()
	end
)

