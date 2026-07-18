extends Node
class_name HealthComponent

signal health_changed(current: float, max: float)
signal damaged(amount: float, current: float)
signal died()

@export var max_health: float = 100.0
@export var armor: float = 0.0  # плоское снижение урона за попадание

var current_health: float

func _ready() -> void:
	current_health = max_health

## Инициализация — вызывать сразу после инстанцирования объекта
func setup(p_max_health: float, p_armor: float = 0.0) -> void:
	max_health = p_max_health
	armor = p_armor
	current_health = max_health
	health_changed.emit(current_health, max_health)

## Нанесение урона (10% урона гарантированные, если броня слишком велика)
func take_damage(amount: float) -> void:
	if current_health <= 0.0:
		return
	var reduced := maxf(amount - armor, amount * 0.1)  # минимум 10% урона проходит всегда
	current_health = maxf(current_health - reduced, 0.0)
	damaged.emit(reduced, current_health)
	health_changed.emit(current_health, max_health)
	if current_health <= 0.0:
		died.emit()

## Регенерация здоровья
func heal(amount: float) -> void:
	current_health = minf(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)

## Живой или уже скопытился
func is_alive() -> bool:
	return current_health > 0.0

## Возвращает количество ХП в процентах
func get_health_percent() -> float:
	return current_health / max_health if max_health > 0.0 else 0.0
