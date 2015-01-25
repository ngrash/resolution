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

currentState = "intro"

function switchState(state)
	currentState = state
end