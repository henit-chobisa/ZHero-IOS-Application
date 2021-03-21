const togglebtn = document.querySelector(".container");
var toggleClass = togglebtn.classList;

var flag = 0;

 function change(){
     if(flag==0){
         document.getElementById('link').style.display = 'none';
         document.getElementById('text').style.display = 'block';
         flag = 1;
     }
     else{
        document.getElementById('link').style.display = 'block';
        document.getElementById('text').style.display = 'none';
        flag = 0;
     }
 }