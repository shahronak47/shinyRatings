/* Creation of custom input binding */
var shinyRatingsInputBinding = new Shiny.InputBinding();

$.extend(shinyRatingsInputBinding, {

  find: function(scope) {
    return $(scope).find(".shinyRatings");
  },

  getValue: function(el) {
    var rate_value = 0;
    $(el).find("input").each(function(inputitem){
        if ($(this).prop("checked")) {
          rate_value = parseFloat($(this).val());
      }
    });
    if (rate_value == 0) {
      rate_value = 5;
    }
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