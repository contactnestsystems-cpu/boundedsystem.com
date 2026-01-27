const slides=[...document.querySelectorAll(".slide")];
const dotsBox=document.querySelector(".dots");
let i=0;
slides.forEach((_,idx)=>{const d=document.createElement("div");d.className="dot"+(idx===0?" active":"");d.onclick=()=>go(idx,true);dotsBox.appendChild(d);});
const dots=[...document.querySelectorAll(".dot")];
function go(n,manual){slides[i].classList.remove("active");dots[i].classList.remove("active");i=n;slides[i].classList.add("active");dots[i].classList.add("active");if(manual) reset();}
let t=null;function reset(){if(t) clearInterval(t);t=setInterval(()=>go((i+1)%slides.length,false),3500);}reset();
