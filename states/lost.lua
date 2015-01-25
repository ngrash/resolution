lost = {
	text = {
		"You did not make it :(",
		"Believe in yourself and you will keep up next time!",
		"",
		"",
		"Press ESC to quit",
		"",
		"Press any key to return to the menu" 
	}
}

function lost:enter()
	love.graphics.setFont(fonts.text)
end

function lost:draw()
	local linesTotalHeight = fonts.text:getHeight() * #self.text
	local textOffsetY = love.graphics.getHeight() * 0.5 - linesTotalHeight * 0.5

	for index, line in pairs(self.text) do
		love.graphics.print(line, love.window.getWidth() * 0.5 - fonts.text:getWidth(line) * 0.5, textOffsetY + fonts.text:getHeight() * (index - 1))
	end
end

function lost:keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	else
		switchState("menu")
	end
end

function lost:mousepressed()
	switchState("menu")
end