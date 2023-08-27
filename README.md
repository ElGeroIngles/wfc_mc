<h3>English</h3>
<details>

# Wave Function Collapse (MC)

This datapack uses [Wave Function Collapse algorithm](https://github.com/mxgmn/WaveFunctionCollapse) and implements it to minecraft.

## Features

- Tile based map generator using rules

## Credits

This datapack is inspired in the original [Wave Function Collapse algorithm](https://github.com/mxgmn/WaveFunctionCollapse).

## Explanation/How to Use

I've made a video in [my youtube channel](https://www.youtube.com/@elgeroingles) explaining how it generally works, but to fully understand it here's an in-depth explanation of it and how to use it:

### Explanation
<h3>Click to show the explanation</h3>
<details>
(If you want a short explanation in video check out [my video](https://www.youtube.com/@elgeroingles) or [this one](https://www.youtube.com/watch?v=dFYMOzoSDNE&t=49s))The Wave Function Collapse algorithm works by having a set of tiles and having rules about how they can connect each other, for example, let's say that we have as tiles a tree, grass, sand and water. We have some rules of how they can connect each other:

- Trees can only be connected to grass.
- Grass can only be connected to trees and sand.
- Sand can only be connected to grass and water.
- Water can only be connected to sand.

Let's say that we have the following grid:

![empty_grid](https://i.imgur.com/BAXI6SF.png)

Each one of the squares can initially have all 4 of the tiles, so each one starts with the value 4:

![grid_4](https://i.imgur.com/qbT222P.png)

The algorithm picks the square with the lowest value, if there're several with the same value it picks one of them randomly. Then, we place in that square one of the possible tiles it can be, if it has multiple options it selects one of them randomly:

![grid_tree](https://i.imgur.com/MBh6uHC.png)

The algorithm picked a tree tile, tree tiles can only be near grass tiles, that makes the near tiles only have one possible option, so they value is reduced. Let's place another one following the rule to place next the tile with the lowest possibilities:

![grid_tree_grass](https://i.imgur.com/Njy8yhq.png)

The algorithm placed a grass tile because it could only place that tile, we say that . If we let the algorithm finish the grid it will look like this:

![grid_full](https://i.imgur.com/pWc1hhX.png)

The algorithm has completed the grid following the rules we said.

</details>

### How it works in minecraft

<h3>Click to show how it works in minecraft</h3>
<details>

#### Setup

For the setup we'll be using some armor stands (you can use markers, I don't know why I didn't use them but is up to you) which will indicate that a tile can be placed there (each armor stand will have the "posible_tile" tag and will also have stored in a scoreboard the amount of different tiles it can have, for this example I have 5 tiles so everyone starts with 5 in the scoreboard named: "posible_tile") and the actual tiles, for this example I'll be using 5 different tiles:

![mc_grid](https://i.imgur.com/JZ41tuE.png)
![tiles](https://i.imgur.com/hQMknJE.png)

I will also write down the rules each tile will have in a book inside minecraft so I can follow along easier:

![rules](https://i.imgur.com/huCs0zB.png)

### Code

We start running the "**wfc:wfc/start**" function which will reset the grid and all tags/scores to the armor stands and give to a random armor stand the tag "finding", every armor stand with that tag is the one which the algorithm selected to place a tile there:
```
# Reset:
function wfc:wfc/reset

# Start:
tag @e[type=minecraft:armor_stand,tag=posible_tile,limit=1,sort=random] add finding

```
Let's have a closer look to "**wfc:wfc/reset**":
```
# Reset:
scoreboard players set @e[type=minecraft:armor_stand,tag=posible_tile] posible_tile 5
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove finding
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove finded
fill -18 55 -11 11 61 18 air <---- Empty the grid
kill @e[type=item] <---- We kill items because I was using doors in some tiles and they drop when setting them to air so yeah
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_1_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_2_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_3_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_4_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove tile_5_placed
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_1
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_2
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_3
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_4
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove can_be_tile_5
tag @e[type=minecraft:armor_stand,tag=posible_tile] remove collapsed
```
As you can see we remove every tag except "posible_tile" and we reset the scoreboard of the armor stands. Let's move on.

```
# Finding:
execute as @e[type=minecraft:armor_stand,tag=posible_tile,tag=finding,limit=1] at @s run function wfc:wfc/find
```
This is "**tick.mcfunction**", we execute as the armor stand with the tag of finding at him "**wfc:wfc/find**", let's look inside it:
```
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
```
Let's go from top to bottom, we first store in "n" a random number between 1-5 (because we have 5 different tiles), inclusive.
If the armor stand has the score of 5 it means that it can have all 5 different tiles, so we just place the "n" tile:
```
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
```
We just set the tile via "**/clone**", we give a tag to indicate which tile has been placed and we run "**wfc:wfc/placed**", which will just remove the "**finding**" tag, give the "**finded**" tag and set its score to 0, because it has been placed it can no longer have another tile so we set it to 0, let's continue looking at "**wfc:wfc/find**".

If it cannot have all 5 tiles and it has been collapsed (the tag "**collapsed**" is to determine that a near tile has lowered the amount of different tiles that armor stand can be) we will run "**wfc:wfc/if_collapsed**", let's look inside it:
```
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
```
Ok, a lot of text, but don't worry, its very simple. Basically we are setting the armor stand as one of the tiles it can be. Let's say that the armor stand can have tiles 1 and 5 (so it has tags: "**can_be_tile_1**" and "**can_be_tile_5**"), we need to place either tile 1 or 5, "n" is the tile we are trying to place and "r_can_be" is the one we are going to place. If both are the same we place it and give its tags as usual, if not we run the function again to reset both values and try again. Using "r_can_be" we make sure that the election is random and we reset "n" because there is a posibility that "n" doesn't matches with the tile it can be so we reset it just in case. If anything of this didn't make sense for you, don't worry, I don't really understand it too. When I first wrote it it had 100% sense, but like 5 days after I forgot how this has sense. Lukily ChatGPT somehow understood the code and explained it to me but I still don't quite get it. BUT, the code works fine and if I do it the way my current brain thinks it should work the code breaks so yeah (If I ever understand this again I'll edit this).

Ok, after this incident let's continue looking at "**wfc:wfc/find**". If it cannot have all 5 tiles and it hasn't been collapsed it runs "**wfc:wfc/not_collapsed**", which is a copy of "**wfc:wfc/fresh**" but without running "**wfc:wfc/placed**" at the end.

Then we are going to check near tiles to see whether they admit the tile we are going to place or not, if they admit it cool, if not we reset the tiles that don't admit it. To do this we run "**wfc:wfc/check/check**", which will just run the correct check for the tile of the tile we are placing:
```
# Different tiles:
execute if score n posible_tile matches 1 run function wfc:wfc/check/tile1
execute if score n posible_tile matches 2 run function wfc:wfc/check/tile2
execute if score n posible_tile matches 3 run function wfc:wfc/check/tile3
execute if score n posible_tile matches 4 run function wfc:wfc/check/tile4
execute if score n posible_tile matches 5 run function wfc:wfc/check/tile5
```
Let's say that we are placing tile 1, so we run "**wfc:wfc/check/tile1**":
```
# Check if any near tile isn't a tile 1 compatible:
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_1_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_1_placed] at @s run function wfc:wfc/reset_tiles
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_2_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_2_placed] at @s run function wfc:wfc/reset_tiles
execute if entity @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_5_placed] as @e[type=minecraft:armor_stand,tag=posible_tile,distance=2..3.1,tag=tile_5_placed] at @s run function wfc:wfc/reset_tiles
```
We just check if any near tile isn't a tile 1 compatible, if so, we run as that type of tile that is in the range (any of the four near tiles) the function "**wfc:wfc/reset_tiles**", which resets the tile:
```
# Reset current tile (@s):
fill ~1 ~ ~1 ~-1 ~10 ~-1 air
kill @e[type=item]
tag @s[tag=finded] remove finded
tag @s add finding
tag @s[tag=tile_1_placed] remove tile_1_placed
tag @s[tag=tile_2_placed] remove tile_2_placed
tag @s[tag=tile_3_placed] remove tile_3_placed
tag @s[tag=tile_4_placed] remove tile_4_placed
tag @s[tag=tile_5_placed] remove tile_5_placed
tag @s[tag=tile_1_placed] remove tile_1_placed
tag @s[tag=tile_2_placed] remove tile_2_placed
tag @s[tag=tile_3_placed] remove tile_3_placed
tag @s[tag=tile_4_placed] remove tile_4_placed
tag @s[tag=tile_5_placed] remove tile_5_placed
```
Let's continue looking at "**wfc:wfc/find**". We run function "**wfc:wfc/placed**" (which I already explained what it does). After that we collapse near tiles based on the tile we are placing, let's say that we are placing tile 1, so we run "**wfc:wfc/collapse/tile1**" as all four near tiles that haven't been collapsed yet (the term collapsed it being used wrong here but whatever):
```
# Collapse near tiles:
scoreboard players set @s posible_tile 2
tag @s add can_be_tile_3
tag @s add can_be_tile_4
tag @s add collapsed
```
Because tile 1 can only admit tiles 2 and 4 we apply both tags to them, we set the score correctly (in this case to two because it can admit two different tiles) and add the tag "**collapsed**" to indicate that that armor stand has been collapsed. After that, in "**wfc:wfc/find**", we run "**wfc:wfc/lowest_value**" to find the armor stand with the lowest value and giving it the tag "**finding**".

</details>

## FAQ

#### Q: Can I modify the datapack and redistribute it?

A: Yes you can, In my other datapacks I would ask for recognition but for this one I will not. Use it as you please.

#### Q: Are you going to make more datapacks?

A: Yeah, I will continue developing one I've already started. 

## Author

- [@ElGeroIngles](https://github.com/ElGeroIngles)


## Bug Report

If you have found any bugs, please open an "issue" [here](https://github.com/ElGeroIngles/wfc_mc/issues) explaining the issue.

## 🔗 Links
[![youtube](https://img.shields.io/badge/youtube-ff0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@ElGeroIngles)
[![twitch](https://img.shields.io/badge/twitch-6441a5?style=for-the-badge&logo=twitch&logoColor=white)](https://www.twitch.tv/elgeroingles)
[![discord](https://img.shields.io/badge/discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/bGd2QyqjCg)
[![modrinth](https://img.shields.io/badge/modrinth-5AD770?style=for-the-badge&logo=modrinth&logoColor=white)](https://modrinth.com/user/ElGeroIngles)
[![github](https://img.shields.io/badge/github-000000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/ElGeroIngles)
[![BuyMeACoffe](https://img.shields.io/badge/BuyMeACoffe-ffdd02?style=for-the-badge&logo=buymeacoffee&logoColor=white)](https://www.buymeacoffee.com/ElGeroIngles)

## License

[MIT](https://choosealicense.com/licenses/mit/)

</details>

<h3>Español</h3>
<details>
Próximamente... (dejenme descansar un rato, llevo dias con esto)
</details>
