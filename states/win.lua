win = {
	quotes = {
		{ quote = "Act the way you’d like to be and soon you’ll be the way you’d like to act.", author = "Bob Dylan" }
	},
	text = {
		"You made it! Be proud of yourself!",
		"",
		"",
		"Press ESC to quit",
		"",
		"Press any key to return to the menu" 
	}
}

function win:enter()
	love.graphics.setFont(fonts.text)
end

function win:draw()
	local linesTotalHeight = (fonts.text:getHeight() * #self.text)
	local buttonOffsetY = (love.graphics.getHeight() * 0.5) - (linesTotalHeight * 0.5)

	for index, line in pairs(self.text) do
		love.graphics.print(line, (love.graphics.getWidth() * 0.5) - (fonts.text:getWidth(line) * 0.5), buttonOffsetY + (fonts.text:getHeight() * (index - 1)))
	end
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