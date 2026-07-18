extends Node
## EconomyManager (Autoload)
## Единственный источник правды по золоту игрока. Ничего не знает про
## конкретные здания — просто слушает EventBus.gold_generated.

@export var current_gold: int = 150

var gold: int:
	set(value):
		gold = maxi(value, 0)
		EventBus.gold_changed.emit(gold)

func _ready() -> void:
	gold = current_gold
	EventBus.gold_generated.connect(_on_gold_generated)

func can_afford(amount: int) -> bool:
	return gold >= amount

func spend_gold(amount: int) -> bool:
	if not can_afford(amount):
		EventBus.gold_spend_failed.emit(amount, gold)
		return false
	gold -= amount
	return true

func add_gold(amount: int) -> void:
	gold += amount

func _on_gold_generated(amount: int, _source: Node3D) -> void:
	add_gold(amount)
	
func _process(delta: float) -> void:
	print(current_gold)
