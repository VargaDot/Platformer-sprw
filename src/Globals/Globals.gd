extends Node

### Game variables
var is_new_game: bool = true

var game: Game
var level: int = 1

var player: Player
var player_health: int = 3
var end_player_health: int = 3

var level_score: int = 0
var level_coins: int = 0
var level_time: int = 0
var level_kills: int = 0

var total_time: float = 0
var total_score: int = 0
var total_kills: int = 0
var total_deaths: int = 0

var menu_theme: AudioStreamPlayer
var game_theme: AudioStreamPlayer
var button_click: AudioStreamPlayer

var _current_game_theme: String = ""

### Speedrun
var start_time: float = 0.0
var level_speedrun_times: Dictionary = {
	1: 0.000,
	2: 0.000,
	3: 0.000,
	4: 0.000,
	5: 0.000,
	6: 0.000,
}

### Settings
var is_alternative_ost: bool = false
var is_speedrun_mode: bool = false

var master_volume: float = 100.0
var music_volume: float = 100.0
var sfx_volume: float = 100.0

func new_game() -> void:
	_current_game_theme = ""

	end_player_health = 3

	is_new_game = true
	level = 1

	level_coins = 0
	level_kills = 0
	level_score = 0
	level_time = 0

	total_deaths = 0
	total_kills = 0
	total_score = 0
	total_time = 0

func new_level() -> void:
	_current_game_theme = ""

	end_player_health = 3

	level_coins = 0
	level_kills = 0
	level_score = 0
	level_time = 0

	total_deaths = 0
	total_kills = 0
	total_score = 0
	total_time = 0
	is_new_game = false

func reset_level() -> void:
	level_coins = 0
	level_kills = 0
	level_score = 0
	level_time = 0

func set_game_theme() -> void:
	Globals.game_theme.pitch_scale = 1
	print(_current_game_theme)

	if _current_game_theme == "":
		if is_alternative_ost:
			_current_game_theme = "res://assets/audio/Levels/level" + str(level) + "Aggressive.mp3"
		else:
			_current_game_theme = "res://assets/audio/Levels/level" + str(level) + ".mp3"

		game_theme.stream = load(_current_game_theme)
		game_theme.play()
	else:
		var new_game_theme: String
		if is_alternative_ost:
			new_game_theme = "res://assets/audio/Levels/level" + str(level) + "Aggressive.mp3"
		else:
			new_game_theme = "res://assets/audio/Levels/level" + str(level) + ".mp3"

		if _current_game_theme != new_game_theme:
			_current_game_theme = new_game_theme

			game_theme.stop()
			game_theme.stream = load(_current_game_theme)
			game_theme.play()
		else:
			if not game_theme.playing:
				game_theme.play()

func go_to_with_fade(scene: String) -> void:
	var transition: Node = Composer.setup_load_screen("res://src/Composer/LoadingScreens/Fade/FadeScreen.tscn")

	if transition:
		button_click.play()
		await transition.finished_fade_in
		Composer.load_scene(scene)

func go_to_with_zigzag(scene: String) -> void:
	var transition: ZigZag = Composer.setup_load_screen("res://src/Composer/LoadingScreens/ZigZag/ZigZagScreen.tscn")

	if transition:
		button_click.play()
		await transition.finished_moving
		Composer.load_scene(scene)
