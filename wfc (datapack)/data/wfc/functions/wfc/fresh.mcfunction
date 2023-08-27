# Setting:
execute if score n posible_tile matches 1 run clone 9 56 38 7 61 36 ~-1 ~ ~-1
execute if score n posible_tile matches 2 run clone 5 56 38 3 61 36 ~-1 ~ ~-1
execute if score n posible_tile matches 3 run clone 1 56 38 -1 61 36 ~-1 ~ ~-1
execute if score n posible_tile matches 4 run clone -3 56 38 -5 61 36 ~-1 ~ ~-1
execute if score n posible_tile matches 5 run clone -7 56 38 -9 61 36 ~-1 ~ ~-1

# Adding tags:
execute if score n posible_tile matches 1 run tag @s add tile_1_placed
execute if score n posible_tile matches 2 run tag @s add tile_2_placed
execute if score n posible_tile matches 3 run tag @s add tile_3_placed
execute if score n posible_tile matches 4 run tag @s add tile_4_placed
execute if score n posible_tile matches 5 run tag @s add tile_5_placed

# Adding "finded" tag:
function wfc:wfc/placed
