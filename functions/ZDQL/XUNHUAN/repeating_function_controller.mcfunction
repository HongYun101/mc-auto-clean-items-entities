effect @e[name=§lServer] invisibility 5 1 true



#时间线


execute if score tick time1 matches 320 run title @a actionbar §l§e15秒后自动清理掉落物

execute if score tick time1 matches 320 run playsound note.harp @a 

execute if score tick time1 matches 340 run title @a actionbar §l§e14秒后自动清理掉落物

execute if score tick time1 matches 340 run playsound note.harp @a 

execute if score tick time1 matches 360 run title @a actionbar §l§e13秒后自动清理掉落物

execute if score tick time1 matches 360 run playsound note.harp @a 

execute if score tick time1 matches 380 run title @a actionbar §l§e12秒后自动清理掉落物

execute if score tick time1 matches 380 run playsound note.harp @a 

execute if score tick time1 matches 400 run title @a actionbar §l§e11秒后自动清理掉落物

execute if score tick time1 matches 400 run playsound note.harp @a 

execute if score tick time1 matches 420 run title @a actionbar §l§e10秒后自动清理掉落物

execute if score tick time1 matches 420 run playsound note.harp @a 

execute if score tick time1 matches 440 run title @a actionbar §l§e9秒后自动清理掉落物

execute if score tick time1 matches 440 run playsound note.harp @a 

execute if score tick time1 matches 460 run title @a actionbar §l§e8秒后自动清理掉落物

execute if score tick time1 matches 460 run playsound note.harp @a 

execute if score tick time1 matches 480 run title @a actionbar §l§e7秒后自动清理掉落物

execute if score tick time1 matches 480 run playsound note.harp @a 

execute if score tick time1 matches 500 run title @a actionbar §l§e6秒后自动清理掉落物

execute if score tick time1 matches 500 run playsound note.harp @a 

execute if score tick time1 matches 520 run title @a actionbar §l§e5秒后自动清理掉落物

execute if score tick time1 matches 520 run playsound note.harp @a 

execute if score tick time1 matches 540 run title @a actionbar §l§e4秒后自动清理掉落物

execute if score tick time1 matches 540 run playsound note.harp @a 

execute if score tick time1 matches 560 run title @a actionbar §l§e3秒后自动清理掉落物

execute if score tick time1 matches 560 run playsound note.harp @a 

execute if score tick time1 matches 580 run title @a actionbar §l§e2秒后自动清理掉落物

execute if score tick time1 matches 580 run playsound note.harp @a 

execute if score tick time1 matches 600 run title @a actionbar §l§e1秒后自动清理掉落物

execute if score tick time1 matches 600 run playsound random.anvil_land @a

execute if score tick time1 matches 600 run kill @e[type=minecraft:creeper]

execute if score tick time1 matches 600 run kill @e[type=minecraft:skeleton]

execute if score tick time1 matches 600 run kill @e[type=glow_squid]

execute if score tick time1 matches 600 run kill @e[type=minecraft:arrow]

execute if score tick time1 matches 600 run kill @e[type=minecraft:zombie_pigman]

execute if score tick time1 matches 600 run kill @e[type=minecraft:drowned]

execute if score tick time1 matches 600 run kill @e[type=minecraft:wither_skull_dangerous]

execute if score tick time1 matches 600 run kill @e[type=minecraft:wither_skull]

execute if score tick time1 matches 600 run kill @e[type=minecraft:shulker_bullet]

execute if score tick time1 matches 600 run kill @e[type=minecraft:fireball]

execute if score tick time1 matches 610 run kill @e[type=minecraft:xp_orb]

execute if score tick time1 matches 610 run kill @e[type=item]

execute if score tick time1 matches 620 as @e[name=§lServer] at @s run say §l§e清理完成！ 

execute if score tick time1 matches 18000 run scoreboard players set tick time1 0


# 605 run tellraw @a {"rewtext":[{"§l§e清理完成！"}]}

