# Check if any near tile isn't a tile 1 compatible:
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_1_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_1_placed] at @s run function wfc:wfc/reset_tiles
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_2_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_2_placed] at @s run function wfc:wfc/reset_tiles
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_5_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_5_placed] at @s run function wfc:wfc/reset_tiles
