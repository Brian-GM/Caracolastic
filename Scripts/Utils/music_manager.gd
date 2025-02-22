extends AudioStreamPlayer2D

var songs = [
	"res://Assets/Music/Soundtrack/levels/CaracolSong.wav",
]

var current_scene_name = ""

func _process(_delta: float) -> void:
	var current_scene = get_tree().current_scene
	if not current_scene or current_scene.name == current_scene_name:
		return
	
	current_scene_name = current_scene.name
	match current_scene_name:
		"Level1","Level2","Level3","Nivel4":
			if playing: stop()
			play_random_song()
		"Menu","Settings":
			if !playing:
				play_song("res://Assets/Music/Soundtrack/levels/CaracolSong.wav")
			
		_:
			stop()

func play_random_song():
	play_song(songs[randi_range(0, songs.size() - 1)])

func play_song(song_path: String):
	var audio_stream = load(song_path) as AudioStream
	if audio_stream:
		stream = audio_stream
		play()
