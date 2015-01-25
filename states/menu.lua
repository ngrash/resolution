menu = { buttonWidth = 200, buttonHeight = 70, buttonMargin = 10 }

buttons = {
	{ text = "Beginner", timeRequired = 15 * 60 },
	{ text = "Advanced", timeRequired = 1 * 3600 },
	{ text = "Expert", timeRequired = 24 * 3600 }
}

function menu:enter()
	love.mouse.setVisible(true)
end

function menu:update()
	for index, button in pairs(buttons) do
		buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		buttonY = (self.buttonHeight * index) + (self.buttonMargin) * index

		mouseX, mouseY = love.mouse.getPosition()

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
	love.graphics.print("Resolution")

	love.graphics.setFont(fonts.button)
	for index, button in pairs(buttons) do
		buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		buttonY = (self.buttonHeight * index) + (self.buttonMargin) * index

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

function menu:mousepressed(mouseX, mouseY)
	for index, button in pairs(buttons) do
		buttonX = (windowWidth / 2) - (self.buttonWidth / 2)
		buttonY = (self.buttonHeight * index) + (self.buttonMargin) * index

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
			game.timeRequired = button.timeRequired
			switchState("game")
		end
	end
end