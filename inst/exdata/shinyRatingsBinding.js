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
  
  receiveMessage: function(el, data) {
    console.log("\nupdate values\n");
    console.log(el);
    console.log(data);
    if (data.hasOwnProperty('value'))
      this.setValue(el, data.value);

    if (data.hasOwnProperty('label'))
      $(el).parent().find('label[for="' + $escape(el.id) + '"]').text(data.label);

    $(el).trigger('change');
  }

});

/* Registration of custom input binding */
Shiny.inputBindings.register(shinyRatingsInputBinding);