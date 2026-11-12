# 发布约定

管理器和每个功能模组各用自己的版本号与 Release。

| 产品 | 标签 | 附件 |
| --- | --- | --- |
| 管理器 | `manager-v1.2.6` | `Mayday-MOD-Manager-1.2.6.zip`、`SHA256SUMS.txt` |
| 存档管理 | `mayday-save-v0.6.46` | `Mayday-Save-0.6.46.maydaymod`、`SHA256SUMS.txt` |
| 后续模组 | `<包ID>-v<版本>` | 对应 `.maydaymod`、`SHA256SUMS.txt` |

版本页标题写清产品与版本；Release 正文包含适用环境、安装或升级步骤、主要变化和实际限制。当前两项按测试版发布。不要使用一个笼统的 `v1.0.0` 来表示所有模组版本。

管理器是仓库主要项目，主页始终保留管理器下载入口；模组列表链接到各自 Release。不要仅依赖 GitHub 的 Latest 标记选择管理器，因为功能模组也会独立更新。

## 发布文件准备

`scripts/Prepare-Release.ps1` 从已构建的管理器 ZIP 准备公开附件，去掉本机生成的 `Il2CppAssemblies`、Cpp2IL 输出、Unity 生成依赖缓存和生成配置，保留运行时及第三方说明；同时复制独立存档包，产生每项的 SHA-256。

```powershell
pwsh ./scripts/Prepare-Release.ps1 `
  -ManagerZip '本机构建的管理器ZIP绝对路径' `
  -SavePackage '本机构建的存档maydaymod绝对路径'
```

脚本不编译模组，不创建仓库，不自动上传，不读取玩家存档。公开安装包首次启动需要在玩家机器生成游戏互操作程序集，并可能联网获取依赖。初始公开包只完成构建文件、包结构及校验值核对，尚未在另一台全新电脑完成首次安装验证。

发布后核对在线附件与本地校验值一致，并更新 `catalog.json`、README 和模组目录。二进制附件放在 Releases，不提交到 Git 历史。

仅更新存档模组时使用 -SaveOnly -SavePackage 指定新版包，不重新打包或覆盖既有管理器版本的附件。
