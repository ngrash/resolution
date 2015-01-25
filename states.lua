require 'states/menu'
require 'states/intro'
require 'states/game'
require 'states/win'
require 'states/lost'

states = {}
states["menu"] = menu
states["intro"] = intro
states["game"] = game
states["win"] = win
states["lost"] = lost

function switchState(state)
	if states[state]["enter"] ~= nil then
		states[state]:enter()
	end
	
	currentState = state
end