require 'fonts'
require 'clock'
require 'states'

function love.load()
	love.window.setFullscreen(true)
	love.window.setTitle("Resolution")

	windowWidth = love.window.getWidth()
	windowHeight = love.window.getHeight()

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