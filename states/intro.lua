intro = { 
	numberOfParticleSystems = 7,
	particleSystems = {},
	delays = {},
	colors = {
		love.graphics.newImage("assets/red_pixel.png"),
		love.graphics.newImage("assets/green_pixel.png"),
		love.graphics.newImage("assets/blue_pixel.png")
	},
	time = 86400 - 5,
	party = false,
	lines = {
		"As the rockets rise on new year's eve",
		"you become clear that you have to change.",
		"",
		"You want to clean up your room, eat healthy,",
		"meet friends and become a better person.",
		"",
		"You know what held you back last year.",
		"You know what you have to do.",
		"You want to ...",
		"",
		"Step away from your computer."
	},
	timeBetweenLines = 1.5,
	timeTillNextLine = 2,
	displayedLines = 0
}

intro.particlesPrototype = love.graphics.newParticleSystem(intro.colors[1], 1000)
intro.particlesPrototype:setSizes(1, 7, 1)
intro.particlesPrototype:setParticleLifetime(1, 1.1)
intro.particlesPrototype:setEmissionRate(1000)
intro.particlesPrototype:setEmitterLifetime(0.1)
intro.particlesPrototype:setRadialAcceleration(50, 100)
intro.particlesPrototype:setLinearAcceleration(-100, -100, 100, 100);

function intro:enter()
	love.mouse.setVisible(false)
end

function intro:update(timeElapsed)
	self.time = self.time + timeElapsed
	if self.time >= 86400 then
		self.time = 0
		self.party = true
	end

	if self.party and self.time > 0.5 then
		if self.displayedLines < #self.lines then
			self.timeTillNextLine = self.timeTillNextLine - timeElapsed
			if self.timeTillNextLine <= 0 then
				self.timeTillNextLine = self.timeBetweenLines
				self.displayedLines = self.displayedLines + 1
				self.timeTillNextLine = self.timeBetweenLines
			end
		end

		for index = 1, self.numberOfParticleSystems do
			if self.particleSystems[index] == nil then
				self.particleSystems[index] = self.particlesPrototype:clone()
				self.particleSystems[index]:stop()
			end

			if self.particleSystems[index]:isStopped() and (self.delays[index] == nil or self.delays[index] <= 0) then
				self.particleSystems[index]:setImage(intro.colors[math.random(#intro.colors)])
				self.particleSystems[index]:setPosition(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight()))
				self.particleSystems[index]:start()
				self.delays[index] = math.random(10) * 0.5;
			end

			self.delays[index] = self.delays[index] - timeElapsed
			self.particleSystems[index]:update(timeElapsed)
		end
	end
end

function intro:draw()
	for _, particles in pairs(self.particleSystems) do
		love.graphics.draw(particles)
	end

	local linesTotalHeight = fonts.text:getHeight() * #self.lines
	local lineOffsetY = (love.graphics.getHeight() * 0.5) - (linesTotalHeight * 0.5)

	for line = 1, self.displayedLines do
		love.graphics.setFont(fonts.text)

		local text = self.lines[line]
		local width = fonts.text:getWidth(text)

		love.graphics.print(text, (love.graphics.getWidth() * 0.5) - (width * 0.5), lineOffsetY + (fonts.text:getHeight() * (line - 1)))
	end

	if self:all_lines_displayed() then
		local text = "Press any key to continue"
		local x = (love.graphics.getWidth() * 0.5) - (fonts.default:getWidth(text) * 0.5)
		local y = lineOffsetY + fonts.text:getHeight() * (#self.lines + 1)
		love.graphics.setFont(fonts.default)
		love.graphics.print(text, x, y)
	end

	love.graphics.setFont(fonts.alarmClock)
	love.graphics.print(secondsToClock(self.time))
end

function intro:keypressed(key)
	if (key == "escape") or self:all_lines_displayed() then
		switchState("menu")
	end
end

function intro:mousepressed()
	if self:all_lines_displayed() then
		switchState("menu")
	end
end

function intro:all_lines_displayed()
	return self.displayedLines == #self.lines
end