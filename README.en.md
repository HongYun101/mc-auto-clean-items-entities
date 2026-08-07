# mc-auto-clean-items-entities — Minecraft Bedrock Behavior Pack

A Minecraft Bedrock behavior pack whose core feature is an **automatic cleanup system**: every 15 minutes it removes hostile mobs, projectiles, dropped items and XP orbs from the map, with a 15-second countdown broadcast to all players before each cleanup.

## File Structure

```
mc-auto-clean-items-entities/
├── manifest.json                                  # Behavior pack manifest
├── pack_icon.png                                  # Pack icon
├── #批量生成.txt                                   # Notes document
└── functions/
    ├── tick.json                                  # Functions run every tick (controller + JS)
    ├── JS.mcfunction                              # Timer: adds +1 to `tick time1` every tick
    ├── ZDQL/
    │   ├── load.mcfunction                        # Initializes scoreboard, summons §lServer armor stand
    │   ├── start.mcfunction                       # Start
    │   ├── stop.mcfunction                        # Stop
    │   └── XUNHUAN/
    │       └── repeating_function_controller.mcfunction  # Core: cleanup controller (main logic)
    ├── Zstart.mcfunction                          # Start entry
    └── Zstop.mcfunction                           # Stop entry
```

## How It Works

| File | Responsibility |
|---|---|
| `tick.json` | Runs the controller and JS every tick |
| `JS.mcfunction` | Adds +1 to `tick time1` every tick (1 second = 20 ticks) |
| `load.mcfunction` | Initializes the `time1` scoreboard, summons the invisible marker entity `§lServer` (armor stand), broadcasts a load message |
| `repeating_function_controller.mcfunction` | Executes actions at each tick milestone of `tick time1` |

The first line of `repeating_function_controller.mcfunction`,
`effect @e[name=§lServer] invisibility 5 1 true`, refreshes the armor stand's
invisibility every tick so the marker entity stays hidden (it broadcasts the
"cleanup complete" message to the whole server).

## Cleanup Timeline (20 ticks = 1 second)

| Tick | Time | Action |
|---|---|---|
| 320 → 600 | 16 ~ 30 s | Every 20 ticks, broadcasts "15s…1s until auto cleanup" + harp sound |
| 600 | 30 s | anvil_land sound + kills creeper / skeleton / glow_squid / arrow / zombie_pigman / drowned / wither_skull (×2) / shulker_bullet / fireball |
| 610 | 30.5 s | Kills XP orbs `xp_orb` and all dropped items `item` |
| 620 | 31 s | `§lServer` broadcasts "cleanup complete!" |
| 18000 | 900 s (15 min) | Resets `time1` to 0, starts a new cycle |

## Known Issues / To Improve

1. **XP orbs are removed**: `kill @e[type=minecraft:xp_orb]` also removes the experience dropped by killed mobs.
2. **All items are removed indiscriminately**: `kill @e[type=item]` clears every dropped item, including items players just threw or haven't picked up yet.
3. **Countdown is off by 1 second**: at tick 320 the actual time until cleanup (tick 600) is 14 seconds, but it displays "15s"; every later announcement is also 1 second early.
4. **Commented-out tellraw has syntax errors**: it should be `"rawtext"`, and the JSON content is invalid (currently commented out, so it doesn't affect runtime).
5. **`glow_squid` lacks the `minecraft:` prefix**; the other entities have it. Suggest making it consistent.
6. **Kill list is incomplete**: zombie, spider, enderman, witch, phantom and other common hostile mobs are not included.
7. **Timer is not reset on server restart**: `load` does not reset `time1`, so a cleanup may trigger immediately after a restart if the score is between 600 and 18000.

## Usage

1. Package this folder into a zip file
2. In a Bedrock world: Settings → Behavior Packs → Import
3. After enabling, run `/function ZDQL/load` to initialize (or enable auto-load in world settings)
