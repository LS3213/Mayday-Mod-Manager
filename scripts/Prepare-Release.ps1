param(
    [Parameter(Mandatory)] [string]$ManagerZip,
    [Parameter(Mandatory)] [string]$SavePackage,
    [string]$OutputDirectory = (Join-Path (Split-Path $PSScriptRoot) 'dist')
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path $PSScriptRoot
$managerVersion = '1.2.6'
$saveVersion = '0.6.42'
$managerOut = Join-Path $OutputDirectory "manager-v$managerVersion"
$saveOut = Join-Path $OutputDirectory "mayday-save-v$saveVersion"
New-Item -ItemType Directory -Path $managerOut, $saveOut -Force | Out-Null
$managerTarget = Join-Path $managerOut "Mayday-MOD-Manager-$managerVersion.zip"
if ([IO.Path]::GetFullPath($ManagerZip) -eq [IO.Path]::GetFullPath($managerTarget)) {
    throw '输入 ZIP 与发布输出不能是同一个文件。'
}
$temporary = Join-Path $managerOut ([guid]::NewGuid().ToString('N') + '.zip')
$inputArchive = [IO.Compression.ZipFile]::OpenRead($ManagerZip)
try {
    $outputArchive = [IO.Compression.ZipFile]::Open($temporary, 'Create')
    try {
        foreach ($entry in $inputArchive.Entries) {
            $name = $entry.FullName.Replace('\', '/')
            if ($name -match '^MelonLoader/Il2CppAssemblies/' -or
                $name -match '^MelonLoader/Dependencies/Il2CppAssemblyGenerator/(Cpp2IL/cpp2il_out/|UnityDependencies/|Config\.cfg$)' -or
                $name -match '(^|/)(Logs|saves|MaydayPackageStaging)/' -or
                $name -match '\.(log|bak)$' -or $name -eq 'README.md') { continue }
            $copy = $outputArchive.CreateEntry($name, [IO.Compression.CompressionLevel]::Optimal)
            $copy.LastWriteTime = $entry.LastWriteTime
            $inputStream = $entry.Open()
            $outputStream = $copy.Open()
            try { $inputStream.CopyTo($outputStream) }
            finally { $outputStream.Dispose(); $inputStream.Dispose() }
        }
        foreach ($document in @(
            @('docs/installation.md', 'INSTALL.md'),
            @('THIRD_PARTY_NOTICES.md', 'THIRD_PARTY_NOTICES.md'),
            @('scripts/PatchLoaderQuit.ps1', 'LoaderModification/PatchLoaderQuit.ps1')
        )) {
            [void][IO.Compression.ZipFileExtensions]::CreateEntryFromFile($outputArchive,
                (Join-Path $repoRoot $document[0]), $document[1])
        }
        $readmeEntry = $outputArchive.CreateEntry('README.md')
        $writer = [IO.StreamWriter]::new($readmeEntry.Open(), [Text.UTF8Encoding]::new($false))
        try {
            $writer.WriteLine("# Mayday 模组管理器 $managerVersion")
            $writer.WriteLine('作者：lansi  交流群：974731412')
            $writer.WriteLine('退出游戏后，将本包解压到 MaydayAirways.exe 所在目录。首次启动请保持联网，等待加载器生成本机程序集。')
            $writer.WriteLine('主菜单「设置」右侧打开「MOD 管理」。导入功能模组后，启用并重启。管理器本身不附带存档模组。')
            $writer.WriteLine('安装、升级与注意事项见 INSTALL.md，第三方组件及加载器修改声明见 THIRD_PARTY_NOTICES.md。')
            $writer.WriteLine('主页：https://github.com/LS3213/Mayday-Mod-Manager')
        } finally { $writer.Dispose() }
    } finally { $outputArchive.Dispose() }
    [IO.File]::Move($temporary, $managerTarget, $true)
} finally {
    $inputArchive.Dispose()
    if (Test-Path -LiteralPath $temporary) { Remove-Item -LiteralPath $temporary }
}
$saveTarget = Join-Path $saveOut "Mayday-Save-$saveVersion.maydaymod"
Copy-Item -LiteralPath $SavePackage -Destination $saveTarget -Force
foreach ($artifact in @($managerTarget, $saveTarget)) {
    $hash = (Get-FileHash -LiteralPath $artifact -Algorithm SHA256).Hash.ToLowerInvariant()
    $line = "$hash  $(Split-Path $artifact -Leaf)`n"
    [IO.File]::WriteAllText((Join-Path (Split-Path $artifact) 'SHA256SUMS.txt'), $line, [Text.UTF8Encoding]::new($false))
    Get-Item -LiteralPath $artifact | Select-Object Name, Length
}
