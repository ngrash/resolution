require 'fonts'
require 'clock'
require 'states'

function love.load()
	--love.window.setFullscreen(true)

	-- The first line resize to fullscreen.(if the width and the height are 0, then it become of the screen resolution)
	-- The second line fix a bug that sometimes appear when doing the first line alone.(You can't draw anything but a background color)
	-- Source: https://love2d.org/forums/viewtopic.php?f=4&t=32721
	local flags = { fullscreen = "desktop" }
	love.window.setMode(0, 0, flags)
	love.window.setMode(love.graphics.getWidth(),love.graphics.getHeight(), flags)

	love.window.setTitle("Resolution")

	windowWidth = love.graphics.getWidth()
	windowHeight = love.graphics.getHeight()

	switchState("intro")
end

function love.update(...)
	delegate('update', ...)
end

function love.draw(...)
	delegate('draw', ...)
end

function love.mousepressed(...)
	delegate('mousepressed', ...)
end

function love.mousereleased(...)
	delegate('mousereleased', ...)
end

function love.focus(...)
	delegate('focus', ...)
end

function love.keypressed(...)
	delegate('keypressed', ...)
end

function love.keyreleased(...)
	delegate('mousereleased', ...)
end

function delegate(method, ...)
	local arg = {...}
	if states[currentState][method] ~= nil then
		states[currentState][method](states[currentState], unpack(arg))
	end
end
