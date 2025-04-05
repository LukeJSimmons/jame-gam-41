extends Node3D

@onready var enemy = preload("res://scenes/enemy/enemy.tscn")

func _on_timer_timeout() -> void:
	var new_enemy = enemy.instantiate()
	new_enemy.position = position
	get_parent().add_child(new_enemy)
