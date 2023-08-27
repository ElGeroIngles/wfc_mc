tellraw @a {"text":"Reloading...","color":"yellow"}

# Scoreboard:
scoreboard objectives add posible_tile dummy
scoreboard objectives add test dummy
scoreboard players set global test 0

tellraw @a {"text":"Datapack reloaded succesfully!","color":"green"}
tellraw @a ["",{"text":"Wave Function Collapse - ","color":"gold"},{"text":"By ElGeroIngles","color":"blue"}]
execute as @a at @s run playsound minecraft:entity.player.levelup ambient @s