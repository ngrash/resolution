win = {}

function win:enter()
	love.graphics.setFont(fonts.text)
end

function win:draw()
	love.graphics.print("You made it! Be proud of yourself!")

	love.graphics.print("Press ESC to quit")
	love.graphics.print("Press any key to return to the menu")
end

function win:keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	else
		switchState("menu")
	end
end

function win:mousepressed()
	switchState("menu")
end