# Windows 配置脚本执行步骤指南  

## 一、解除PowerShell限制 
```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force; Get-ExecutionPolicy
```  

### 说明  
- `Set-ExecutionPolicy`：设置执行策略为 `Bypass`（无限制）。  
- `-Scope CurrentUser`：仅影响当前用户（不修改系统全局策略）。  
- `Get-ExecutionPolicy`：验证策略是否生效（输出应为 `Bypass`）。  


## 二、切换到桌面“配置”文件夹  

```powershell
$desktopPath = [Environment]::GetFolderPath('Desktop'); $targetPath = Join-Path $desktopPath '配置'; if (Test-Path $targetPath) { cd $targetPath; dir } else { Write-Error "错误：在桌面未找到配置文件夹" }
```  

### 说明  
1. `[Environment]::GetFolderPath('Desktop')`：自动获取当前用户的桌面路径（无需手动输入用户名）。  
2. `Join-Path`：拼接桌面路径和“配置”文件夹名称，避免手动输入反斜杠 `\`。  
3. `Test-Path`：检查“配置”文件夹是否存在，不存在则提示错误。  


## 三、转换脚本`windows10.ps1`编码为UTF-8无BOM格式

```powershell
$scriptName="windows10.ps1"; if (-not (Test-Path $scriptName)) { Write-Error "错误：未找到 $scriptName 脚本" } else { $backup="${scriptName}_backup.ps1"; Copy-Item $scriptName $backup -Force; try { $content=Get-Content $scriptName -Encoding UTF8 -ErrorAction Stop } catch { try { $content=Get-Content $scriptName -Encoding Default -ErrorAction Stop } catch { $content=Get-Content $scriptName -Encoding Oem } }; Set-Content $scriptName $content -Encoding UTF8; Remove-Item $backup -Force }
```  

### 说明  
1. **备份原文件**：  
   - `$backup="${scriptName}_backup.ps1"`：生成备份文件名（如 `windows10_backup.ps1`）。  
   - `Copy-Item`：复制原文件到备份，防止转换失败导致数据丢失。  
2. **自动识别编码**：  
   - 按 **UTF-8 → GBK（记事本默认） → GB2312（命令行生成）** 顺序尝试读取，覆盖99%常见编码。  
3. **转换并清理**：  
   - `Set-Content -Encoding UTF8`：写入为UTF-8无BOM格式（跨平台兼容）。  
   - `Remove-Item`：转换成功后删除临时备份，保持目录整洁。  


## 四、执行目标脚本`windows10.ps1`

```powershell
.\windows10.ps1
```  

## 注意事项
1. **文件夹命名**：  
   - 必须在桌面创建名为 **“配置”** 的文件夹（严格中文，无空格/特殊符号）。  
2. **脚本命名**：  
   - 目标脚本需命名为 **`windows10.ps1`**（与命令中的 `$scriptName` 一致）。  
3. **管理员权限**：  
   - 执行前3步时，需以 **管理员身份运行PowerShell**（右键选择“以管理员身份运行”）。  


# AutoIt 系统配置自动化工具简介  

## 一、工具定位  
**AutoIt** 是一款轻量高效的 Windows 系统自动化脚本语言，专注于系统级操作与配置自动化。通过简单脚本即可实现系统参数修改、注册表操作、批量优化清理等功能，支持全自动后台运行，无需复杂编程经验，适合系统管理员、装机人员及进阶用户快速完成重复性系统配置任务。  

## 二、下载与安装  
- **下载链接**：[AutoIt 官方下载](https://www.autoitscript.com/site/autoit/downloads/)  
- **下载链接**：[AutoIt3_Cn_v3.3.16.0-汉化增强版](https://www.autoitx.com/thread-73044-1-1.html)  

- **汉化增强版**：  
  - **中文界面**：菜单、提示信息全汉化，降低使用门槛。  
  - **集成辅助工具**：包含注册表编辑器、系统信息查看器、批量安装器等实用工具。  
- **安装步骤**：  
  - 下载后运行 `AutoItV3_In_Or_Un.exe` 进行绿化安装。

## 三、测试脚本运行环境 
  1. 下载测试脚本： `测试.au3`。
  2. 用 `AutoIt 脚本编辑器` 打开 `测试.au3`。
  3. 按下 `F5` 键直接运行，或按 `F7` 编译为 `.exe` 文件双击执行。