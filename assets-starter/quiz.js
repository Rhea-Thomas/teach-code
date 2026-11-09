/* teach-code quiz component. Usage in a lesson:

   <div class="quiz" data-answer="2"
        data-why="Explanation shown after the learner answers.">
     <p>Question text</p>
     <button>Option A</button>
     <button>Option B</button>
     <button>Option C</button>
   </div>
   <script src="../../assets/quiz.js"></script>

   data-answer is the zero-based index of the correct button. Vary it across questions.
   Keep every option the same length so length is never a clue. */
document.querySelectorAll('.quiz').forEach(function (quiz) {
  var answer = parseInt(quiz.dataset.answer, 10);
  var buttons = Array.prototype.slice.call(quiz.querySelectorAll('button'));
  buttons.forEach(function (btn, i) {
    btn.addEventListener('click', function () {
      buttons.forEach(function (b) { b.disabled = true; });
      buttons[answer].classList.add('right');
      if (i !== answer) btn.classList.add('wrong');
      var why = document.createElement('div');
      why.className = 'why';
      why.textContent = (i === answer ? 'Correct. ' : 'Not quite. ') + (quiz.dataset.why || '');
      quiz.appendChild(why);
    });
  });
});
