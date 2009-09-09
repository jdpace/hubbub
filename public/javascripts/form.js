function substituteButtonToForms() {
  forms = $('form.button-to');
  
  for(i=0; i<forms.length; i++) {
    button = $(forms[i]).find("input[type=submit]");
    $(forms[i]).attr("id", "button_to_"+button.attr('id'));
    link = $("<a href='#" +button.attr('id')+ "' class='" +button.attr('class')+ "' id='" +button.attr('id')+ "'>" +button.val()+ "</a>");
    link.click(function(){
      $(this).next('form.button-to').find('input[type=submit]').click();
      return(false);
    });
    $(forms[i]).before(link);
    $(forms[i]).hide();
  }
}

function activateShipToBillingBoxes() {
  box = $('input[type=checkbox].ship_to_billing');
  if(box.length) {
    if(box.attr('checked') == true) {
      $('#ship_to_address').hide();
      $('#ship_to_address input').val('');
      $('#ship_to_address option').attr('selected','');
    }else {
      $('#ship_to_address').show();
    }
    
    $(box).click(function(){
      if(box.attr('checked') == true) {
        $('#ship_to_address').hide();
      }else {
        $('#ship_to_address').show();
      }
    });
  }
}

function activateDatepicker() {
  if($.datepicker) {
    $('input.calendar').datepicker({dateFormat: 'yy-mm-dd',maxDate: '+0d'});
  }
}

jQuery(document).ready(function(){
  $("input[type=text], input[type=password]").addClass('text');
  $("input[type=checkbox]").addClass('checkbox');
  // $("form div[style] input[type=hidden]").parent().addClass('hidden');
  $("div.fieldWithErrors input, div.fieldWithErrors textarea").focus(function(){
    if($(this).parent().hasClass("fieldWithErrors"))
    {
      $($(this).parents()[1]).children(".fieldWithErrors").addClass('errors-seen');
    }
  });
  
  //Prefilled input forms
  $("input.prefilled").focus(function(){
    if(!$(this).attr('defaultvalue')){ $(this).attr('defaultvalue', $(this).val())}
    if($(this).val() == $(this).attr('defaultvalue')){
      $(this).val('');
    }
  })
  
  // Datepicker
  activateDatepicker();
  
  activateShipToBillingBoxes();
  
  // Give button-to forms a link that submits the form so we can style it better
  substituteButtonToForms();

	// Add markitup Textile boxes
	if($.markItUp){
		$("textarea.textile").markItUp(mySettings);
	}
});