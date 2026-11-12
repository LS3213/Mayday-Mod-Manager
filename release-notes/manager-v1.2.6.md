# Mayday 模组管理器 1.2.6（测试版）

作者：lansi · QQ 交流群：974731412。

本仓库以模组管理器为主，配套模组独立发布。完整使用说明与后续模组目录见 [仓库主页](https://github.com/LS3213/Mayday-Mod-Manager)。

## 下载与安装

下载本页附件 **Mayday-MOD-Manager-1.2.6.zip**，退出游戏，将内容解压到 `MaydayAirways.exe` 所在目录。不要下载自动生成的 Source code 作为安装包。

适用于 Windows x64 版 Mayday Airways Demo。自带 MelonLoader 0.7.3 与 .NET 6 运行时。首次启动生成本机游戏互操作程序集，可能需要联网与较长等待；公开包不携带本机游戏生成缓存。

主菜单「设置」右侧打开「MOD 管理」；导入符合规范的 `.maydaymod` / `.zip`，启用并重启。新包默认关闭。关闭和删除也需重启生效。

## 当前功能与变化

- 统一添加、查看、启用、关闭和删除导入的模组包。
- 模组文件分包存放，显示名称、版本及本次／下次加载状态。
- 独立原生界面，默认隐藏启动控制台，无额外管理器热键。
- 1.2.6 将「作者：lansi  交流群：974731412」移到面板右下角。

管理器不预装存档模组。存档功能请单独下载 [存档管理 0.6.42](https://github.com/LS3213/Mayday-Mod-Manager/releases/tag/mayday-save-v0.6.42)。

## 升级与限制

1.2.2～1.2.5 用户退出后仅覆盖 `Mods/Mayday.PackageManager.dll`。更早版本见 [安装与升级](https://github.com/LS3213/Mayday-Mod-Manager/blob/main/docs/installation.md)。保留已有包目录与自己的数据。

仅管理通过界面导入的包，无在线商店、自动更新、热加载或自动下载依赖。同 ID 更新需先删除旧包并重启，再导入新版。当前发布文件完成包结构与校验核对，尚未在另一台全新电脑完成首次安装验证。游戏更新可能影响兼容性。

附件 `SHA256SUMS.txt` 用于核对下载内容。包内保留第三方许可及加载器退出等待修改说明。
