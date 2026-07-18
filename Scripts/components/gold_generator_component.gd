extends Node
class_name GoldGeneratorComponent
## Компонент пассивного дохода. Тикает по таймеру и шлёт золото
## через EventBus — сам EconomyManager ничего не знает о конкретных зданиях,
## он просто слушает gold_generated и прибавляет золото.

@export var gold_per_tick: int = 5
@export var tick_interval: float = 3.0
@export var auto_start: bool = true

var _timer: Timer
var _paused: bool = false

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = tick_interval
	_timer.one_shot = false
	_timer.timeout.connect(_on_tick)
	add_child(_timer)
	if auto_start:
		start()

func setup(p_gold_per_tick: int, p_tick_interval: float) -> void:
	gold_per_tick = p_gold_per_tick
	tick_interval = p_tick_interval
	if _timer:
		_timer.wait_time = tick_interval

func start() -> void:
	_paused = false
	if _timer:
		_timer.start()

func stop() -> void:
	_paused = true
	if _timer:
		_timer.stop()

func _on_tick() -> void:
	if _paused:
		return
	EventBus.gold_generated.emit(gold_per_tick, get_parent())
