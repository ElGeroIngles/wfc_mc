scoreboard players set #min posible_tile 2147483647
execute as @e[type=armor_stand,tag=posible_tile,tag=!finded] run scoreboard players operation #min posible_tile < @s posible_tile
scoreboard players operation @e[type=armor_stand,tag=posible_tile,tag=!finded] posible_tile -= #min posible_tile
execute as @e[scores={posible_tile=0},limit=1,sort=random,tag=!finded] at @s run tag @s add finding
scoreboard players operation @e[type=armor_stand,tag=posible_tile,tag=!finded] posible_tile += #min posible_tile





