/* Creation of custom input binding */
var shinyRatingsInputBinding = new Shiny.InputBinding();

$.extend(shinyRatingsInputBinding, {

  find: function(scope) {
    return $(scope).find(".shinyRatings");
  },

  initialize: function(el){
    /* Get default value */
    var data = JSON.parse(el.getAttribute('data'));
    var n = data.n;
    /* Manually set the check property to TRUE for default number of stars */
    var count = 0
    $(el).find("input").each(function(inputitem){
        count = count + 1
        if(count <= n) {
        $(this).prop("checked", true);  
        }
    });
  },
  
  getValue: function(el) {
    var rate_value = 0;
    $(el).find("input").each(function(inputitem){
        if ($(this).prop("checked")) {
          rate_value = parseFloat($(this).val());
      }
    });
    return(rate_value)
  },

  setValue: function(el, value) {
    el.value = value;
  },
  
  subscribe: function(el, callback) {
    $(el).on('change.shinyRatings', function(event) {
         callback(false);
        // When called with false, it will NOT use the rate policy,
    	  // so changes will be sent immediately
       }); 
  },

  unsubscribe: function(el) {
    $(el).off(".shinyRatings");
  }

});

/* Registration of custom input binding */
Shiny.inputBindings.register(shinyRatingsInputBinding);