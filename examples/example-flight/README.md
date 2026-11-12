# 打包示例

这里只提供清单模板，不是可安装的功能模组。

将 `manifest.json` 与你编译的 `Mods/Example.FlightMod.dll` 放在同一工作目录下，需要时再加入 `Plugins` 或 `UserLibs`。压缩这些内容本身为 ZIP，确认根目录直接可见清单后，将扩展名改为 `.maydaymod`。

发布真实模组前修改 ID、名称、版本和程序集文件名，遵循 [完整包规范](../../docs/package-format.md)。清单不能代替有效模组 DLL。
