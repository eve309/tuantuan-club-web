$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# 1) Replace sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR"; exit 1 }

$new = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--brand-soft:rgba(246,200,212,.15)!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important;--shadow:0 8px 32px rgba(140,195,138,.1)!important;--shadow-lg:0 18px 60px rgba(240,175,195,.15)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}
/* ===== 流体背景容器 ===== */
.fluid-bg{position:fixed;inset:0;z-index:-3;pointer-events:none;overflow:hidden}
.fluid-bg>div{position:absolute;inset:-50%;will-change:transform}
/* ── 绿色层：大色块，缓慢左漂+微旋 ── */
.fl-green{background:radial-gradient(ellipse 38% 32% at 30% 30%,rgba(201,230,163,.7) 0%,rgba(184,217,140,.45) 38%,transparent 68%),radial-gradient(ellipse 25% 20% at 55% 55%,rgba(184,217,140,.3) 0%,transparent 60%);animation:flG 22s ease-in-out infinite alternate}
@keyframes flG{0%{transform:translate(-4%,-2%) rotate(-3deg) scale(1)}33%{transform:translate(2%,1%) rotate(2deg) scale(1.06)}66%{transform:translate(1%,-3%) rotate(1deg) scale(1.03)}100%{transform:translate(-2%,2%) rotate(-1.5deg) scale(1.02)}}
/* ── 粉色层：中色块，反向右漂+翻转 ── */
.fl-pink{background:radial-gradient(ellipse 32% 28% at 70% 22%,rgba(246,200,212,.65) 0%,rgba(240,175,195,.4) 38%,transparent 65%),radial-gradient(ellipse 22% 18% at 85% 55%,rgba(240,175,195,.3) 0%,transparent 58%);animation:flP 17s ease-in-out infinite alternate}
@keyframes flP{0%{transform:translate(3%,2%) rotate(2.5deg) scale(1.05)}50%{transform:translate(-3%,-1%) rotate(-2deg) scale(1)}100%{transform:translate(1%,3%) rotate(3.5deg) scale(1.07)}}
/* ── 蓝色层：底部大色块，上下涌动 ── */
.fl-blue{background:radial-gradient(ellipse 42% 32% at 50% 80%,rgba(169,214,232,.6) 0%,rgba(140,195,222,.35) 40%,transparent 68%),radial-gradient(ellipse 28% 22% at 30% 88%,rgba(140,195,222,.25) 0%,transparent 60%);animation:flB 26s ease-in-out infinite alternate}
@keyframes flB{0%{transform:translate(0,2%) scale(1.02)}50%{transform:translate(-2%,-1%) rotate(-1.5deg) scale(1.06)}100%{transform:translate(2%,-.5%) rotate(1deg) scale(1.01)}}
/* ── 高光层：波脊棱线 + 漩涡 + 光斑 ── */
.fl-hl{background:repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.25) 5.5%,rgba(255,255,255,.4) 7%,rgba(255,255,255,.15) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.12) 17%,transparent 20%),repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.15) 8.5%,rgba(255,255,255,.25) 9.5%,transparent 11%,transparent 18%),linear-gradient(135deg,transparent 12%,rgba(255,255,255,.2) 18%,transparent 25%),linear-gradient(115deg,transparent 42%,rgba(255,255,255,.14) 50%,transparent 58%),conic-gradient(from 180deg at 18% 70%,transparent 0%,rgba(255,255,255,.12) 12%,transparent 25%,rgba(255,255,255,.08) 40%,transparent 55%,rgba(255,255,255,.1) 70%,transparent 85%);mix-blend-mode:overlay;animation:flH 14s linear infinite}
@keyframes flH{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%,50% 50%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%,100% 100%}}
/* ── 远景雾化层 ── */
.fl-fog{background:radial-gradient(ellipse 80% 55% at 50% -10%,rgba(253,247,236,.7) 0%,rgba(246,200,212,.2) 40%,transparent 70%);animation:flF 30s ease-in-out infinite alternate}
@keyframes flF{0%{transform:translate(0,0) scale(1)}100%{transform:translate(-2%,1%) scale(1.04)}}
/* ===== 玻璃卡片 ===== */
.topbar{background:rgba(255,255,255,.6)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(240,175,195,.2)!important}
.brand-txt{color:#E9A0B8!important;font-weight:800!important}
.tab.active{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border-radius:999px!important}
.tab:hover{background:rgba(246,200,212,.1)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.5)!important;border:1px solid rgba(255,255,255,.65)!important;border-radius:18px!important;box-shadow:0 6px 28px rgba(180,160,190,.08),inset 0 1px 0 rgba(255,255,255,.5)!important}
.club-cover{border-radius:14px 14px 0 0!important;overflow:hidden}
.club-tag{background:rgba(246,200,212,.12)!important;color:#E9A0B8!important;border:1px solid rgba(240,175,195,.2)!important;border-radius:999px!important}
.follow-btn,.tt-submit{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border:none!important;border-radius:12px!important}
.rec-why,.me-trait{background:rgba(246,200,212,.1)!important;color:#E9A0B8!important;border:1px solid rgba(240,175,195,.15)!important;border-radius:999px!important}
.banner{--sky1:#F6C8D4!important;--sky2:#C9E6A3!important;border-radius:20px!important}
.ev-type{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border-radius:999px!important}
input,textarea,select{background:rgba(255,255,255,.6)!important;border:1.5px solid rgba(169,214,232,.35)!important;border-radius:12px!important;color:#2D3A2E!important}
input:focus,textarea:focus{border-color:rgba(240,175,195,.5)!important;box-shadow:0 0 0 3px rgba(240,175,195,.1)!important}
::-webkit-scrollbar{width:6px}::-webkit-scrollbar-thumb{background:rgba(240,175,195,.3);border-radius:3px}
::selection{background:rgba(246,200,212,.3)}
/* ===== 显隐 ===== */
body.gate-active .topbar,body.gate-active .ai-ball,body.gate-active .tt-menu{display:none!important}
body.on-square .ai-ball{position:fixed;right:28px;top:50%;transform:translateY(-50%);bottom:auto;z-index:60}
body:not(.gate-active):not(.on-square) .ai-ball{display:none!important}
/* ===== 樱花瓣 ===== */
.petal{position:fixed;top:-5vh;width:11px;height:11px;background:linear-gradient(135deg,#F6C8D4,#F0AFC3);border-radius:80% 0 80% 0;opacity:0;pointer-events:none;z-index:1}
.petal:nth-child(1){left:5%;animation:pf 14s linear infinite}
.petal:nth-child(2){left:14%;width:8px;height:8px;animation:pf 18s linear infinite;animation-delay:3s}
.petal:nth-child(3){left:88%;width:9px;height:9px;animation:pf 15s linear infinite;animation-delay:5s}
.petal:nth-child(4){left:94%;width:7px;height:7px;animation:pf 20s linear infinite;animation-delay:8s}
.petal:nth-child(5){left:72%;width:10px;height:10px;animation:pf 16s linear infinite;animation-delay:2s}
.petal:nth-child(6){left:28%;width:6px;height:6px;animation:pf 22s linear infinite;animation-delay:6s}
@keyframes pf{0%{transform:translateY(0) rotate(0);opacity:0}5%{opacity:.6}25%{transform:translateY(25vh) translateX(25px) rotate(90deg)}50%{transform:translateY(50vh) translateX(-18px) rotate(180deg);opacity:.5}75%{transform:translateY(75vh) translateX(22px) rotate(270deg);opacity:.3}95%{opacity:.1}100%{transform:translateY(105vh) rotate(360deg);opacity:0}}
@media(prefers-reduced-motion:reduce){.fluid-bg>div{animation:none}.petal{animation:none;opacity:0}}
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
'@

$h = $h.Replace($old, $new)

# 2) Add fluid-bg div after petals (or before petals)
$fluidDiv = @'
<div class="fluid-bg" aria-hidden="true"><div class="fl-fog"></div><div class="fl-green"></div><div class="fl-pink"></div><div class="fl-blue"></div><div class="fl-hl"></div></div>
'@
if($h -notmatch 'class="fluid-bg"'){
    $h = $h.Replace('<div class="petals"', $fluidDiv + '`n<div class="petals"')
}

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "3-color fluid applied: $($new.Length) chars"