intro = { 
	number_of_particle_systems = 7,
	particle_systems = {},
	delays = {},
	colors = {
		love.graphics.newImage("assets/red_pixel.png"),
		love.graphics.newImage("assets/green_pixel.png"),
		love.graphics.newImage("assets/blue_pixel.png")	
	}
}

intro.particles_prototype = love.graphics.newParticleSystem(intro.colors[1], 1000)
intro.particles_prototype:setSizes(1, 7, 1)
intro.particles_prototype:setParticleLifetime(1, 1.1)
intro.particles_prototype:setEmissionRate(1000)
intro.particles_prototype:setEmitterLifetime(0.1)
intro.particles_prototype:setRadialAcceleration(50, 100)
intro.particles_prototype:setLinearAcceleration(-100, -100, 100, 100);

function intro:update(timeElapsed)
	for index = 1, self.number_of_particle_systems do
		if self.particle_systems[index] == nil then
			self.particle_systems[index] = self.particles_prototype:clone()
			self.particle_systems[index]:stop()
		end

		if self.particle_systems[index]:isStopped() and (self.delays[index] == nil or self.delays[index] <= 0) then
			self.particle_systems[index]:setImage(intro.colors[math.random(#intro.colors)])
			self.particle_systems[index]:setPosition(math.random(love.graphics.getWidth()), math.random(love.graphics.getHeight()))
			self.particle_systems[index]:start()
			self.delays[index] = math.random(10) * 0.5;
		end

		self.delays[index] = self.delays[index] - timeElapsed
		self.particle_systems[index]:update(timeElapsed)
	end
end

function intro:draw()
	for _, particles in pairs(self.particle_systems) do
		love.graphics.draw(particles)
	end
end