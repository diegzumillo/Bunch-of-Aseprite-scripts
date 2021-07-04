-- this script looks for a selection on screen. Only the origin matters, it keeps the same size. Then calls CRTview and shows it
-- if there is no selection a dialog opens up asking for the origin

local sprite = app.activeSprite
local sel = sprite.selection
local x=0
local y=0

if sel.isEmpty then
		
	local dlg = Dialog()

	dlg:label{ id="spacer_to_force_dialog_to_show_sliders",
			   label="        ",
			   text="           " }
	dlg:slider{ id="x",
				label="x:",
				min=0,
				max=sprite.width - 320,
				value=0 }
	dlg:slider{ id="y",
				label="y:",
				min=0,
				max=sprite.height - 224,
				value=0 }

	dlg:button{ id="confirm", text="Confirm", focus=true }

	dlg:show()
	x = dlg.data.x
	y = dlg.data.y
else
	x = sel.origin.x
	y = sel.origin.y
end


-- Use path to your crtview.exe
prog = "C:\\gamedev\\crtview-win_1_2\\crtview.exe"


local path = app.fs.filePath(sprite.filename)
local sep = app.fs.pathSeparator

sprite:saveCopyAs(path..sep.."temp.png") --creating a copy of the current sprite
local newsprite = Sprite{fromFile=path..sep.."temp.png"} --opening it
newsprite:crop(x,y,320,224) --cropping it
newsprite:saveCopyAs(path..sep.."temp.png") --saving it again

--Call the program on the temp file
os.execute(prog.." "..path..sep.."temp.png")

newsprite:close() --now closing the newly created and edited file. Optionally we could delete it.