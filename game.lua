local class = require 'middleclass'
local stateful = require 'stateful'

-- game class
Game = class('Game')
Game:include(stateful)