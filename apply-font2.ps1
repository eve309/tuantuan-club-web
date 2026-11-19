$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Find and replace the sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR: block not found"; exit 1 }

# Build the new block with universal font override + web font
$new = $old

# 1) Add Google Fonts import + universal font override right after <style id="sakura-theme">
$fontBase = @'
<style id="sakura-theme">
@import url('https://fonts.loli.net/css2?family=Nunito:wght@400;500;600;700&display=swap');
*,*::before,*::after{font-family:var(--font-main)!important}
'@

$new = $new.Replace('<style id="sakura-theme">', $fontBase)

# 2) Update the font variables to include Nunito
$new = $new.Replace(
    '--font-main:"MiSans","HarmonyOS Sans SC","OPPO Sans","Alibaba PuHuiTi 3.0","PingFang SC","Noto Sans SC","Source Han Sans SC","Microsoft YaHei UI","Microsoft YaHei",system-ui,-apple-system,sans-serif',
    '--font-main:"Nunito","MiSans","HarmonyOS Sans SC","OPPO Sans","Alibaba PuHuiTi 3.0","PingFang SC","Noto Sans SC","Source Han Sans SC","Microsoft YaHei UI","Microsoft YaHei",system-ui,-apple-system,sans-serif'
)
$new = $new.Replace(
    '--font-en:"MiSans","HarmonyOS Sans","Nunito","Quicksand","Varela Round","Segoe UI",system-ui,-apple-system,sans-serif',
    '--font-en:"Nunito","Varela Round","Quicksand","MiSans","HarmonyOS Sans","Segoe UI",system-ui,-apple-system,sans-serif'
)

# 3) Add English font exception AFTER the universal override (specific elements)
$enException = @'
.club-code,.ev-type,.tt-meta,.ball-label,.me-trait,.rec-why,.me-badge,.fp-date,.tt-meta small,[class*="mbti"],[class*="zodiac"],[class*="code"],[class*="date"]{font-family:var(--font-en)!important;letter-spacing:.04em!important}
'@
# Insert after the universal override line
$new = $new.Replace(
    '*,*::before,*::after{font-family:var(--font-main)!important}',
    '*,*::before,*::after{font-family:var(--font-main)!important}' + "`n" + $enException
)

# 4) Add text rendering improvements
$textProps = @'
body{text-rendering:optimizeLegibility;font-variant-numeric:tabular-nums;font-feature-settings:"liga" 1,"kern" 1}
h1,h2,h3,h4,h5,h6{font-weight:700!important;letter-spacing:.04em!important;line-height:1.3!important}
p,span,li,label,td,th{line-height:1.7!important;letter-spacing:.025em!important}
small,.desc,.tt-foot,.rec-sub{letter-spacing:.02em!important;line-height:1.55!important}
'@
# Insert after the font variables
$new = $new.Replace(
    ':root{--brand:',
    $textProps + ':root{--brand:'
)

# 5) Ensure the font variables are defined at the very top of :root
# Check if --font-main already exists
if(-not $new.Contains('--font-main')){
    # Add font variables before --brand
    $new = $new.Replace(
        ':root{--brand:',
        ':root{--font-main:"Nunito","MiSans","HarmonyOS Sans SC","OPPO Sans","Alibaba PuHuiTi 3.0","PingFang SC","Noto Sans SC","Source Han Sans SC","Microsoft YaHei UI","Microsoft YaHei",system-ui,-apple-system,sans-serif;--font-en:"Nunito","Varela Round","Quicksand","MiSans","HarmonyOS Sans","Segoe UI",system-ui,-apple-system,sans-serif;--brand:'
    )
}

# 6) Add monospace override for code elements
$monoOverride = @'
code,pre,kbd,.club-code-monospace{font-family:var(--font-mono,"MiSans","SF Mono","Cascadia Code",ui-monospace,monospace)!important}
'@
$new = $new.Replace(
    $enException,
    $enException + "`n" + $monoOverride
)

# 7) Remove the old body font-family if it conflicts
# The universal * override should handle it, but let's also update body specifically
$new = $new.Replace(
    'body{color:#2D3A2E!important;font-family:',
    'body{color:#2D3A2E!important;font-family:var(--font-main)!important;font-family:'
)

$h = $h.Replace($old, $new)
Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Universal font override + Nunito web font applied"