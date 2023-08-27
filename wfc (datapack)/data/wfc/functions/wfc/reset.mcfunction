# Reset:
scoreboard players set @e[type=minecraft:armor_stand,tag=posible_tile] posible_tile 5
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove finding
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove finded
fill -18 55 -11 11 61 18 air
kill @e[type=item]
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_1_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_2_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_3_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_4_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_5_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_6_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_1
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_2
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_3
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_4
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_5
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove collapsed
scoreboard players set global test 0
