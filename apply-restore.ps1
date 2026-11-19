$p = "C:\Users\LENOVO\.magicore\accounts\b4bf866f-4ca0-40fc-9e0d-9f57c2612e25\workspaces\agents\da789480-8214-40ec-9fe0-25533902df6f\社团一站通-美化版\index.html"
$h = Get-Content -LiteralPath $p -Raw -Encoding UTF8

# Check if club image script already exists
if($h.Contains("club-yinzhi")){
    Write-Output "Image mapping already present"
} else {
    # Add image mapping script before </body>
    $imgScript = @"

<script>
(function(){
var M={"国防教育协会":"assets/club-defense.jpg","自然科学社":"assets/club-science.jpg","动画创作与研究协会":"assets/club-anime.jpg","TRY动漫社":"assets/club-anime.jpg","网络空间安全协会":"assets/club-cyber.jpg","未来媒体协会":"assets/club-esports.jpg","传棋社":"assets/club-chess.jpg","ACD推理社":"assets/club-books.jpg","青果文学社":"assets/club-books.jpg","衔青网文社":"assets/club-books.jpg","燕云史社":"assets/club-books.jpg","鲁迅研究社":"assets/club-books.jpg","模拟联合国社团":"assets/club-debate.jpg","国际组织与全球治理社团":"assets/club-debate.jpg","模拟政协":"assets/club-debate.jpg","非物质文化遗产与民俗青年研究社":"assets/club-culture.jpg","传统文化传播者":"assets/club-culture.jpg","非通用语言协会":"assets/club-books.jpg","中韩交流协会":"assets/club-books.jpg","多语融媒社":"assets/club-media.jpg","英语辩论社":"assets/club-debate.jpg","校辩论队":"assets/club-debate.jpg","电竞协会":"assets/club-esports.jpg","法律协会":"assets/club-law.jpg","AIGC创意社":"assets/club-cyber.jpg","SelfLove自我成长社":"assets/club-service.jpg","敏行服务社（筹）":"assets/club-service.jpg","润物后勤社（筹）":"assets/club-service.jpg","信息化实践与服务社":"assets/club-cyber.jpg","设计思维学生协会":"assets/club-gongfang2.jpg","设计思维学生协会（筹）":"assets/club-gongfang2.jpg","CUCC创作者":"assets/club-media.jpg","CUCC创作者（筹）":"assets/club-media.jpg","子衿汉服社":"assets/club-hanfu.jpg","泠音古风乐社":"assets/club-traditional.jpg","制音工厂":"assets/club-yinzhi.jpg","CUCA阿卡贝拉人声清唱社":"assets/club-acapella.jpg","吉他社":"assets/club-guitar.jpg","PASSWORD街舞社":"assets/club-dance.jpg","DE舞社":"assets/club-dance.jpg","清影舞社":"assets/club-dance.jpg","白杨剧团":"assets/club-musical.jpg","「笑生堂」相声社":"assets/club-musical.jpg","Musain音乐剧社":"assets/club-musical.jpg","摄影协会":"assets/club-film.jpg","浪潮电影社":"assets/club-film.jpg","微分编导社":"assets/club-film.jpg","Sirens Boom说唱社":"assets/club-rap.jpg","书画协会":"assets/club-culture.jpg","CURATing策展社":"assets/club-culture.jpg","ECHO配音社":"assets/club-dubbing.jpg","原创歌曲社团":"assets/club-zhiyin.jpg","跆拳道协会":"assets/club-martial.jpg","武术社":"assets/club-martial.jpg","X-Roller冰雪轮滑俱乐部":"assets/club-esports.jpg","桌游社":"assets/club-chess.jpg","乒乓球协会":"assets/cat-yt.jpg","Free D飞盘社":"assets/club-feipan2.jpg","弓箭社":"assets/club-gongjian.jpg","学生职业形象设计协会（筹）":"assets/club-gongfang2.jpg","爱猫社":"assets/club-cats.jpg","动物保护协会":"assets/club-cats2.jpg","三农学社":"assets/club-service.jpg","益影流声社团":"assets/club-media.jpg","爱雷锋社团":"assets/club-service.jpg"};
var T={"音乐":"assets/club-zhiyin.jpg","舞":"assets/club-dance.jpg","摄影":"assets/club-film.jpg","电影":"assets/club-film.jpg","动画":"assets/club-anime.jpg","电竞":"assets/club-esports.jpg","棋":"assets/club-chess.jpg","文学":"assets/club-books.jpg","辩论":"assets/club-debate.jpg","法律":"assets/club-law.jpg","国防":"assets/club-defense.jpg","武术":"assets/club-martial.jpg","文化":"assets/club-culture.jpg","古风":"assets/club-traditional.jpg","科学":"assets/club-science.jpg","网络":"assets/club-cyber.jpg","服务":"assets/club-service.jpg","猫":"assets/club-cats.jpg","设计":"assets/club-gongfang2.jpg","弓箭":"assets/club-gongjian.jpg","飞盘":"assets/club-feipan2.jpg","汉服":"assets/club-hanfu.jpg","配音":"assets/club-dubbing.jpg","书画":"assets/club-culture.jpg"};
var C={"SX":"assets/club-cyber.jpg","ZL":"assets/club-service.jpg","XL":"assets/club-cyber.jpg","YT":"assets/club-zhiyin.jpg","ZY":"assets/club-service.jpg"};
function img(n,c,code){
  if(code&&M[code])return M[code];
  if(n&&M[n])return M[n];
  if(n){for(var k in T){if(n.indexOf(k)>=0)return T[k]}}
  if(c&&C[c])return C[c];
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
    var EM={"讲座":"assets/ev-lecture.jpg","演出":"assets/ev-show.jpg","展映":"assets/ev-film.jpg","展览":"assets/ev-exhibit.jpg","市集":"assets/ev-market.jpg","运动":"assets/ev-sport.jpg","劳动":"assets/ev-labor.jpg","竞赛":"assets/ev-contest.jpg","生活":"assets/ev-life.jpg","招新":"assets/ev-market.jpg","换届":"assets/ev-contest.jpg"};
    for(var k in EM){if(tx.indexOf(k)>=0){ei=EM[k];break}}
    paint(th,ei);
  }
}
setTimeout(go,100);
setTimeout(go,800);
setTimeout(go,2500);
})();
</script>
"@
    $h = $h.Replace("</body>", $imgScript + "</body>")
    Set-Content -LiteralPath $p -Value $h -Encoding UTF8
    Write-Output "Image mapping script added inline"
}
