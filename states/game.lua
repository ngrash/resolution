game = { timePlayed = 0, timeRequired = 10 }

function game:enter()
	love.mouse.setVisible(false)
end

function game:update(timeElapsed)
	self.timePlayed = self.timePlayed + timeElapsed
	if self.timePlayed >= self.timeRequired then
		switchState("win")
	end
end

function game:draw()
	local timeLeft = self.timeRequired - self.timePlayed
	local textual = secondsToCountdown(timeLeft)
	local x = (love.graphics.getWidth() * 0.5) - (fonts.countdown:getWidth(textual) * 0.5)
	local y = (love.graphics.getHeight() * 0.5) - (fonts.countdown:getHeight() * 0.5)
	love.graphics.setFont(fonts.countdown)
	love.graphics.print(textual, x, y)
end

function game:mousepressed()
	switchState("lost")
end

function game:keypressed()
	switchState("lost")
end

function game:focus()
	switchState("lost")
end