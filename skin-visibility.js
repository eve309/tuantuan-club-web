/* 团团智能体 · 结构显隐控制
   登录/选标签时隐藏顶栏和AI球，进入广场后显示
   Agent 固定在社团推荐右侧，仅广场页可见 */
(function(){
  var body=document.body;
  function update(){
    var gate=document.getElementById('ttGate');
    var gateVisible=false;
    if(gate){
      var s=getComputedStyle(gate);
      gateVisible=s.display!=='none'&&gate.offsetHeight>0;
    }
    var tab=document.querySelector('.tab.active');
    var tabName=tab?tab.dataset.tab||'':'';
    var isSquare=tabName==='square'||tabName==='me'||tabName==='events';
    body.classList.toggle('gate-active',gateVisible);
    body.classList.toggle('on-square',!gateVisible&&isSquare);
    /* 退出登录时显示顶栏隐藏AI球 */
    if(gateVisible){
      body.classList.remove('on-square');
    }
  }
  new MutationObserver(update).observe(document.body,{attributes:true,childList:true,subtree:true,attributeFilter:['style','class']});
  if(document.readyState==='loading'){document.addEventListener('DOMContentLoaded',update)}else{update()}
})();