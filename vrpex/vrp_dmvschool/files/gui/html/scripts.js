$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('#cursor');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;

  //question variables
  var questionNumber = 1;
  var userAnswer = [];
  var goodAnswer = [];
  var questionUsed = [];
  var nbGoodAnswer = 0;
  var randomQuestion = 0;
  var nbQuestionToAnswer = 10; // don't forget to change the progress bar max value in html
  var nbAnswerNeeded = 9; // out of nbQuestionToAnswer
  var nbPossibleQuestions = 10; //number of questions in database questions.js
  /*
  var nbQuestionToAnswer = 10; // don't forget to change the progress bar max value in html
  var nbAnswerNeeded = 8; // out of nbQuestionToAnswer
  var nbPossibleQuestions = 15; //number of questions in database questions.js
*/

  function getRandomQuestion() {
    var continuer = true;
    var random;
    while (continuer){
      continuer=false; // do not continue loop
      random = Math.floor(Math.random() * nbPossibleQuestions) ; // number of possible questions
      if(questionNumber==1){
        return random;
      }
      for(i=0; i<questionNumber-1; i++){
        if (random == questionUsed[i]) {
          continuer=true; // continue loop only if random is already used
        }
      }
    }
    return random;
  }

  function UpdateCursorPos() {
      $('#cursor').css('left', cursorX);
      $('#cursor').css('top', cursorY);
  }

  function triggerClick(x, y) {
      var element = $(document.elementFromPoint(x, y));
      element.focus().click();
      return true;
  }

  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
  }
  function openQuestionnaire() {
    $(".questionnaire-container").css("display", "block");
    randomQuestion = getRandomQuestion();
    $("#questionNumero").html("Question : " + questionNumber);
    $("#question").html(tableauQuestion[randomQuestion].question);
    $(".answerA").html(tableauQuestion[randomQuestion].propositionA);
    $(".answerB").html(tableauQuestion[randomQuestion].propositionB);
    $(".answerC").html(tableauQuestion[randomQuestion].propositionC);
    $(".answerD").html(tableauQuestion[randomQuestion].propositionD);
    $('input[name=question]').attr('checked',false);
    $(".questionnaire-container .progression").val(questionNumber-1);
  }
  function openResultGood() {
    $(".resultGood").css("display", "block");
  }
  function openResultBad() {
    $(".resultBad").css("display", "block");
  }
  function openContainer() {
    $(".question-container").css("display", "block");
    $("#cursor").css("display", "block");
  }
  function closeContainer() {
    $(".question-container").css("display", "none");
    $("#cursor").css("display", "none");
  }
  
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Open & Close main gang window
    if(item.openQuestion == true) {
      openContainer();
      openMain();
    }
    if(item.openQuestion == false) {
      closeContainer();
      closeMain();
    }
    // Open sub-windows / partials
    if(item.openSection == "question") {
      closeAll();
      openQuestionnaire();
    }
    if (item.type == "click") {
        triggerClick(cursorX - 1, cursorY - 1);
    }
  });

  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
    UpdateCursorPos();
  });

  // Handle Button Presses
  $(".btnQuestion").click(function(){
      $.post('http://vrp_dmvschool/question', JSON.stringify({}));
  });
  $(".btnClose").click(function(){
      $.post('http://vrp_dmvschool/close', JSON.stringify({nbGoodAnswer}));
  });
  $(".btnKick").click(function(){
      questionNumber = 1;
      userAnswer = [];
      goodAnswer = [];
      questionUsed = [];
      randomQuestion = 0;
	  skip = 0;
      $.post('http://vrp_dmvschool/kick', JSON.stringify({nbGoodAnswer}));
	  nbGoodAnswer = 0;
  });
 
  var skip = 0;
 // Handle Form Submits
  $("#question-form").submit(function(e) {
    e.preventDefault();
	if(skip == 0){
      questionUsed.push(randomQuestion);
      userAnswer.push($('input[name="question"]:checked').val());
      goodAnswer.push(tableauQuestion[randomQuestion].reponse);
      if(questionNumber!=nbQuestionToAnswer){
        //question 1 to 9 : pushing answer in array
        closeAll();
        questionNumber++;
	    skip = 2;
        openQuestionnaire();
      }
      else {
        // question 10 : comparing arrays and sending number of good answers
        for (i = 0; i < nbQuestionToAnswer; i++) {
          if (userAnswer[i] == goodAnswer[i]) {
            nbGoodAnswer++;
          }
        }
        closeAll();
        if(nbGoodAnswer >= nbAnswerNeeded) {
          openResultGood();
        }
        else{
          openResultBad();
        }
      }
	}
	skip--;
  });
});
