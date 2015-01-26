game = { 
	timePlayed = 0,
	timeRequired = 0,
	displayHint = 0,
	modes = {
		beginner = {
			timeRequired = 15 * 60,
			hints = {
				"have some tee",
				"clean up your room",
				"do your laundry"
				"take a short walk",
				"call your mother",
				"read a newspaper"
			}
		},
		advanced = {
			timeRequired = 1 * 3600,
			hints = {
				"work out",
				"read a book",
				"take a long walk",
				"cook yourself some nice meal"
			}
		},
		expert = {
			timeRequired = 24 * 3600,
			hints = {
				"go hiking"
			}
		}
	}
}

function game:enter()
	love.mouse.setVisible(false)
	self.timeRequired = self.modes[self.mode].timeRequired
	self.displayHint = 0
	self.mouseX, self.mouseY = love.mouse.getPosition()
end

function game:update(timeElapsed)
	self.timePlayed = self.timePlayed + timeElapsed
	if self.timePlayed >= self.timeRequired then
		switchState("win")
	end

	if self.displayHint > 0 then
		self.displayHint = self.displayHint - timeElapsed
	end

	local mX, mY = love.mouse.getPosition()
	if mX ~= self.mouseX and mX ~= self.mouseX then
		self.mouseX, self.mouseY = mX, mY

		if self.displayHint <= 0 then
			-- somehow the randomness is broken and we have to seed it
			math.randomseed(timeElapsed)
			self.hint = self.modes[self.mode].hints[math.random(#self.modes[self.mode].hints)]
		end

		self.displayHint = 10
	end
end

function game:draw()
	local timeLeft = self.timeRequired - self.timePlayed
	local textual = secondsToCountdown(timeLeft)
	local countdownX = (love.graphics.getWidth() * 0.5) - (fonts.countdown:getWidth(textual) * 0.5)
	local countdownY = (love.graphics.getHeight() * 0.5) - (fonts.countdown:getHeight() * 0.5)
	love.graphics.setFont(fonts.countdown)
	love.graphics.print(textual, countdownX, countdownY)

	if self.displayHint > 0 and self.hint ~= nil then
		local hintOffsetY = countdownY + (fonts.countdown:getHeight())

		local text = {
			"Don't know what to do?",
			"How about you ...",
			"",
			self.hint.."?"
		}

		love.graphics.setFont(fonts.text)
		for index, line in pairs(text) do
			local hintY = hintOffsetY + (fonts.text:getHeight() * (index - 1))
			local hintX = (love.graphics.getWidth() * 0.5) - (fonts.text:getWidth(line) * 0.5)
			love.graphics.print(line, hintX, hintY)
		end

	end
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