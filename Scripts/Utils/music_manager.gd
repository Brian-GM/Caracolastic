extends AudioStreamPlayer2D

var songs = [
	"res://Assets/Music/Soundtrack/levels/1.mp3",
	"res://Assets/Music/Soundtrack/levels/2.mp3"
]

var current_scene_name = ""

func _process(_delta: float) -> void:
	var current_scene = get_tree().current_scene
	if not current_scene or current_scene.name == current_scene_name:
		return
	
	current_scene_name = current_scene.name
	match current_scene_name:
		"Level1","Level2","Level3","Level4":
			if playing: stop()
			play_random_song()
		"Menu":
			if playing: stop()
			play_song("res://Assets/Sounds/Music/title_song.mp3")
		_:
			stop()

func play_random_song():
	play_song(songs[randi_range(0, songs.size() - 1)])

func play_song(song_path: String):
	var audio_stream = load(song_path) as AudioStream
	if audio_stream:
		stream = audio_stream
		volume_db = -40
		play()
