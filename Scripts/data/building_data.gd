extends Resource
class_name BuildingData
## Описание типа здания (башня, стена, шахта и т.д.)
## Один Resource на тип — переиспользуется всеми инстансами этого типа.

@export_group("Общее")
@export var id: String
@export var display_name: String
@export var scene: PackedScene           # сцена здания для инстанцирования
@export var icon: Texture2D
@export var cost: int = 50
@export var grid_size: Vector2i = Vector2i(1, 1)  # сколько клеток занимает (для крупных зданий)

@export_group("Здоровье")
@export var max_health: float = 100.0
@export var armor: float = 0.0           # плоское снижение входящего урона

@export_group("Атака (опционально, 0 = не атакует)")
@export var damage: float = 0.0
@export var attack_range: float = 0.0
@export var fire_rate: float = 1.0       # выстрелов в секунду
@export_enum("FLAT", "PERCENT_HP", "SPLASH") var damage_type: String = "FLAT"
@export var projectile_scene: PackedScene

@export_group("Пассивный доход (опционально)")
@export var generates_gold: bool = false
@export var gold_per_tick: int = 5
@export var tick_interval: float = 3.0

@export_group("Прогрессия и синергии")
@export var upgrade_path: Array[BuildingData] = []
@export var synergy_tags: Array[String] = []   # напр. ["amplifier_target", "slow_source"]
