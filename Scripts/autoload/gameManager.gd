extends Node


enum GameState {MENU, PLAYING, PAUSED, GAME_OVER, VICTORY}

signal s_GameStateChanged(new_state: GameState)
signal s_GameStarted
signal s_GameOver(victory: bool)
signal s_WaveCompleted

#var currectState: GameState = GameState.MENU
var currectState: GameState = GameState.PLAYING


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventKey and  event.is_pressed():
		match event.keycode:
			KEY_ESCAPE when currectState == GameState.PLAYING:
				gamePased()
			KEY_ESCAPE when currectState == GameState.PAUSED:
				gameResume()
			_:
				pass
	pass

func gameStart() -> void:
	currectState = GameState.PLAYING
	s_GameStarted.emit()
	s_GameStateChanged.emit(currectState)

func gamePased() -> void:
	currectState = GameState.PAUSED
	get_tree().paused = true
	s_GameStateChanged.emit(currectState)

func gameResume() -> void:
	currectState = GameState.PLAYING
	get_tree().paused = false
	s_GameStateChanged.emit(currectState)

func gameEnd(victory: bool) -> void:
	currectState = GameState.VICTORY if victory else GameState.GAME_OVER
	s_GameOver.emit(victory)
	s_GameStateChanged.emit(currectState)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
