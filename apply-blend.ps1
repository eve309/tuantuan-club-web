$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Replace sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR"; exit 1 }

$new = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}
/* ===== 单容器三层交融流体 ===== */
.fluid-bg{position:fixed;inset:0;z-index:-3;pointer-events:none;overflow:hidden}
.fluid-bg>div{position:absolute;inset:-40%;will-change:transform}
/* ── 绿色层：大幅扩散，边缘延伸到中心区域与粉蓝重叠 ── */
.fl-green{background:radial-gradient(ellipse 55% 48% at 25% 35%,rgba(201,230,163,.55) 0%,rgba(184,217,140,.35) 30%,rgba(223,240,188,.18) 55%,rgba(223,240,188,.06) 75%,transparent 92%);animation:flG 24s ease-in-out infinite alternate}
@keyframes flG{0%{transform:translate(-4%,-2%) rotate(-3deg) scale(1)}33%{transform:translate(3%,1.5%) rotate(2deg) scale(1.07)}66%{transform:translate(-1%,-3%) rotate(1deg) scale(1.03)}100%{transform:translate(-2%,2.5%) rotate(-2deg) scale(1.02)}}
/* ── 粉色层：大幅扩散，与绿色在 40-55% 区域重叠混色 ── */
.fl-pink{background:radial-gradient(ellipse 50% 45% at 72% 28%,rgba(246,200,212,.5) 0%,rgba(240,175,195,.3) 30%,rgba(252,228,235,.15) 55%,rgba(252,228,235,.05) 78%,transparent 92%);animation:flP 18s ease-in-out infinite alternate}
@keyframes flP{0%{transform:translate(3%,2%) rotate(2.5deg) scale(1.06)}50%{transform:translate(-3.5%,-1.5%) rotate(-2.5deg) scale(1)}100%{transform:translate(1.5%,3%) rotate(3deg) scale(1.08)}}
/* ── 蓝色层：大幅扩散，上缘延伸到中部与绿粉重叠 ── */
.fl-blue{background:radial-gradient(ellipse 55% 45% at 50% 82%,rgba(169,214,232,.5) 0%,rgba(140,195,222,.3) 30%,rgba(200,225,245,.15) 55%,rgba(200,225,245,.05) 78%,transparent 92%);animation:flB 28s ease-in-out infinite alternate}
@keyframes flB{0%{transform:translate(0,2%) scale(1.03)}50%{transform:translate(-2.5%,-1.5%) rotate(-2deg) scale(1.07)}100%{transform:translate(2%,-.5%) rotate(1.5deg) scale(1.01)}}
/* ── 混色增强层：在交界处添加混色色斑（绿粉/粉蓝/绿蓝） ── */
.fl-blend{background:
 radial-gradient(ellipse 18% 14% at 48% 30%,rgba(223,240,188,.25) 0%,rgba(252,228,235,.15) 50%,transparent 75%),
 radial-gradient(ellipse 15% 12% at 62% 55%,rgba(216,204,240,.2) 0%,rgba(200,225,245,.1) 50%,transparent 72%),
 radial-gradient(ellipse 16% 13% at 38% 58%,rgba(184,220,200,.18) 0%,rgba(169,214,232,.08) 50%,transparent 72%),
 radial-gradient(ellipse 12% 10% at 55% 42%,rgba(255,251,240,.2) 0%,transparent 68%);animation:flM 20s ease-in-out infinite alternate}
@keyframes flM{0%{transform:translate(-1%,1%) rotate(-1deg) scale(1)}50%{transform:translate(1.5%,-.5%) rotate(1deg) scale(1.05)}100%{transform:translate(-.5%,1.5%) rotate(-.5deg) scale(1.02)}}
/* ── 高光层：波脊棱线 + 漩涡 + 光斑 ── */
.fl-hl{background:repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.22) 5.5%,rgba(255,255,255,.38) 7%,rgba(255,255,255,.15) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.1) 17%,transparent 20%),repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.14) 8.5%,rgba(255,255,255,.22) 9.5%,transparent 11%,transparent 18%),linear-gradient(135deg,transparent 12%,rgba(255,255,255,.2) 18%,transparent 25%),linear-gradient(115deg,transparent 42%,rgba(255,255,255,.14) 50%,transparent 58%),conic-gradient(from 180deg at 18% 70%,transparent 0%,rgba(255,255,255,.12) 12%,transparent 25%,rgba(255,255,255,.08) 40%,transparent 55%,rgba(255,255,255,.1) 70%,transparent 85%);mix-blend-mode:overlay;animation:flH 14s linear infinite}
@keyframes flH{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%,50% 50%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%,100% 100%}}
/* ── 远景雾化 ── */
.fl-fog{background:radial-gradient(ellipse 80% 55% at 50% -10%,rgba(253,247,236,.6) 0%,rgba(246,200,212,.15) 40%,transparent 70%);animation:flF 30s ease-in-out infinite alternate}
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

# Update fluid-bg div to include blend layer
$oldFluid = [regex]::Match($h, '<div class="fluid-bg"[^>]*>[\s\S]*?</div>\s*(?=<div class="petals)').Value
if($oldFluid){
    $newFluid = '<div class="fluid-bg" aria-hidden="true"><div class="fl-fog"></div><div class="fl-green"></div><div class="fl-pink"></div><div class="fl-blue"></div><div class="fl-blend"></div><div class="fl-hl"></div></div>'
    $h = $h.Replace($oldFluid, $newFluid)
}

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Blend fluid applied: $($new.Length) chars"