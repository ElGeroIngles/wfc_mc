# Change number:
execute store result score n posible_tile run loot spawn ~ ~ ~ loot wfc:1-5
execute store result score r_can_be posible_tile run loot spawn ~ ~ ~ loot wfc:1-5

# Setting:
execute if score r_can_be posible_tile matches 1 if entity @s[tag=can_be_tile_1] run scoreboard players set can_be posible_tile 1
execute if score r_can_be posible_tile matches 2 if entity @s[tag=can_be_tile_2] run scoreboard players set can_be posible_tile 2
execute if score r_can_be posible_tile matches 3 if entity @s[tag=can_be_tile_3] run scoreboard players set can_be posible_tile 3
execute if score r_can_be posible_tile matches 4 if entity @s[tag=can_be_tile_4] run scoreboard players set can_be posible_tile 4
execute if score r_can_be posible_tile matches 5 if entity @s[tag=can_be_tile_5] run scoreboard players set can_be posible_tile 5

# If:
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 1 if entity @s[tag=can_be_tile_1] run clone 9 56 38 7 61 36 ~-1 ~ ~-1
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 2 if entity @s[tag=can_be_tile_2] run clone 5 56 38 3 61 36 ~-1 ~ ~-1
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 3 if entity @s[tag=can_be_tile_3] run clone 1 56 38 -1 61 36 ~-1 ~ ~-1
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 4 if entity @s[tag=can_be_tile_4] run clone -3 56 38 -5 61 36 ~-1 ~ ~-1
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 5 if entity @s[tag=can_be_tile_5] run clone -7 56 38 -9 61 36 ~-1 ~ ~-1

execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 1 if entity @s[tag=can_be_tile_1] run tag @s add tile_1_placed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 2 if entity @s[tag=can_be_tile_2] run tag @s add tile_2_placed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 3 if entity @s[tag=can_be_tile_3] run tag @s add tile_3_placed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 4 if entity @s[tag=can_be_tile_4] run tag @s add tile_4_placed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 5 if entity @s[tag=can_be_tile_5] run tag @s add tile_5_placed


# If not:
execute unless score n posible_tile = can_be posible_tile run function wfc:wfc/if_collapsed

execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 1 unless entity @s[tag=can_be_tile_1] run function wfc:wfc/if_collapsed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 2 unless entity @s[tag=can_be_tile_2] run function wfc:wfc/if_collapsed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 3 unless entity @s[tag=can_be_tile_3] run function wfc:wfc/if_collapsed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 4 unless entity @s[tag=can_be_tile_4] run function wfc:wfc/if_collapsed
execute if score n posible_tile = can_be posible_tile if score n posible_tile matches 5 unless entity @s[tag=can_be_tile_5] run function wfc:wfc/if_collapsed
