extends Control

onready var globals = $"/root/Globals"

func _ready():
	$ColorRect.color =  Color( 1, 1, 0, 1 )

func _process(_delta):
	if globals.active_player == "yellow":
		$ColorRect.color =  Color( 1, 1, 0, 1 )
	if globals.active_player == "green":
		$ColorRect.color = Color( 0, 1, 0, 1 )
