$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

$sakuraCss = @"

<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--brand-soft:rgba(246,200,212,.15)!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important;--shadow:0 8px 32px rgba(140,195,138,.1)!important;--shadow-lg:0 18px 60px rgba(240,175,195,.15)!important}
body{background:radial-gradient(ellipse 70% 55% at 15% 10%,rgba(201,230,163,.4) 0%,transparent 60%),radial-gradient(ellipse 55% 45% at 88% 12%,rgba(246,200,212,.35) 0%,transparent 55%),radial-gradient(ellipse 80% 45% at 50% 98%,rgba(169,214,232,.3) 0%,transparent 60%),linear-gradient(180deg,#FDF7EC,#F5F0E8)!important;background-attachment:fixed!important;color:#2D3A2E!important}
.topbar{background:rgba(255,255,255,.65)!important;backdrop-filter:blur(20px);border-bottom:1px solid rgba(240,175,195,.2)!important}
.brand-txt{color:#E9A0B8!important;font-weight:800!important}
.tab.active{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border-radius:999px!important}
.tab:hover{background:rgba(246,200,212,.1)!important;border-radius:999px!important}
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.55)!important;backdrop-filter:blur(16px);-webkit-backdrop-filter:blur(16px);border:1px solid rgba(255,255,255,.65)!important;border-radius:18px!important;box-shadow:0 8px 32px rgba(140,195,138,.08)!important}
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
body.gate-active .topbar,body.gate-active .ai-ball,body.gate-active .tt-menu{display:none!important}
body.on-square .ai-ball{position:fixed;right:28px;top:50%;transform:translateY(-50%);bottom:auto;z-index:60}
body:not(.gate-active):not(.on-square) .ai-ball{display:none!important}
.petal{position:fixed;top:-5vh;width:11px;height:11px;background:linear-gradient(135deg,#F6C8D4,#F0AFC3);border-radius:80% 0 80% 0;opacity:0;pointer-events:none;z-index:1}
.petal:nth-child(1){left:5%;animation:pf 14s linear infinite}
.petal:nth-child(2){left:14%;width:8px;height:8px;animation:pf 18s linear infinite;animation-delay:3s}
.petal:nth-child(3){left:88%;width:9px;height:9px;animation:pf 15s linear infinite;animation-delay:5s}
.petal:nth-child(4){left:94%;width:7px;height:7px;animation:pf 20s linear infinite;animation-delay:8s}
.petal:nth-child(5){left:72%;width:10px;height:10px;animation:pf 16s linear infinite;animation-delay:2s}
.petal:nth-child(6){left:28%;width:6px;height:6px;animation:pf 22s linear infinite;animation-delay:6s}
@keyframes pf{0%{transform:translateY(0) rotate(0);opacity:0}5%{opacity:.6}25%{transform:translateY(25vh) translateX(25px) rotate(90deg)}50%{transform:translateY(50vh) translateX(-18px) rotate(180deg);opacity:.5}75%{transform:translateY(75vh) translateX(22px) rotate(270deg);opacity:.3}95%{opacity:.1}100%{transform:translateY(105vh) rotate(360deg);opacity:0}}
@media(prefers-reduced-motion:reduce){.petal{animation:none;opacity:0}}
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
"@

$petalsHtml = @"

<div class="petals" aria-hidden="true"><span class="petal"></span><span class="petal"></span><span class="petal"></span><span class="petal"></span><span class="petal"></span><span class="petal"></span></div>
<script>
(function(){var b=document.body;function u(){var g=document.getElementById('ttGate');var gv=g&&(g.style.display!=='none')&&g.offsetHeight>0;b.classList.toggle('gate-active',!!gv);var t=document.querySelector('.tab.active');var tn=t?t.dataset.tab:'';b.classList.toggle('on-square',!gv&&tn==='square')}var t=null;new MutationObserver(function(){if(t)clearTimeout(t);t=setTimeout(u,200)}).observe(document.body,{childList:true,subtree:true,attributes:true});if(document.readyState==='loading')document.addEventListener('DOMContentLoaded',u);else u()})();
</script>
"@

$h = $h.Replace("</head>", $sakuraCss + "</head>")
$h = $h.Replace("</body>", $petalsHtml + "</body>")

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Done: sakura theme injected inline"