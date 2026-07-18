extends StaticBody2D
class_name Building
## Базовый класс для всех зданий (3D-модели). Готовая модель здания
## вкладывается как дочерняя сцена/узел под этим StaticBody3D —
## сортировку глубины делает сам движок, вручную ничего считать не нужно.

@export var building_data: BuildingData

var grid_position: Vector2i
var health_component: HealthComponent
var gold_generator: GoldGeneratorComponent

func _ready() -> void:
	if building_data == null:
		push_warning("Building создан без BuildingData: %s" % name)
		return
	_setup_health()
	_setup_gold_generation()

func setup(data: BuildingData, p_grid_position: Vector2i) -> void:
	building_data = data
	grid_position = p_grid_position
	if is_inside_tree():
		_setup_health()
		_setup_gold_generation()

## Добавление жизни башни
func _setup_health() -> void:
	health_component = HealthComponent.new()
	add_child(health_component)
	health_component.setup(building_data.max_health, building_data.armor)
	health_component.died.connect(_on_died)
	health_component.damaged.connect(_on_damaged)

## Добавление монетизации у башни
func _setup_gold_generation() -> void:
	if not building_data.generates_gold:
		return
	gold_generator = GoldGeneratorComponent.new()
	add_child(gold_generator)
	gold_generator.setup(building_data.gold_per_tick, building_data.tick_interval)

## Привязка получения дамага
func take_damage(amount: float) -> void:
	if health_component:
		health_component.take_damage(amount)

## Сигнал об нанесенном башней уроне
func _on_damaged(amount: float, current_health: float) -> void:
	EventBus.building_damaged.emit(self, amount, current_health)

## Press F
func _on_died() -> void:
	EventBus.building_destroyed.emit(self, grid_position)
	queue_free()

## Здоровье в процентах
func get_health_percent() -> float:
	return health_component.get_health_percent() if health_component else 1.0
