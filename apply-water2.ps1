$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

$old = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $old){ Write-Output "ERROR: not found"; exit 1 }

$new = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--brand-soft:rgba(246,200,212,.15)!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important;--shadow:0 8px 32px rgba(140,195,138,.1)!important;--shadow-lg:0 18px 60px rgba(240,175,195,.15)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}
/* == 第一层：大色块液态流体（可见彩色水流） == */
body::before{content:"";position:fixed;inset:-60%;z-index:-2;pointer-events:none;
background:
 radial-gradient(ellipse 32% 28% at 28% 28%,rgba(201,230,163,.8) 0%,rgba(184,217,140,.5) 40%,transparent 72%),
 radial-gradient(ellipse 28% 24% at 72% 18%,rgba(246,200,212,.7) 0%,rgba(240,175,195,.4) 40%,transparent 68%),
 radial-gradient(ellipse 38% 32% at 50% 80%,rgba(169,214,232,.65) 0%,rgba(140,195,222,.35) 40%,transparent 70%),
 radial-gradient(ellipse 24% 20% at 84% 62%,rgba(240,175,195,.45) 0%,transparent 62%),
 radial-gradient(ellipse 30% 24% at 12% 70%,rgba(184,217,140,.5) 0%,transparent 65%),
 radial-gradient(ellipse 22% 20% at 55% 42%,rgba(216,204,240,.35) 0%,transparent 62%),
 #FDF7EC;
animation:sk-blobs 28s ease-in-out infinite alternate;will-change:transform}
@keyframes sk-blobs{0%{transform:translate(0,0) rotate(0deg) scale(1)}25%{transform:translate(2.5%,-1.5%) rotate(1.2deg) scale(1.04)}50%{transform:translate(-1.5%,1.2%) rotate(-.8deg) scale(1.025)}75%{transform:translate(1.2%,1.8%) rotate(.5deg) scale(1.03)}100%{transform:translate(-1.2%,-1.2%) rotate(-.4deg) scale(1.018)}}
/* == 第二层：水波纹线 + 高光棱线 + 漩涡（肉眼清晰可见） == */
body::after{content:"";position:fixed;inset:-40%;z-index:-1;pointer-events:none;
background:
 repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.18) 5.5%,rgba(255,255,255,.3) 7%,rgba(255,255,255,.12) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.08) 17%,transparent 20%),
 repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.1) 8.5%,rgba(255,255,255,.18) 9.5%,transparent 11%,transparent 18%),
 linear-gradient(135deg,transparent 12%,rgba(255,255,255,.2) 18%,transparent 25%),
 linear-gradient(115deg,transparent 42%,rgba(255,255,255,.12) 50%,transparent 58%),
 radial-gradient(ellipse 20% 14% at 25% 35%,rgba(255,255,255,.35) 0%,transparent 70%),
 radial-gradient(ellipse 16% 12% at 65% 50%,rgba(255,255,255,.25) 0%,transparent 70%),
 conic-gradient(from 180deg at 18% 70%,transparent 0%,rgba(184,217,140,.15) 12%,transparent 25%,rgba(184,217,140,.1) 40%,transparent 55%,rgba(184,217,140,.12) 70%,transparent 85%),
 conic-gradient(from 0deg at 80% 28%,transparent 0%,rgba(246,200,212,.12) 15%,transparent 30%,rgba(169,214,232,.08) 50%,transparent 70%);
background-size:200% 300%;animation:sk-waves 15s linear infinite;will-change:transform,opacity}
@keyframes sk-waves{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%,0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%,20% 60%,80% 40%,50% 50%,30% 70%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%,40% 120%,160% 80%,100% 100%,60% 140%}}
/* == 第三层：液面厚度高光棱 == */
body{box-shadow:inset 0 3px 0 rgba(255,255,255,.5),inset 0 -5px 0 rgba(169,214,232,.08),inset 4px 0 0 rgba(201,230,163,.05),inset -4px 0 0 rgba(246,200,212,.05)}
/* == 玻璃卡片 == */
.topbar{background:rgba(255,255,255,.6)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(240,175,195,.2)!important;box-shadow:0 4px 24px rgba(200,180,200,.1),inset 0 1px 0 rgba(255,255,255,.5)!important}
.brand-txt{color:#E9A0B8!important;font-weight:800!important}
.tab.active{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border-radius:999px!important}
.tab:hover{background:rgba(246,200,212,.1)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar,.modal,.ev-panel,.me-hero,.gov-hero{background:rgba(255,255,255,.5)!important;backdrop-filter:blur(18px) saturate(1.3);-webkit-backdrop-filter:blur(18px) saturate(1.3);border:1px solid rgba(255,255,255,.65)!important;border-radius:18px!important;box-shadow:0 6px 28px rgba(180,160,190,.08),0 2px 8px rgba(240,175,195,.05),inset 0 1px 0 rgba(255,255,255,.5)!important;transition:box-shadow .3s,background .3s}
.club:hover,.ev-card:hover{box-shadow:0 14px 40px rgba(200,160,190,.14),0 4px 12px rgba(240,175,195,.08),inset 0 1px 0 rgba(255,255,255,.6)!important}
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
/* == 结构显隐 == */
body.gate-active .topbar,body.gate-active .ai-ball,body.gate-active .tt-menu{display:none!important}
body.on-square .ai-ball{position:fixed;right:28px;top:50%;transform:translateY(-50%);bottom:auto;z-index:60}
body:not(.gate-active):not(.on-square) .ai-ball{display:none!important}
/* == 樱花瓣 == */
.petal{position:fixed;top:-5vh;width:11px;height:11px;background:linear-gradient(135deg,#F6C8D4,#F0AFC3);border-radius:80% 0 80% 0;opacity:0;pointer-events:none;z-index:1}
.petal:nth-child(1){left:5%;animation:pf 14s linear infinite}
.petal:nth-child(2){left:14%;width:8px;height:8px;animation:pf 18s linear infinite;animation-delay:3s}
.petal:nth-child(3){left:88%;width:9px;height:9px;animation:pf 15s linear infinite;animation-delay:5s}
.petal:nth-child(4){left:94%;width:7px;height:7px;animation:pf 20s linear infinite;animation-delay:8s}
.petal:nth-child(5){left:72%;width:10px;height:10px;animation:pf 16s linear infinite;animation-delay:2s}
.petal:nth-child(6){left:28%;width:6px;height:6px;animation:pf 22s linear infinite;animation-delay:6s}
@keyframes pf{0%{transform:translateY(0) rotate(0);opacity:0}5%{opacity:.6}25%{transform:translateY(25vh) translateX(25px) rotate(90deg)}50%{transform:translateY(50vh) translateX(-18px) rotate(180deg);opacity:.5}75%{transform:translateY(75vh) translateX(22px) rotate(270deg);opacity:.3}95%{opacity:.1}100%{transform:translateY(105vh) rotate(360deg);opacity:0}}
@media(prefers-reduced-motion:reduce){body::before,body::after{animation:none}.petal{animation:none;opacity:0}}
@media(max-width:768px){body::before{background-size:150% auto}.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
'@

$h = $h.Replace($old, $new)
Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Enhanced water waves applied: $($new.Length) chars"