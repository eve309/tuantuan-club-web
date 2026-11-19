$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Replace the sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR"; exit 1 }

$new = @'
<style id="sakura-theme">
/* ===== 字体系统 ===== */
:root{--font-main:"MiSans","HarmonyOS Sans SC","OPPO Sans","Alibaba PuHuiTi 3.0","PingFang SC","Noto Sans SC","Source Han Sans SC","Microsoft YaHei UI","Microsoft YaHei",system-ui,-apple-system,sans-serif;--font-en:"MiSans","HarmonyOS Sans","Nunito","Quicksand","Varela Round","Segoe UI",system-ui,-apple-system,sans-serif;--font-mono:"MiSans","HarmonyOS Sans","SF Mono","Cascadia Code","Segoe UI Mono",ui-monospace,monospace}
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important;--fs-title:1.35rem;--fs-body:.9rem;--fs-small:.8rem;--fs-tiny:.72rem;--lh:1.65;--ls:.02em}
body{color:#2D3A2E!important;font-family:var(--font-main)!important;font-size:var(--fs-body)!important;line-height:var(--lh)!important;letter-spacing:var(--ls)!important;overflow-x:hidden!important;-webkit-font-smoothing:antialiased;-moz-osx-font-smoothing:grayscale}
h1,h2,h3,h4,h5,h6{font-family:var(--font-main)!important;font-weight:700!important;letter-spacing:.03em!important;line-height:1.35!important}
p,span,div,li,td,th,label{font-family:var(--font-main)!important}
small,.desc,.tt-foot,.rec-sub,.club-desc,.search-hint,.design-note{font-size:var(--fs-small)!important;color:#8A9A8C!important;line-height:1.55!important;letter-spacing:.015em!important}
/* 英文数字等使用圆润西文 */
.club-code,.ev-type,.tt-meta,.ball-label,.me-trait,.rec-why,[class*="mbti"],[class*="zodiac"],[class*="code"]{font-family:var(--font-en)!important;letter-spacing:.03em!important}
.club-code{font-size:var(--fs-tiny)!important;font-weight:600!important}
/* 按钮 */
button,.follow-btn,.tt-submit,.tab{font-family:var(--font-main)!important;font-weight:600!important;letter-spacing:.04em!important}
/* 输入框 */
input,textarea,select{font-family:var(--font-main)!important;font-size:var(--fs-body)!important;letter-spacing:.02em!important}
/* ===== 背景流体 ===== */
.fl-tex{position:fixed;inset:0;z-index:-5;pointer-events:none;background:url('assets/water-texture.jpg') center/cover no-repeat}
.fl-grn{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 50% 42% at 25% 35%,rgba(201,230,163,.45) 0%,rgba(184,217,140,.25) 35%,rgba(223,240,188,.1) 60%,transparent 82%);mix-blend-mode:hue;animation:skG 22s ease-in-out infinite alternate;will-change:transform}
@keyframes skG{0%{transform:translate(-3%,-2%) rotate(-2.5deg) scale(1)}33%{transform:translate(2.5%,1%) rotate(1.5deg) scale(1.06)}66%{transform:translate(-1%,-2.5%) rotate(.8deg) scale(1.03)}100%{transform:translate(-1.5%,2%) rotate(-1.5deg) scale(1.02)}}
.fl-pnk{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 45% 40% at 72% 25%,rgba(246,200,212,.35) 0%,rgba(240,175,195,.2) 35%,rgba(252,228,235,.08) 60%,transparent 80%);mix-blend-mode:hue;animation:skP 17s ease-in-out infinite alternate;will-change:transform}
@keyframes skP{0%{transform:translate(2.5%,1.5%) rotate(2deg) scale(1.05)}50%{transform:translate(-2.5%,-1%) rotate(-2deg) scale(1)}100%{transform:translate(1%,2.5%) rotate(2.5deg) scale(1.07)}}
.fl-blu{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 50% 42% at 50% 80%,rgba(169,214,232,.3) 0%,rgba(140,195,222,.18) 35%,rgba(200,225,245,.06) 60%,transparent 82%);mix-blend-mode:hue;animation:skB 28s ease-in-out infinite alternate;will-change:transform}
@keyframes skB{0%{transform:translate(0,1.5%) scale(1.02)}50%{transform:translate(-2%,-1%) rotate(-1.5deg) scale(1.06)}100%{transform:translate(1.5%,-.5%) rotate(1deg) scale(1.01)}}
.fl-blend{position:fixed;inset:-15%;z-index:-3;pointer-events:none;background:radial-gradient(ellipse 16% 12% at 48% 30%,rgba(223,240,188,.18) 0%,rgba(252,228,235,.1) 50%,transparent 72%),radial-gradient(ellipse 14% 10% at 60% 52%,rgba(216,204,240,.12) 0%,transparent 70%),radial-gradient(ellipse 15% 12% at 38% 55%,rgba(184,220,200,.1) 0%,transparent 70%),radial-gradient(ellipse 10% 8% at 52% 42%,rgba(255,251,240,.15) 0%,transparent 65%);animation:skM 20s ease-in-out infinite alternate;will-change:transform}
@keyframes skM{0%{transform:translate(-.8%,.8%) rotate(-.8deg) scale(1)}50%{transform:translate(1.2%,-.4%) rotate(.8deg) scale(1.04)}100%{transform:translate(-.4%,1.2%) rotate(-.4deg) scale(1.015)}}
.fl-hl{position:fixed;inset:-15%;z-index:-2;pointer-events:none;background:repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.15) 5.5%,rgba(255,255,255,.28) 7%,rgba(255,255,255,.1) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.08) 17%,transparent 20%),repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.08) 8.5%,rgba(255,255,255,.16) 9.5%,transparent 11%,transparent 18%),linear-gradient(135deg,transparent 12%,rgba(255,255,255,.12) 18%,transparent 25%),linear-gradient(115deg,transparent 42%,rgba(255,255,255,.08) 50%,transparent 58%);mix-blend-mode:soft-light;animation:skH 14s linear infinite;will-change:transform}
@keyframes skH{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%}}
/* ===== 玻璃卡片 ===== */
.topbar{background:rgba(255,255,255,.55)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.3)!important}
.brand-txt{color:#4A8FBF!important;font-weight:800!important;letter-spacing:.05em!important}
.tab.active{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border-radius:999px!important;backdrop-filter:blur(10px)}
.tab:hover{background:rgba(255,255,255,.15)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.4)!important;backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.4)!important;border-radius:18px!important;box-shadow:0 4px 20px rgba(100,150,200,.06),inset 0 1px 0 rgba(255,255,255,.35)!important}
.club-cover{border-radius:14px 14px 0 0!important;overflow:hidden}
.club-tag{background:rgba(255,255,255,.25)!important;color:#4A6B8A!important;border:1px solid rgba(255,255,255,.3)!important;border-radius:999px!important;backdrop-filter:blur(6px)}
.follow-btn,.tt-submit{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border:1px solid rgba(255,255,255,.5)!important;border-radius:12px!important;backdrop-filter:blur(6px)}
.rec-why,.me-trait{background:rgba(255,255,255,.2)!important;color:#4A6B8A!important;border:1px solid rgba(255,255,255,.25)!important;border-radius:999px!important;backdrop-filter:blur(4px)}
.banner{--sky1:rgba(169,214,232,.4)!important;--sky2:rgba(246,200,212,.3)!important;border-radius:20px!important}
.ev-type{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border-radius:999px!important;backdrop-filter:blur(6px)}
.club-name{font-weight:700!important;letter-spacing:.03em!important;color:#2D3A2E!important;white-space:nowrap!important;overflow:hidden!important;text-overflow:ellipsis!important}
.club-desc{color:#6B7B6E!important;line-height:1.55!important;font-size:var(--fs-small)!important}
input,textarea,select{background:rgba(255,255,255,.4)!important;border:1.5px solid rgba(255,255,255,.4)!important;border-radius:12px!important;color:#2D3A2E!important;font-family:var(--font-main)!important}
input:focus,textarea:focus{border-color:rgba(255,255,255,.6)!important;box-shadow:0 0 0 3px rgba(255,255,255,.15)!important}
::-webkit-scrollbar{width:6px}::-webkit-scrollbar-thumb{background:rgba(255,255,255,.3);border-radius:3px}
::selection{background:rgba(255,255,255,.25)}
/* ===== 显隐 ===== */
body.gate-active .topbar,body.gate-active .ai-ball,body.gate-active .tt-menu{display:none!important}
body.on-square .ai-ball{position:fixed;right:28px;top:50%;transform:translateY(-50%);bottom:auto;z-index:60}
body:not(.gate-active):not(.on-square) .ai-ball{display:none!important}
/* ===== 樱花瓣 ===== */
.petal{position:fixed;top:-5vh;width:11px;height:11px;background:linear-gradient(135deg,rgba(252,228,235,.8),rgba(246,200,212,.6));border-radius:80% 0 80% 0;opacity:0;pointer-events:none;z-index:1;backdrop-filter:blur(2px)}
.petal:nth-child(1){left:5%;animation:pf 14s linear infinite}
.petal:nth-child(2){left:14%;width:8px;height:8px;animation:pf 18s linear infinite;animation-delay:3s}
.petal:nth-child(3){left:88%;width:9px;height:9px;animation:pf 15s linear infinite;animation-delay:5s}
.petal:nth-child(4){left:94%;width:7px;height:7px;animation:pf 20s linear infinite;animation-delay:8s}
.petal:nth-child(5){left:72%;width:10px;height:10px;animation:pf 16s linear infinite;animation-delay:2s}
.petal:nth-child(6){left:28%;width:6px;height:6px;animation:pf 22s linear infinite;animation-delay:6s}
@keyframes pf{0%{transform:translateY(0) rotate(0);opacity:0}5%{opacity:.6}25%{transform:translateY(25vh) translateX(25px) rotate(90deg)}50%{transform:translateY(50vh) translateX(-18px) rotate(180deg);opacity:.5}75%{transform:translateY(75vh) translateX(22px) rotate(270deg);opacity:.3}95%{opacity:.1}100%{transform:translateY(105vh) rotate(360deg);opacity:0}}
@media(prefers-reduced-motion:reduce){.fl-grn,.fl-pnk,.fl-blu,.fl-blend,.fl-hl{animation:none}.petal{animation:none;opacity:0}}
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}body{font-size:.85rem!important}}
</style>
'@

$h = $h.Replace($old, $new)
Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Font system applied: $($new.Length) chars"