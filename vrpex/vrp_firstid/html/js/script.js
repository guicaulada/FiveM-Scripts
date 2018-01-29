$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('.cursor');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;

  function UpdateCursorPos() {
      $('.cursor').css('left', cursorX);
      $('.cursor').css('top', cursorY);
  }

  function triggerClick(x, y) {
      var element = $(document.elementFromPoint(x, y));
      element.focus().click();
  }
  
  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
    UpdateCursorPos();
  });
  
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    if (item.type == "click") {
        triggerClick(cursorX - 1, cursorY - 1);
    }
    else if(item.openForm == true) {
      openForm();
    }
    else if(item.closeForm == true) {
      closeForm();
    }
  });
  
  //Register clicks
  $(".zf-submitColor").click(function(){
	  if (zf_ValidateAndSubmit() == true) {
		  submitData();
	  }
  });
  
  $("#first").click(function(){
	  document.getElementById("first").focus();
  });
  
  $("#last").click(function(){
	  document.getElementById("last").focus();
  });
  
  $("#age").click(function(){
	  document.getElementById("age").focus();
  });
  
  //GUI Functions
  function closeAll() {
    $(".body").css("display", "none");
  }
  
  function openForm() {
    $(".full-screen").css("display", "flex");
    $(".cursor").css("display", "block");
  }
  
  function closeForm() {
    $(".full-screen").css("display", "none");
    $(".cursor").css("display", "none");
  }
  
  function submitData() {
    $.post('http://vrp_firstid/submit', JSON.stringify({
		first: document.getElementById("first").value,
		last: document.getElementById("last").value,
		age: document.getElementById("age").value
	}));
  }
});
