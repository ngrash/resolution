game = { timePlayed = 0, timeRequired = 10 }

function game:update(timeElapsed)
	self.timePlayed = self.timePlayed + timeElapsed
	if self.timePlayed >= self.timeRequired then
		switchState("win")
	end
end

function game:draw()
	love.graphics.print("Now step away from your computer")
	local timeLeft = self.timeRequired - self.timePlayed
	local textual = ""
	if timeLeft > 1800 then
		textual = math.ceil(timeLeft / 60 / 60)
		if timeLeft > 3600 then
			textual = textual.." hours"
		else
			textual = textual.." hour"
		end
	elseif timeLeft > 10 then
		textual = math.ceil(timeLeft / 60)
		if timeLeft > 120 then
			textual = textual.." minutes"
		else
			textual = textual.." minute"
		end
	else 
		textual = math.ceil(timeLeft)
		if timeLeft > 1 then
			textual = textual.." seconds"
		else
			textual = textual.." second"
		end
	end

	love.graphics.print(textual, 0, 20)
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