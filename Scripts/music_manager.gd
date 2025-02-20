#extends Node
#
#@export var music_dict: Dictionary = {
	#"MainMenu": "res://music/main_menu.ogg",
	#"Level1": "res://music/level1.ogg",
	#"Level2": "res://music/level2.ogg",
	#"Level3": "res://music/level3.ogg",
	#"Level4": "res://music/level4.ogg",
	#"Level5": "res://music/level5.ogg",
	#"BossFight": "res://music/boss_fight.ogg",
	#"Victory": "res://music/victory.ogg",
	#"GameOver": "res://music/game_over.ogg",
	#"Credits": "res://music/credits.ogg"
#}
#
#var current_music: AudioStreamPlayer
#
#func _ready():
	#current_music = AudioStreamPlayer.new()
	#add_child(current_music)
	#current_music.bus = "Music"
	#_change_music(get_tree().current_scene.name)
	#get_tree().scene_changed.connect(_on_scene_changed)
#
#func _on_scene_changed(new_scene: Node):
	#_change_music(new_scene.name)
#
#func _change_music(scene_name: String):
	#if music_dict.has(scene_name):
		#var music_path = music_dict[scene_name]
		#if current_music.stream == null or current_music.stream.resource_path != music_path:
			#current_music.stream = load(music_path)
			#current_music.play()
