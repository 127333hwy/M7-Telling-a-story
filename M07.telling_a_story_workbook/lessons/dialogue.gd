extends Control

@onready var rich_text_label: RichTextLabel = %RichTextLabel
@onready var next_button: Button = %NextButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var body: TextureRect = %Body
@onready var expression: TextureRect = %expression


var expressions := {
	"happy": preload("res://assets/emotion_happy.png"),
	"regular": preload("res://assets/emotion_regular.png"),
	"sad": preload("res://assets/emotion_sad.png"),
}

var dialogue_items: Array[Dictionary] =[
	{
		"expression": expressions["regular"],
	"text": "Hello^^",
	},
	{
		"expression": expressions["sad"],
		"text":"I don't think I'll finish my work on time TT",
	},
	{
		"expression": expressions["happy"],
		"text": "but I signed up for flex time for extra work time!",
	},
	{
		"expression": expressions["regular"],
		"text": "hopefully I'll get it done on time",
	},
	{
		"expression": expressions["happy"],
		"text": "HEHEHE Byebye~~",
	},
]

var current_item_index :=0
func show_text() -> void:
	var current_item :=dialogue_items[current_item_index]
	rich_text_label.text = current_item["text"]
	expression.texture = current_item["expression"]
	rich_text_label.visible_ratio = 0.0
	var tween := create_tween()
	var text_appearng_duration := 1.2
	tween.tween_property(rich_text_label, "visible_ratio", 1.0, text_appearng_duration)
	var sound_max_offset := audio_stream_player.stream.get_length() - text_appearng_duration
	var sound_start_position:= randf() * sound_max_offset
	audio_stream_player.play(sound_start_position)
	tween.finished.connect(audio_stream_player .stop)

func advance() -> void:
	current_item_index += 1
	if current_item_index == dialogue_items.size():
		get_tree().quit()
	else:
		show_text()

func _ready() -> void:
	show_text()
	next_button.pressed.connect(advance)
	
