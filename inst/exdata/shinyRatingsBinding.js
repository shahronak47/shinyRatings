$(function() {
    document.getElementById("star").onclick = function(){
          console.log(new Date().toLocaleTimeString());
          var val = document.getElementsByName('rating2');
          var rate_value = 0;
          for(var i = 0; i < val.length; i++){
            if (val[i].checked) {
              rate_value = parseFloat(val[i].value);
          }
        }
        console.log(rate_value);
        Shiny.setInputValue('out', rate_value);
      };
})

