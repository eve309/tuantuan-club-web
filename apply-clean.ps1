$p = Join-Path $PSScriptRoot "index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# 1) Remove ALL external CSS/JS references (rollback to zero external deps)
$h = $h -replace '\s*<link rel="stylesheet" href="skin\.css[^"]*">', ''
$h = $h -replace '\s*<link rel="stylesheet" href="sakura-workbuddy\.css[^"]*">', ''
$h = $h -replace '\s*<script src="skin-images\.js[^"]*"></script>', ''
$h = $h -replace '\s*<script src="skin-visibility\.js[^"]*"></script>', ''

# 2) Replace the entire sakura-theme style block with optimized version
$oldBlock = [regex]::Match($h, '<style id="sakura-theme">[\s\S]*?</style>').Value
if(-not $oldBlock){ Write-Output "ERROR: block not found"; exit 1 }

$newBlock = @'
<style id="sakura-theme">
:root{--brand:#F0AFC3!important;--brand-deep:#E9A0B8!important;--brand-soft:rgba(246,200,212,.15)!important;--ink:#2D3A2E!important;--ink-2:#4A5A4C!important;--muted:#9AAC9E!important;--line:rgba(240,175,195,.25)!important;--card:rgba(255,255,255,.58)!important;--shadow:0 8px 32px rgba(140,195,138,.1)!important;--shadow-lg:0 18px 60px rgba(240,175,195,.15)!important}
body{color:#2D3A2E!important;font-family:"HarmonyOS Sans SC","PingFang SC","Microsoft YaHei",sans-serif!important;overflow-x:hidden!important}
/* L1: 色块层（无需 blur，GPU 合成，仅 transform 动画） */
body::before{content:"";position:fixed;inset:-50%;z-index:-2;pointer-events:none;
background:radial-gradient(ellipse 30% 26% at 28% 28%,rgba(201,230,163,.75) 0%,rgba(184,217,140,.45) 40%,transparent 70%),radial-gradient(ellipse 26% 22% at 72% 18%,rgba(246,200,212,.65) 0%,rgba(240,175,195,.35) 40%,transparent 65%),radial-gradient(ellipse 34% 28% at 50% 78%,rgba(169,214,232,.6) 0%,rgba(140,195,222,.3) 40%,transparent 68%),radial-gradient(ellipse 22% 18% at 82% 60%,rgba(240,175,195,.4) 0%,transparent 60%),radial-gradient(ellipse 26% 22% at 14% 68%,rgba(184,217,140,.45) 0%,transparent 62%),#FDF7EC;
animation:skBlobs 25s ease-in-out infinite alternate;will-change:transform}
@keyframes skBlobs{0%{transform:translate(0,0) rotate(0deg) scale(1)}50%{transform:translate(2%,-1.2%) rotate(.8deg) scale(1.03)}100%{transform:translate(-1.2%,.8%) rotate(-.4deg) scale(1.015)}}
/* L2: 波纹线层（无 blend mode，直接叠加，减少合成开销） */
body::after{content:"";position:fixed;inset:-30%;z-index:-1;pointer-events:none;
background:repeating-linear-gradient(168deg,transparent 0%,transparent 4%,rgba(255,255,255,.22) 5.5%,rgba(255,255,255,.35) 7%,rgba(255,255,255,.15) 8.5%,transparent 10%,transparent 15%,rgba(255,255,255,.1) 17%,transparent 20%),repeating-linear-gradient(15deg,transparent 0%,transparent 7%,rgba(255,255,255,.12) 8.5%,rgba(255,255,255,.22) 9.5%,transparent 11%,transparent 18%),linear-gradient(135deg,transparent 12%,rgba(255,255,255,.18) 18%,transparent 25%),linear-gradient(115deg,transparent 42%,rgba(255,255,255,.14) 50%,transparent 58%);
background-size:200% 300%;animation:skWaves 20s linear infinite;will-change:transform}
@keyframes skWaves{0%{background-position:0% 0%,0% 0%,0% 0%,0% 0%}50%{background-position:100% 50%,50% 100%,30% 20%,70% 80%}100%{background-position:200% 100%,100% 200%,60% 40%,140% 160%}}
/* L3: 厚度 */
body{box-shadow:inset 0 2px 0 rgba(255,255,255,.4),inset 0 -3px 0 rgba(169,214,232,.06)}
/* 顶栏（仅此处用 backdrop-filter） */
.topbar{background:rgba(255,255,255,.6)!important;backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);border-bottom:1px solid rgba(240,175,195,.2)!important}
.brand-txt{color:#E9A0B8!important;font-weight:800!important}
.tab.active{background:linear-gradient(135deg,#F0AFC3,#F6C8D4)!important;color:#5C3A47!important;border-radius:999px!important}
.tab:hover{background:rgba(246,200,212,.1)!important;border-radius:999px!important}
/* 卡片：不用 backdrop-filter（性能），用半透明+边框模拟玻璃 */
.club,.ev-card,.me-card,.cat,.hot-item,.fp-card,.tt-card,.searchbar{background:rgba(255,255,255,.55)!important;border:1px solid rgba(255,255,255,.65)!important;border-radius:18px!important;box-shadow:0 6px 28px rgba(180,160,190,.08),inset 0 1px 0 rgba(255,255,255,.5)!important;transition:box-shadow .2s}
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
/* 显隐 */
body.gate-active .topbar,body.gate-active .ai-ball,body.gate-active .tt-menu{display:none!important}
body.on-square .ai-ball{position:fixed;right:28px;top:50%;transform:translateY(-50%);bottom:auto;z-index:60}
body:not(.gate-active):not(.on-square) .ai-ball{display:none!important}
/* 花瓣 */
.petal{position:fixed;top:-5vh;width:11px;height:11px;background:linear-gradient(135deg,#F6C8D4,#F0AFC3);border-radius:80% 0 80% 0;opacity:0;pointer-events:none;z-index:1}
.petal:nth-child(1){left:5%;animation:pf 14s linear infinite}
.petal:nth-child(2){left:14%;width:8px;height:8px;animation:pf 18s linear infinite;animation-delay:3s}
.petal:nth-child(3){left:88%;width:9px;height:9px;animation:pf 15s linear infinite;animation-delay:5s}
.petal:nth-child(4){left:94%;width:7px;height:7px;animation:pf 20s linear infinite;animation-delay:8s}
.petal:nth-child(5){left:72%;width:10px;height:10px;animation:pf 16s linear infinite;animation-delay:2s}
.petal:nth-child(6){left:28%;width:6px;height:6px;animation:pf 22s linear infinite;animation-delay:6s}
@keyframes pf{0%{transform:translateY(0) rotate(0);opacity:0}5%{opacity:.6}25%{transform:translateY(25vh) translateX(25px) rotate(90deg)}50%{transform:translateY(50vh) translateX(-18px) rotate(180deg);opacity:.5}75%{transform:translateY(75vh) translateX(22px) rotate(270deg);opacity:.3}95%{opacity:.1}100%{transform:translateY(105vh) rotate(360deg);opacity:0}}
@media(prefers-reduced-motion:reduce){body::before,body::after{animation:none}.petal{animation:none;opacity:0}}
@media(max-width:768px){.petal{width:7px;height:7px}.petal:nth-child(5),.petal:nth-child(6){display:none}}
</style>
'@

$h = $h.Replace($oldBlock, $newBlock)

# 3) Replace old inline visibility script with lightweight version (no MutationObserver)
$oldScript = [regex]::Match($h, '<script>\s*\(function\(\)\{var b=document\.body[\s\S]*?</script>').Value
if($oldBlock){
    $newScript = @'
<script>
(function(){
  var b=document.body;
  function u(){
    var g=document.getElementById('ttGate');
    var gv=g&&g.style.display!=='none'&&g.offsetHeight>0;
    b.classList.toggle('gate-active',!!gv);
    var t=document.querySelector('.tab.active');
    var tn=t?t.dataset.tab:'';
    b.classList.toggle('on-square',!gv&&tn==='square');
  }
  /* Lightweight: no MutationObserver, just check on DOM events */
  document.addEventListener('DOMContentLoaded',u);
  window.addEventListener('load',u);
  /* Check after tab clicks */
  document.addEventListener('click',function(){setTimeout(u,100)});
  /* Check after form submissions */
  document.addEventListener('submit',function(){setTimeout(u,200)});
  u();
})();
</script>
'@
    $h = $h.Replace($oldScript, $newScript)
}

# 4) Add inline CLUB image mapping script (replaces skin-images.js)
$imgScript = @'
<script>
(function(){
  var M={"国防教育协会":"assets/club-defense.jpg","自然科学社":"assets/club-science.jpg","动画创作与研究协会":"assets/club-anime.jpg","TRY动漫社":"assets/club-anime.jpg","网络空间安全协会":"assets/club-cyber.jpg","未来媒体协会":"assets/club-esports.jpg","传棋社":"assets/club-chess.jpg","ACD推理社":"assets/club-books.jpg","青果文学社":"assets/club-books.jpg","衔青网文社":"assets/club-books.jpg","燕云史社":"assets/club-books.jpg","鲁迅研究社":"assets/club-books.jpg","模拟联合国社团":"assets/club-debate.jpg","国际组织与全球治理社团":"assets/club-debate.jpg","模拟政协":"assets/club-debate.jpg","非物质文化遗产与民俗青年研究社":"assets/club-culture.jpg","传统文化传播者":"assets/club-culture.jpg","非通用语言协会":"assets/club-books.jpg","中韩交流协会":"assets/club-books.jpg","多语融媒社":"assets/club-media.jpg","英语辩论社":"assets/club-debate.jpg","校辩论队":"assets/club-debate.jpg","电竞协会":"assets/club-esports.jpg","法律协会":"assets/club-law.jpg","AIGC创意社":"assets/club-cyber.jpg","SelfLove自我成长社":"assets/club-service.jpg","敏行服务社（筹）":"assets/club-service.jpg","润物后勤社（筹）":"assets/club-service.jpg","信息化实践与服务社":"assets/club-cyber.jpg","设计思维学生协会":"assets/club-gongfang2.jpg","设计思维学生协会（筹）":"assets/club-gongfang2.jpg","CUCC创作者":"assets/club-media.jpg","CUCC创作者（筹）":"assets/club-media.jpg","子衿汉服社":"assets/club-hanfu.jpg","泠音古风乐社":"assets/club-traditional.jpg","制音工厂":"assets/club-yinzhi.jpg","CUCA阿卡贝拉人声清唱社":"assets/club-acapella.jpg","吉他社":"assets/club-guitar.jpg","PASSWORD街舞社":"assets/club-dance.jpg","DE舞社":"assets/club-dance.jpg","清影舞社":"assets/club-dance.jpg","白杨剧团":"assets/club-musical.jpg","「笑生堂」相声社":"assets/club-musical.jpg","Musain音乐剧社":"assets/club-musical.jpg","摄影协会":"assets/club-film.jpg","浪潮电影社":"assets/club-film.jpg","微分编导社":"assets/club-film.jpg","Sirens Boom说唱社":"assets/club-rap.jpg","书画协会":"assets/club-culture.jpg","CURATing策展社":"assets/club-culture.jpg","ECHO配音社":"assets/club-dubbing.jpg","原创歌曲社团":"assets/club-zhiyin.jpg","跆拳道协会":"assets/club-martial.jpg","武术社":"assets/club-martial.jpg","X-Roller冰雪轮滑俱乐部":"assets/club-esports.jpg","桌游社":"assets/club-chess.jpg","乒乓球协会":"assets/cat-yt.jpg","Free D飞盘社":"assets/club-feipan2.jpg","弓箭社":"assets/club-gongjian.jpg","学生职业形象设计协会（筹）":"assets/club-gongfang2.jpg","爱猫社":"assets/club-cats.jpg","动物保护协会":"assets/club-cats2.jpg","三农学社":"assets/club-service.jpg","益影流声社团":"assets/club-media.jpg","爱雷锋社团":"assets/club-service.jpg"};
  var T={"音乐":"assets/club-zhiyin.jpg","舞":"assets/club-dance.jpg","摄影":"assets/club-film.jpg","电影":"assets/club-film.jpg","动画":"assets/club-anime.jpg","电竞":"assets/club-esports.jpg","棋":"assets/club-chess.jpg","文学":"assets/club-books.jpg","辩论":"assets/club-debate.jpg","法律":"assets/club-law.jpg","国防":"assets/club-defense.jpg","武术":"assets/club-martial.jpg","文化":"assets/club-culture.jpg","古风":"assets/club-traditional.jpg","科学":"assets/club-science.jpg","网络":"assets/club-cyber.jpg","服务":"assets/club-service.jpg","猫":"assets/club-cats.jpg","设计":"assets/club-gongfang2.jpg","弓箭":"assets/club-gongjian.jpg","飞盘":"assets/club-feipan2.jpg","汉服":"assets/club-hanfu.jpg","配音":"assets/club-dubbing.jpg","书画":"assets/club-culture.jpg","创":"assets/club-cyber.jpg"};
  var C={"SX":"assets/club-cyber.jpg","ZL":"assets/club-service.jpg","XL":"assets/club-cyber.jpg","YT":"assets/club-zhiyin.jpg","ZY":"assets/club-service.jpg"};
  function img(name,cat,code){
    if(code&&M[code])return M[code];
    if(name&&M[name])return M[name];
    if(name){for(var k in T){if(name.indexOf(k)>=0)return T[k]}}
    if(cat&&C[cat])return C[cat];
    return "assets/cat-sx.jpg";
  }
  function paint(el,src){
    if(!el||el.dataset.bgDone)return;
    el.dataset.bgDone="1";
    var s=el.querySelectorAll("svg");
    for(var i=0;i<s.length;i++)s[i].style.display="none";
    el.style.backgroundImage="linear-gradient(180deg,rgba(8,14,38,.08),rgba(8,14,38,.3)),url('"+src+"')";
    el.style.backgroundSize="cover";el.style.backgroundPosition="center";
  }
  function go(){
    var els=document.querySelectorAll(".club");
    for(var i=0;i<els.length;i++){
      var c=els[i],cv=c.querySelector(".club-cover");
      if(!cv||cv.dataset.bgDone)continue;
      var ne=c.querySelector(".club-name");
      var fe=c.querySelector(".club-foot .fans");
      paint(cv,img(ne?ne.textContent.trim():"",fe?fe.textContent.trim():"",c.dataset.club||""));
    }
    var hero=document.querySelector(".club-hero");
    if(hero&&!hero.dataset.bgDone){
      var hl=document.querySelector(".club-headline");
      var nm=hl?hl.textContent.trim():"";
      paint(hero,img(nm,"",hero.dataset.club||""));
      var av=document.querySelector(".club-avatar");
      if(av)paint(av,img(nm,"",hero.dataset.club||""));
    }
    var evs=document.querySelectorAll(".ev-card");
    for(var j=0;j<evs.length;j++){
      var ec=evs[j],th=ec.querySelector(".ev-thumb");
      if(!th||th.dataset.bgDone)continue;
      var te=ec.querySelector(".ev-type");
      var tx=te?te.textContent:"";
      var ei="assets/ev-life.jpg";
      for(var k in {"讲座":"assets/ev-lecture.jpg","演出":"assets/ev-show.jpg","展映":"assets/ev-film.jpg","展览":"assets/ev-exhibit.jpg","市集":"assets/ev-market.jpg","运动":"assets/ev-sport.jpg","劳动":"assets/ev-labor.jpg","竞赛":"assets/ev-contest.jpg","生活":"assets/ev-life.jpg","招新":"assets/ev-market.jpg","换届":"assets/ev-contest.jpg"}){if(tx.indexOf(k)>=0){ei=arguments.callee?eval("EVT_"+k):null;break}}
      paint(th,ei);
    }
  }
  /* No MutationObserver! Just run at delays */
  setTimeout(go,100);
  setTimeout(go,600);
  setTimeout(go,2000);
})();
</script>
'@

# Insert image script before petals
$petalsPos = $h.IndexOf('<div class="petals"')
if($petalsPos -gt 0){
    $h = $h.Insert($petalsPos, $imgScript + "`n")
}else{
    $h = $h.Replace("</body>", $imgScript + "</body>")
}

Set-Content -LiteralPath $p -Value $h -Encoding UTF8
Write-Output "Optimized: external deps removed, single inline script, no MutationObserver"