# mc-behavior-pack — Minecraft 基岩版行为包

Minecraft Bedrock(基岩版)行为包,核心功能是**自动清理系统**:每 15 分钟自动清除地图上的危险生物、投射物、掉落物和经验球,清理前 15 秒对全服玩家倒计时提示。

## 文件结构

```
mc-behavior-pack/
├── manifest.json                                  # 行为包清单
├── pack_icon.png                                  # 包图标
├── #批量生成.txt                                   # 说明文档
└── functions/
    ├── tick.json                                  # 每 tick 调用的函数列表(controller + JS)
    ├── JS.mcfunction                              # 计时器:每 tick 给 tick time1 +1
    ├── ZDQL/
    │   ├── load.mcfunction                        # 初始化计分板、召唤 §lServer 盔甲架
    │   ├── start.mcfunction                       # 启动
    │   ├── stop.mcfunction                        # 停止
    │   └── XUNHUAN/
    │       └── repeating_function_controller.mcfunction  # 核心:清理控制器(本包主体)
    ├── Zstart.mcfunction                          # 启动入口
    └── Zstop.mcfunction                           # 停止入口
```

## 工作机制

| 文件 | 职责 |
|---|---|
| `tick.json` | 每 tick 依次运行 controller 和 JS |
| `JS.mcfunction` | 每 tick 给 `tick time1` +1(计时器,1 秒 = 20 tick) |
| `load.mcfunction` | 初始化 `time1` 计分板、召唤隐形标记实体 `§lServer`(盔甲架)、广播加载提示 |
| `repeating_function_controller.mcfunction` | 按 `tick time1` 的数值执行各时间点动作 |

`repeating_function_controller.mcfunction` 第一行的
`effect @e[name=§lServer] invisibility 5 1 true` 每 tick 刷新盔甲架的隐身,
保证标记实体一直隐形(由它执行全服广播"清理完成!")。

## 清理时间线(20 tick = 1 秒)

| tick | 时刻 | 动作 |
|---|---|---|
| 320 → 600 | 16 ~ 30 秒 | 每 20 tick 播报"15秒后…1秒后自动清理掉落物"+ harp 音效 |
| 600 | 30 秒 | anvil_land 音效 + 击杀 creeper / skeleton / glow_squid / arrow / zombie_pigman / drowned / wither_skull(×2)/ shulker_bullet / fireball |
| 610 | 30.5 秒 | 击杀经验球 `xp_orb` 和所有掉落物 `item` |
| 620 | 31 秒 | `§lServer` 广播"清理完成!" |
| 18000 | 900 秒(15 分钟) | `time1` 归零,进入新一轮循环 |

## 已知问题 / 待改进

1. **经验球会被清掉**:`kill @e[type=minecraft:xp_orb]` 让玩家杀怪掉落的经验也一起消失。
2. **所有掉落物无差别清除**:`kill @e[type=item]` 会把玩家刚扔出/未捡的物品全清掉。
3. **倒计时偏差 1 秒**:320 tick 距清理点(600)实际为 14 秒,但显示"15秒",后续每档都多显示 1 秒。
4. **注释掉的 tellraw 有语法错误**:应为 `"rawtext"`,且 JSON 内容不合法(当前被注释,不影响运行)。
5. **`glow_squid` 缺 `minecraft:` 前缀**,建议与其余实体统一。
6. **击杀列表不完整**:未包含 zombie、spider、enderman、witch、phantom 等常见敌对生物。
7. **服务器重启后计时不归零**:`load` 中未重置 `time1`,重启后可能立即触发一次清理。

## 使用方式

1. 将本文件夹打包为 mcaddon
2. 在基岩版世界中:设置 → 行为包 → 导入
3. 启用后运行 `/function Zstart` 初始化(或世界设置中自动加载)
