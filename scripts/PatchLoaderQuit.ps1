param(
    [Parameter(Mandatory)] [string]$SourceDll,
    [Parameter(Mandatory)] [string]$OutputDll
)

$ErrorActionPreference = 'Stop'
if ((Get-FileHash -LiteralPath $SourceDll).Hash -ne 'BDD43DC0F3893C208C95389B863AB61C967AE14204DA0DD8051647E754C8709B') {
    throw '退出优化只适用于本包使用的 MelonLoader 0.7.3 原版 DLL'
}
Add-Type -Path (Join-Path (Split-Path $SourceDll) 'Mono.Cecil.dll')
$assembly = [Mono.Cecil.AssemblyDefinition]::ReadAssembly($SourceDll)
try {
    $quit = $assembly.MainModule.GetType('MelonLoader.Core').Methods | Where-Object Name -eq Quit
    $calls = $quit.Body.Instructions | Where-Object { $_.Operand -is [Mono.Cecil.MethodReference] }
    $sleep = $calls | Where-Object { $_.Operand.FullName -eq 'System.Void System.Threading.Thread::Sleep(System.Int32)' }
    $forceQuit = $calls | Where-Object { $_.Operand.Name -eq 'get_ForceQuit' }
    $delay = $sleep.Previous
    $branch = $forceQuit.Next
    if ($delay.Operand -ne 200 -or $branch.OpCode.Code -ne [Mono.Cecil.Cil.Code]::Brfalse_S -or
        $branch.Operand.OpCode.Code -ne [Mono.Cecil.Cil.Code]::Ret) { throw '退出函数结构与预期不符' }

    # Preserve all cleanup and keep the delay on the explicit force-quit path.
    $il = $quit.Body.GetILProcessor()
    $il.Remove($delay)
    $il.Remove($sleep)
    $il.InsertAfter($branch, $delay)
    $il.InsertAfter($delay, $sleep)
    $assembly.Write($OutputDll)
}
finally { $assembly.Dispose() }
