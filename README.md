# Mayday 模组管理器

**统一安装入口，让 Mayday Airways Demo 的模组更容易安装、管理和分享。**

作者：**lansi** · QQ 交流群：**974731412**

这是 Mayday 模组管理器的发布与适配仓库，同时收录配套模组。管理器是项目核心，存档管理是首个独立发布的功能模组，未来其他模组也将沿用同一套目录、包规范与发布方式。

适用于 **Windows x64 版 Mayday Airways Demo**。这是非官方社区项目，与游戏开发者无隶属关系；当前发布版本仍属测试版。

## 下载

| 项目 | 当前版本 | 用途 | 下载与说明 |
| --- | --- | --- | --- |
| **模组管理器** | **1.2.6** | 提供统一加载环境及添加、启用、关闭、删除界面 | [下载管理器安装包](https://github.com/LS3213/Mayday-Mod-Manager/releases/download/manager-v1.2.6/Mayday-MOD-Manager-1.2.6.zip) · [版本说明](https://github.com/LS3213/Mayday-Mod-Manager/releases/tag/manager-v1.2.6) |
| 存档管理 | 0.6.44 | 六个手动存档位，恢复主要整局状态，选择单人或 Steam 好友房间读取 | [下载存档模组](https://github.com/LS3213/Mayday-Mod-Manager/releases/download/mayday-save-v0.6.44/Mayday-Save-0.6.44.maydaymod) · [使用说明](mods/mayday-save/README.md) |

[所有发布版本](https://github.com/LS3213/Mayday-Mod-Manager/releases) · [模组目录](mods/README.md) · [安装与升级](docs/installation.md) · [开发者适配规范](docs/package-format.md) · [常见问题](docs/faq.md)

**普通玩家下载 Release 的附件即可。GitHub 的「Code → Download ZIP」或 Release 自动生成的「Source code」不是安装包。** 管理器与功能模组分别下载，管理器不会自动安装存档模组。

## 管理器能做什么

- 在主菜单「设置」右侧提供 **MOD 管理** 入口。
- 导入符合规范的 `.maydaymod` / `.zip` 包，查看名称、版本、本次加载状态及下次启动状态。
- 通过界面启用、关闭或删除已导入的模组，**重启游戏后生效**。
- 将模组包分别放在 `Mods/MaydayPkg.<id>/`，按包管理文件。
- 安装包包含 MelonLoader 0.7.3 与 .NET 6 运行时，无需另装 .NET SDK；默认隐藏控制台，没有额外模组热键。

管理器仅管理经「添加 MOD」导入的包。手动放入 `Mods`、`Plugins`、`UserLibs` 的其他 DLL 不在管理范围内。当前没有热加载、在线模组商店、自动下载依赖或一键更新功能。

## 三步开始使用

1. **装管理器：** 退出游戏，将管理器安装包解压到游戏根目录，使 `version.dll` 与 `MaydayAirways.exe` 同级。首次加载需要生成本机互操作程序集，请保持联网并耐心等待。
2. **添加模组：** 从 Steam 启动游戏，打开「MOD 管理」→「添加 MOD」，选择下载的模组包。添加后默认关闭。
3. **启用并重启：** 点击对应模组的「启用」，重启游戏。以存档模组为例，重启后主菜单会出现「存档管理」。

已有加载器或手动安装的同名模组时，先阅读 [完整安装说明](docs/installation.md)，避免重复安装。

## 配套模组：存档管理

航班飞到一半也可以手动保存，下次从主菜单「存档管理」继续。原来的「开始游戏」仍然开新局。

目前提供 **6 个独立档位**，已覆盖飞机位置与飞行状态、资金和升级、座椅布局、客舱与机场物品、行李、乘客行为、天气、地勤及结算等主要整局状态。游戏中通过机长／暂停菜单的「存档管理」保存；主菜单读取时可以选择单人模式或 Steam 好友房间。

**请注意：目前没有自动存档和云存档。** 联机保存由主机操作，所有玩家需安装同版存档模组；0.6.44 已接入远端体力、攀爬、安全绳及倒地等动作快照，并完成本机独立双进程 LAN 存读档循环。真实 Steam 双账号与公网环境仍待验证。部分测试环境出现过退出异常，原因仍在排查。覆盖与升级前请备份存档，不能把“主要状态恢复”理解为所有随机组合均已验证无遗漏。

详见 [存档功能、操作步骤与已知限制](mods/mayday-save/README.md) 及 [联机存档说明](docs/save-multiplayer.md)。

## 邀请开发者采用统一包规范

希望社区逐步形成 **统一加载环境、统一打包格式、统一管理入口** 的习惯。玩家不必反复复制 DLL，作者也可以把精力放在自己的模组功能上。

使用现有 MelonLoader 模组开发方式即可，**无需额外引用管理器 DLL**。提供固定 ID、名称与版本，将程序集按 `Mods`、`Plugins`、`UserLibs` 分类打包，就能由管理器导入。加载器和 .NET 运行时无需在每个功能包里重复携带；模组自己的依赖仍需随包提供。

- [包格式与限制](docs/package-format.md)
- [示例 manifest.json](examples/example-flight/manifest.json)
- [新模组收录方式](CONTRIBUTING.md)

这是一套社区适配倡议，不代表所有现有模组已适配或所有组合已验证兼容。欢迎开发者提出实际需求、提交模组收录和文档改进。

## 反馈与后续发布

有问题可以 [提交 Issue](https://github.com/LS3213/Mayday-Mod-Manager/issues/new/choose)，或加入 QQ 交流群 **974731412**。反馈时请说明游戏版本、管理器／模组版本、单人或联机、复现步骤及预期结果。日志可能包含 Steam 标识和本机路径，分享前请自行去除个人信息。

本仓库按产品独立发布：管理器使用 `manager-v版本号`，功能模组使用 `模组ID-v版本号`。更新一个模组不会要求其他模组跟着改版本。未来新增模组先加入 [模组目录](mods/README.md)，再发布自己的 Release。

本仓库主要存放发布说明、使用文档、适配规范与示例，**不包含游戏本体、玩家存档或本机生成的游戏程序集**。第三方组件遵循各自许可证，详见 [第三方说明](THIRD_PARTY_NOTICES.md)。
