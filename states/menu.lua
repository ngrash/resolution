menu = { buttonWidth = 200, buttonHeight = 70, buttonMargin = 10 }

buttons = {
	{ text = "Beginner", mode = "beginner" },
	{ text = "Advanced", mode = "advanced" },
	{ text = "Expert", mode = "expert" }
}

function menu:enter()
	love.mouse.setVisible(true)
end

function menu:update()
	local buttonOffsetY = self:getButtonOffsetY()

	for index, button in pairs(buttons) do
		local buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		local buttonY = buttonOffsetY + (self.buttonHeight * (index - 1)) + (self.buttonMargin * (index - 1))

		local mouseX, mouseY = love.mouse.getPosition()

		if mouseX > buttonX and mouseX < buttonX + self.buttonWidth and
		   mouseY > buttonY and mouseY < buttonY + self.buttonHeight then

			button.mouseOver = true
	   	else
	   		button.mouseOver = false
	   	end
	end
end

function menu:draw()
	love.graphics.setFont(fonts.title)
	love.graphics.print("Resolution", 10, 0)

	local buttonOffsetY = self:getButtonOffsetY()

	love.graphics.setFont(fonts.button)
	for index, button in pairs(buttons) do
		local buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		local buttonY = buttonOffsetY + (self.buttonHeight * (index - 1)) + (self.buttonMargin * (index - 1))

		if button.selected then
			love.graphics.setColor(0, 200, 100)
			love.graphics.rectangle("fill", buttonX, buttonY, self.buttonWidth, self.buttonHeight)			
		elseif button.mouseOver then
			love.graphics.setColor(0, 100, 200)
			love.graphics.rectangle("fill", buttonX, buttonY, self.buttonWidth, self.buttonHeight)			
		end

		love.graphics.setColor(255, 255, 255)
		love.graphics.rectangle("line", buttonX, buttonY, self.buttonWidth, self.buttonHeight)

		love.graphics.setFont(fonts.button)
		local buttonTextWidth = fonts.button:getWidth(button.text)
		love.graphics.print(button.text, (windowWidth * 0.5) - (buttonTextWidth * 0.5), buttonY + (self.buttonHeight * 0.5) - (fonts.button:getHeight() * 0.5))
	end
end

function menu:keypressed(key)
	if key == "escape" then
		love.event.push("quit")
	end
end

function menu:mousepressed(mouseX, mouseY)
	local buttonOffsetY = self:getButtonOffsetY()

	for index, button in pairs(buttons) do
		local buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		local buttonY = buttonOffsetY + (self.buttonHeight * (index - 1)) + (self.buttonMargin * (index - 1))

		if mouseX > buttonX and mouseX < buttonX + self.buttonWidth and
		   mouseY > buttonY and mouseY < buttonY + self.buttonHeight then
			
			button.selected = true
		else
			button.selected = false
		end
	end
end

function menu:mousereleased()
	for index, button in pairs(buttons) do
		if button.selected then
			button.selected = false
			game.mode = button.mode
			switchState("game")
		end
	end
end

function menu:getButtonOffsetY()
	local groupHeight = (self.buttonHeight * #buttons) + (self.buttonMargin * (#buttons - 1))
	local buttonOffsetY = (love.graphics.getHeight() * 0.5) - (groupHeight * 0.5)
	return buttonOffsetY
end