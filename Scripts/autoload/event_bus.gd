extends Node
## EventBus (Autoload)
## Глобальная шина сигналов.

# --- Экономика ---
signal gold_changed(new_amount: int)
signal gold_generated(amount: int, source: Node3D)          # источник — конкретное здание
signal gold_spend_failed(required: int, available: int)   # для UI (тряска кнопки и т.п.)

# --- Здания ---
signal building_placement_started(building_data: BuildingData)
signal building_placement_cancelled()
signal building_placed(building: Node, grid_pos: Vector2i)
signal building_removed(building: Node, grid_pos: Vector2i)
signal building_damaged(building: Node, amount: float, current_health: float)
signal building_destroyed(building: Node, grid_pos: Vector2i)

# --- Волны/враги (для последующей интеграции) ---
signal wave_started(wave_number: int)
signal wave_completed(wave_number: int)
signal enemy_spawned(enemy: Node)
signal enemy_died(enemy: Node, gold_reward: int)
