$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Replace sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR"; exit 1 }

$new = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}
/* ===== L0: 参考图真实液态树脂纹理底图 ===== */
.fl-tex{position:fixed;inset:0;z-index:-5;pointer-events:none;background:url('assets/water-texture.jpg') center/cover no-repeat}
/* ===== L1: 绿色流动（hue blend 只改色相保留纹理） ===== */
.fl-grn{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 50% 42% at 25% 35%,rgba(201,230,163,.45) 0%,rgba(184,217,140,.25) 35%,rgba(223,240,188,.1) 60%,transparent 82%);mix-blend-mode:hue;animation:skG 22s ease-in-out infinite alternate;will-change:transform}
@keyframes skG{0%{transform:translate(-3%,-2%) rotate(-2.5deg) scale(1)}33%{transform:translate(2.5%,1%) rotate(1.5deg) scale(1.06)}66%{transform:translate(-1%,-2.5%) rotate(.8deg) scale(1.03)}100%{transform:translate(-1.5%,2%) rotate(-1.5deg) scale(1.02)}}
/* ===== L2: 粉色流动 ===== */
.fl-pnk{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 45% 40% at 72% 25%,rgba(246,200,212,.35) 0%,rgba(240,175,195,.2) 35%,rgba(252,228,235,.08) 60%,transparent 80%);mix-blend-mode:hue;animation:skP 17s ease-in-out infinite alternate;will-change:transform}
@keyframes skP{0%{transform:translate(2.5%,1.5%) rotate(2deg) scale(1.05)}50%{transform:translate(-2.5%,-1%) rotate(-2deg) scale(1)}100%{transform:translate(1%,2.5%) rotate(2.5deg) scale(1.07)}}
/* ===== L3: 蓝色流动 ===== */
.fl-blu{position:fixed;inset:-25%;z-index:-4;pointer-events:none;background:radial-gradient(ellipse 50% 42% at 50% 80%,rgba(169,214,232,.3) 0%,rgba(140,195,222,.18) 35%,rgba(200,225,245,.06) 60%,transparent 82%);mix-blend-mode:hue;animation:skB 28s ease-in-out infinite alternate;will-change:transform}
@keyframes skB{0%{transform:translate(0,1.5%) scale(1.02)}50%{transform:translate(-2%,-1%) rotate(-1.5deg) scale(1.06)}100%{transform:translate(1.5%,-.5%) rotate(1deg) scale(1.01)}}
/* ===== L4: 交融混色带（三色交界处） ===== */
.fl-blend{position:fixed;inset:-15%;z-index:-3;pointer-events:none;background:radial-gradient(ellipse 16% 12% at 48% 30%,rgba(223,240,188,.18) 0%,rgba(252,228,235,.1) 50%,transparent 72%),radial-gradient(ellipse 14% 10% at 60% 52%,rgba(216,204,240,.12) 0%,transparent 70%),radial-gradient(ellipse 15% 12% at 38% 55%,rgba(184,220,200,.1) 0%,transparent 70%),radial-gradient(ellipse 10% 8% at 52% 42%,rgba(255,251,240,.15) 0%,transparent 65%);animation:skM 20s ease-in-out infinite alternate;will-change:transform}
@keyframes skM{0%{transform:translate(-.8%,.8%) rotate(-.8deg) scale(1)}50%{transform:translate(1.2%,-.4%) rotate(.8deg) scale(1.04)}100%{transform:translate(-.4%,1.2%) rotate(-.4deg) scale(1.015)}}
/* ===== L5: 高光棱线（soft-light 在纹理上产生液面反光） ===== */
.fl-hl{position:fixed;inset:-15%;z-index:-2;pointer-events:none;background:repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.15) 5.5%,rgba(255,255,255,.28) 7%,rgba(255,255,255,.1) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.08) 17%,transparent 20%),repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.08) 8.5%,rgba(255,255,255,.16) 9.5%,transparent 11%,transparent 18%),linear-gradient(135deg,transparent 12%,rgba(255,255,255,.12) 18%,transparent 25%),linear-gradient(115deg,transparent 42%,rgba(255,255,255,.08) 50%,transparent 58%);mix-blend-mode:soft-light;animation:skH 14s linear infinite;will-change:transform}
@keyframes skH{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%}}
/* ===== 玻璃卡片 ===== */
.topbar{background:rgba(255,255,255,.55)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.3)!important}
.brand-txt{color:#4A6B8A!important;font-weight:800!important}
.tab.active{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border-radius:999px!important;backdrop-filter:blur(10px)}
.tab:hover{background:rgba(255,255,255,.15)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.4)!important;backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.4)!important;border-radius:18px!important;box-shadow:0 4px 20px rgba(100,150,200,.06),inset 0 1px 0 rgba(255,255,255,.35)!important}
.club-cover{border-radius:14px 14px 0 0!important;overflow:hidden}
.club-tag{background:rgba(255,255,255,.25)!important;color:#4A6B8A!important;border:1px solid rgba(255,255,255,.3)!important;border-radius:999px!important;backdrop-filter:blur(6px)}
.follow-btn,.tt-submit{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border:1px solid rgba(255,255,255,.5)!important;border-radius:12px!important;backdrop-filter:blur(6px)}
.rec-why,.me-trait{background:rgba(255,255,255,.2)!important;color:#4A6B8A!important;border:1px solid rgba(255,255,255,.25)!important;border-radius:999px!important;backdrop-filter:blur(4px)}
.banner{--sky1:rgba(169,214,232,.4)!important;--sky2:rgba(246,200,212,.3)!important;border-radius:20px!important}
.ev-type{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border-radius:999px!important;backdrop-filter:blur(6px)}
input,textarea,select{background:rgba(255,255,255,.4)!important;border:1.5px solid rgba(255,255,255,.4)!important;border-radius:12px!important;color:#2D3A2E!important}
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
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
'@

$h = $h.Replace($old, $new)

# Replace fluid layers with texture-based layers
$oldFluid = [regex]::Match($h, '<div class="fluid-bg"[^>]*>[\s\S]*?</div>\s*(?=<div class="petals)').Value
if($oldFluid){
    $newFluid = '<div class="fl-tex" aria-hidden="true"></div><div class="fl-grn" aria-hidden="true"></div><div class="fl-pnk" aria-hidden="true"></div><div class="fl-blu" aria-hidden="true"></div><div class="fl-blend" aria-hidden="true"></div><div class="fl-hl" aria-hidden="true"></div>'
    $h = $h.Replace($oldFluid, $newFluid)
}
# Also replace water-* divs if present
$h = [regex]::Replace($h, '<div class="water-base"[^>]*></div>\s*<div class="water-ripple"[^>]*></div>\s*<div class="water-expand"[^>]*></div>\s*<div class="water-tint"[^>]*></div>\s*<div class="water-glow"[^>]*></div>', '<div class="fl-tex" aria-hidden="true"></div><div class="fl-grn" aria-hidden="true"></div><div class="fl-pnk" aria-hidden="true"></div><div class="fl-blu" aria-hidden="true"></div><div class="fl-blend" aria-hidden="true"></div><div class="fl-hl" aria-hidden="true"></div>')

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Texture + fluid applied: $($new.Length) chars"