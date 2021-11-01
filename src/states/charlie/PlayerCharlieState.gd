# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.

# Essentially, it is used to not "owner" everywhere and instead write "player" which can autocomplete when code writing
class_name PlayerCharlieState
extends State

var player: PlayerCharlieBattleMode


func _ready() -> void:
	yield(owner, "ready")
	player = owner as PlayerCharlieBattleMode
	assert(player != null)
