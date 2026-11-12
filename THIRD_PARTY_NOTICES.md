# 第三方组件与发布说明

本项目不是游戏官方产品。Mayday Airways 的游戏名称、程序和资源归各自权利人所有；本仓库不分发游戏本体、个人存档或本地生成的游戏互操作程序集。

## MelonLoader

管理器安装包包含 **MelonLoader 0.7.3**。上游项目：<https://github.com/LavaGang/MelonLoader>，作者与版权声明见安装包的 `MelonLoader/Documentation/NOTICE.txt`；许可证全文见 `MelonLoader/Documentation/LICENSE.md`（Apache License 2.0）。保留上游自身的组件声明与许可。

**本包修改说明：** `MelonLoader/net6/MelonLoader.dll` 包含本项目的退出等待调整：正常退出保留原清理流程，跳过清理后的固定 200 毫秒等待；显式开启强制退出时保留该等待。不是未修改的上游二进制。对应处理脚本见 `scripts/PatchLoaderQuit.ps1`。这项调整不代表已修复所有退出异常。

## .NET

管理器安装包包含 Microsoft .NET 6.0.36 运行时。许可证与第三方声明分别保留在 `dotnet/LICENSE.txt` 和 `dotnet/ThirdPartyNotices.txt`。项目入口：<https://github.com/dotnet/runtime>。

## 其他随加载器组件

Harmony、Il2CppInterop、Mono.Cecil、Cpp2IL 等加载器依赖按随包原始内容保留，具体权利和许可仍属于各上游组件。此文档不会将其许可证改成项目自有许可证。

## 自有内容

自有模组作者署名：lansi；交流群：974731412。当前仓库用于发布说明、模组适配规范与分发附件，未为自有模组声明额外开源许可；不能把公开下载或示例清单等同于对所有程序和第三方资源的重新授权。
