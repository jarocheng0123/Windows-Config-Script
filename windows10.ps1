# 定义常用颜色（前景/背景通用）
$coreColors = @('Red', 'Green', 'Yellow', 'Blue', 'Cyan', 'Magenta', 'White', 'Black')


# 前景色测试（文字颜色）
Write-Host "`n[前景色测试]" -ForegroundColor Cyan
foreach ($color in $coreColors) {
    Write-Host "  $color 文字" -ForegroundColor $color
}


# 背景色测试（文字背景）
Write-Host "`n[背景色测试]" -ForegroundColor Cyan
foreach ($color in $coreColors) {
    Write-Host "  $color 背景" -BackgroundColor $color
}


# 经典颜色组合（高对比度）
Write-Host "`n[颜色组合测试]" -ForegroundColor Cyan
@(
    @('White', 'DarkBlue'),   # 白字深蓝背景（日志标题）
    @('Black', 'Yellow'),     # 黑字黄背景（警告提示）
    @('Yellow', 'DarkRed'),   # 黄字深红背景（错误警告）
    @('Cyan', 'DarkMagenta')  # 青字深紫背景（强调信息）
) | ForEach-Object {
    $fg, $bg = $_
    Write-Host "  $fg on $bg → 关键信息" -ForegroundColor $fg -BackgroundColor $bg
}


# 动态状态提示（业务常用场景）
Write-Host "`n[状态提示测试]" -ForegroundColor Cyan
[PSCustomObject]@{
    成功 = "√ 操作完成"
    警告 = "! 请检查配置"
    错误 = "× 文件丢失"
} | ForEach-Object {
    $_.PSObject.Properties | ForEach-Object {
        switch ($_.Name) {
            '成功' { Write-Host "  $($_.Value)" -ForegroundColor Green }
            '警告' { Write-Host "  $($_.Value)" -ForegroundColor Yellow }
            '错误' { Write-Host "  $($_.Value)" -ForegroundColor Red -BackgroundColor Black }
        }
    }
}


Write-Host "`n（测试完成，控制台颜色自动恢复默认）" -ForegroundColor DarkGray
