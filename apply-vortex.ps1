$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Replace the entire sakura-theme style block
$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR: block not found"; exit 1 }

$new = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}

/* ===== L0: 参考图真实水波纹理底图 ===== */
.water-base{position:fixed;inset:0;z-index:-5;pointer-events:none;background:url('assets/water-texture.jpg') center/cover no-repeat}

/* ===== L1: 同心圆涟漪层（中心 48%,55% 向外扩散，缓慢旋转） ===== */
.water-ripple{position:fixed;inset:-50%;z-index:-4;pointer-events:none;
background:repeating-radial-gradient(circle at 48% 55%,
  transparent 0%,transparent 3%,
  rgba(255,255,255,.12) 4%,rgba(255,255,255,.25) 4.8%,rgba(255,255,255,.08) 5.5%,
  transparent 7%,transparent 9%,
  rgba(255,255,255,.08) 10%,rgba(255,255,255,.18) 10.8%,rgba(255,255,255,.05) 11.5%,
  transparent 13%,transparent 15%,
  rgba(255,255,255,.06) 16%,rgba(255,255,255,.14) 16.8%,rgba(255,255,255,.04) 17.5%,
  transparent 19%,transparent 21%,
  rgba(255,255,255,.05) 22%,rgba(255,255,255,.1) 22.8%,transparent 24%,
  transparent 27%,transparent 30%,
  rgba(255,255,255,.04) 31%,rgba(255,255,255,.08) 31.8%,transparent 33%,
  transparent 37%,transparent 42%,
  rgba(255,255,255,.03) 43%,rgba(255,255,255,.06) 43.8%,transparent 45%
);mix-blend-mode:overlay;animation:ripple-spin 40s linear infinite;will-change:transform}
@keyframes ripple-spin{0%{transform:rotate(0deg) scale(1)}100%{transform:rotate(360deg) scale(1)}}

/* ===== L2: 涟漪扩散层（缓慢放大模拟水波扩散） ===== */
.water-expand{position:fixed;inset:-50%;z-index:-3;pointer-events:none;
background:radial-gradient(circle at 48% 55%,transparent 0%,transparent 12%,rgba(255,255,255,.06) 14%,transparent 16%,transparent 25%,rgba(255,255,255,.04) 27%,transparent 29%,transparent 40%,rgba(255,255,255,.03) 42%,transparent 44%);animation:ripple-expand 12s ease-out infinite;will-change:transform,opacity}
@keyframes ripple-expand{0%{transform:scale(.8);opacity:.6}100%{transform:scale(1.5);opacity:0}}

/* ===== L3: 三色流体薄层（hue blend 在纹理上着色） ===== */
.water-tint{position:fixed;inset:-20%;z-index:-3;pointer-events:none;
background:
 radial-gradient(ellipse 40% 35% at 20% 30%,rgba(201,230,163,.25) 0%,transparent 65%),
 radial-gradient(ellipse 35% 30% at 75% 25%,rgba(246,200,212,.25) 0%,transparent 60%),
 radial-gradient(ellipse 45% 38% at 50% 85%,rgba(169,214,232,.25) 0%,transparent 65%);
mix-blend-mode:hue;animation:tint-drift 25s ease-in-out infinite alternate;will-change:transform}
@keyframes tint-drift{0%{transform:translate(-3%,-2%) rotate(-2deg) scale(1)}50%{transform:translate(2%,1%) rotate(1.5deg) scale(1.04)}100%{transform:translate(-1%,2%) rotate(-1deg) scale(1.02)}}

/* ===== L4: 柔光层（左上光晕 + 逆光效果） ===== */
.water-glow{position:fixed;inset:0;z-index:-2;pointer-events:none;
background:radial-gradient(ellipse 50% 40% at 15% 10%,rgba(255,255,255,.35) 0%,rgba(200,225,245,.15) 35%,transparent 65%);animation:glow-pulse 20s ease-in-out infinite alternate;will-change:opacity}
@keyframes glow-pulse{0%{opacity:.7}100%{opacity:.45}}

/* ===== 玻璃卡片 ===== */
.topbar{background:rgba(255,255,255,.55)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.3)!important}
.brand-txt{color:#4A8FBF!important;font-weight:800!important}
.tab.active{background:rgba(255,255,255,.3)!important;color:#3A6B8A!important;border-radius:999px!important;backdrop-filter:blur(10px)}
.tab:hover{background:rgba(255,255,255,.15)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.35)!important;backdrop-filter:blur(12px);-webkit-backdrop-filter:blur(12px);border:1px solid rgba(255,255,255,.4)!important;border-radius:18px!important;box-shadow:0 4px 20px rgba(100,150,200,.08),inset 0 1px 0 rgba(255,255,255,.4)!important}
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
@media(prefers-reduced-motion:reduce){.water-ripple,.water-expand,.water-tint,.water-glow{animation:none}.petal{animation:none;opacity:0}}
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
'@

$h = $h.Replace($old, $new)

# Replace old fluid-bg div with water layers
$oldFluid = [regex]::Match($h, '<div class="fl-texture"[^>]*></div><div class="fl-green"[^>]*></div>[\s\S]*?(?=<div class="petals)').Value
if($oldFluid){
    $newFluid = '<div class="water-base" aria-hidden="true"></div><div class="water-ripple" aria-hidden="true"></div><div class="water-expand" aria-hidden="true"></div><div class="water-tint" aria-hidden="true"></div><div class="water-glow" aria-hidden="true"></div>'
    $h = $h.Replace($oldFluid, $newFluid)
}

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Vortex water theme applied: $($new.Length) chars"