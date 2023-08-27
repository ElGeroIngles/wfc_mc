# @s is the armor_stand at @s!

# Getting tile number:
execute store result score n posible_tile run loot spawn ~ ~ ~ loot wfc:1-5

# Setting the tile:
execute if score @s posible_tile matches 5 run function wfc:wfc/fresh

execute unless score @s posible_tile matches 5 if entity @s[tag=collapsed] run function wfc:wfc/if_collapsed

execute unless score @s posible_tile matches 5 if entity @s[tag=!collapsed] run function wfc:wfc/not_collapsed

# Check if tile is valid:
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=finded] run function wfc:wfc/check/check

# Placed:
function wfc:wfc/placed

# Collapse near tiles:
execute if score n posible_tile matches 1 as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=!finded,tag=!collapsed] run function wfc:wfc/collapse/tile1

execute if score n posible_tile matches 2 as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=!finded,tag=!collapsed] run function wfc:wfc/collapse/tile2

execute if score n posible_tile matches 3 as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=!finded,tag=!collapsed] run function wfc:wfc/collapse/tile3

execute if score n posible_tile matches 4 as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=!finded,tag=!collapsed] run function wfc:wfc/collapse/tile4

execute if score n posible_tile matches 5 as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=!finded,tag=!collapsed] run function wfc:wfc/collapse/tile5

# Find lowest value:
function wfc:wfc/lowest_value
