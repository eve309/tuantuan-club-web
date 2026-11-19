$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Find the sakura-theme style block
$stMatch = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>')
if(-not $stMatch.Success){ Write-Output "ERROR: block not found"; exit 1 }
$old = $stMatch.Value

# Build the font override block to inject at the TOP of sakura-theme
$fontBlock = @'
<style id="sakura-theme">
/* ===== 字体系统 · Inter + Noto Sans SC ===== */
@import url('https://fonts.loli.net/css2?family=Inter:wght@300;400;500;600&display=swap');
@import url('https://fonts.loli.net/css2?family=Noto+Sans+SC:wght@300;400;500;700&display=swap');
*,*::before,*::after{font-family:"Inter","Noto Sans SC","PingFang SC","Microsoft YaHei",system-ui,sans-serif!important;letter-spacing:.02em!important;line-height:1.65!important}
h1,h2,h3,h4,h5,h6{font-weight:500!important;letter-spacing:.03em!important;line-height:1.35!important}
button,.follow-btn,.tt-submit,.tab{font-weight:500!important;letter-spacing:.03em!important}
small,.desc,.tt-foot,.rec-sub,.club-desc,.search-hint,.design-note{font-weight:300!important;font-size:.8rem!important;color:#7A8A7C!important;letter-spacing:.015em!important;line-height:1.55!important}
.club-code,.ev-type,.tt-meta,.ball-label,.me-trait,.rec-why,.me-badge,.fp-date,[class*="mbti"],[class*="zodiac"],[class*="code"]{font-family:"Inter","Noto Sans SC",system-ui,sans-serif!important;letter-spacing:.04em!important;font-weight:400!important}
input,textarea,select{font-family:"Inter","Noto Sans SC","PingFang SC","Microsoft YaHei",system-ui,sans-serif!important;font-weight:400!important;letter-spacing:.02em!important}
body{text-rendering:optimizeLegibility!important;font-variant-numeric:tabular-nums!important;font-feature-settings:"liga" 1,"kern" 1!important}
'@

# Replace the opening of the style block with the font block
$new = $old.Replace('<style id="sakura-theme">', $fontBlock)

# Remove any duplicate font-family declarations that might conflict
# (the old body/h1/p/small/button/input font rules are now superseded by the universal *)
$new = [regex]::Replace($new, 'body\{[^}]*font-family[^}]*\}', 'body{color:#2D3A2E!important}')
$new = [regex]::Replace($new, 'h1,h2,h3,h4,h5,h6\{[^}]*font-family[^}]*\}', '')
$new = [regex]::Replace($new, 'p,span,div,li,td,th,label\{[^}]*font-family[^}]*\}', '')
$new = [regex]::Replace($new, 'small,\.desc[^}]*font-family[^}]*\}', '')
$new = [regex]::Replace($new, 'button,\.follow-btn[^}]*font-family[^}]*\}', '')
$new = [regex]::Replace($new, 'input,textarea,select\{[^}]*font-family[^}]*\}', '')

# Also override the workbuddy original font-family in the FIRST style block
$h2 = $h.Replace($old, $new)
# Replace the workbuddy original body font
$h2 = $h2 -replace 'font-family:-apple-system,BlinkMacSystemFont,"PingFang SC","Microsoft YaHei","Microsoft YaHei UI",system-ui,sans-serif', 'font-family:"Inter","Noto Sans SC","PingFang SC","Microsoft YaHei",system-ui,sans-serif'

Set-Content -LiteralPath $p -Value $h2 -Encoding UTF8
Write-Output "Font override applied: Inter + Noto Sans SC"