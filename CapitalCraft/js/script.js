// add/edit question: options must be different
function checkOptionsDifferent(sender, args) {
  let boxes = document.getElementsByClassName("option-box");
  let seen = [];
  args.IsValid = true;

  for (let i = 0; i < boxes.length; i++) {
    let option = boxes[i].value.trim().toLowerCase();
    if (option == "") {
      continue;
    }
    if (seen.includes(option)) {
      args.IsValid = false;
    }
    seen.push(option);
  }
}

// check the reading is a pdf and not too big
function checkPdf(input, maxMb) {
  if (input.files.length == 0) {
    return;
  }
  let file = input.files[0];

  if (!file.name.toLowerCase().endsWith(".pdf")) {
    alert("Reading must be a PDF file (.pdf).");
    input.value = "";
  } else if (file.size > maxMb * 1024 * 1024) {
    alert("The PDF is too big. The largest allowed is " + maxMb + " MB.");
    input.value = "";
  }
}

// quiz: every question needs an answer
function checkAllAnswered() {
  let questions = document.getElementsByClassName("quiz-question");
  let missing = 0;

  for (let i = 0; i < questions.length; i++) {
    if (questions[i].querySelector("input[type=radio]:checked") == null) {
      questions[i].classList.add("unanswered");
      missing = missing + 1;
    } else {
      questions[i].classList.remove("unanswered");
    }
  }

  if (missing > 0) {
    alert("Please answer every question. " + missing + " question(s) still need an answer.");
    return false;
  }
  return true;
}

// card deck on home page
let deck = document.getElementById("deck");

if (deck) {
  let cards = Array.from(deck.getElementsByClassName("deck-card"));
  let counter = document.getElementById("deck-count");
  let current = 0;
  let busy = false;
  let timer = null;

  deck.classList.add("ready");

  function showDeck() {
    for (let i = 0; i < cards.length; i++) {
      let card = cards[i];

      card.style.zIndex = cards.length - i;
      card.style.transform = "translateY(" + (i * 12) + "px) scale(" + (1 - i * 0.05) + ")";
      card.style.opacity = i < 3 ? 1 : 0;

      card.inert = (i != 0);
    }
    counter.innerText = (current + 1) + " / " + cards.length;
  }

  function nextCard() {
    if (busy || cards.length < 2) return;
    busy = true;

    let top = cards.shift();
    cards.push(top);
    current = (current + 1) % cards.length;

    top.classList.add("leaving");
    showDeck();
    top.style.zIndex = cards.length + 1;

    setTimeout(function () {
      top.classList.remove("leaving");
      top.style.zIndex = 1;
      busy = false;
    }, 500);
  }

  function previousCard() {
    if (busy || cards.length < 2) return;
    busy = true;

    let bottom = cards.pop();
    cards.unshift(bottom);
    current = (current - 1 + cards.length) % cards.length;

    bottom.style.transition = "none";
    bottom.classList.add("leaving");
    bottom.offsetWidth;
    bottom.style.transition = "";
    showDeck();
    bottom.classList.remove("leaving");

    setTimeout(function () { busy = false; }, 500);
  }

  // auto play
  function startAutoPlay() {
    if (timer != null) return;
    timer = setInterval(nextCard, 3500);
  }
  function stopAutoPlay() {
    clearInterval(timer);
    timer = null;
  }

  let deckArea = deck.parentElement;
  deckArea.addEventListener("mouseenter", stopAutoPlay);
  deckArea.addEventListener("mouseleave", startAutoPlay);
  deckArea.addEventListener("focusin", stopAutoPlay);
  deckArea.addEventListener("focusout", startAutoPlay);

  // arrow buttons and keys
  document.getElementById("deck-next").addEventListener("click", nextCard);
  document.getElementById("deck-prev").addEventListener("click", previousCard);

  deck.addEventListener("keydown", function (e) {
    if (e.key == "ArrowRight") { nextCard(); e.preventDefault(); }
    if (e.key == "ArrowLeft") { previousCard(); e.preventDefault(); }
  });

  showDeck();
  startAutoPlay();
}

// form checks (login / sign up)
let checkedBoxes = document.querySelectorAll("#login-form [data-required]");

function fieldProblem(box) {
  let value = box.value.trim();

  if (value == "") {
    return box.dataset.required;
  }
  if (box.type == "email" && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) {
    return "Please enter a valid email address, e.g. name@example.com.";
  }
  if (box.dataset.minlength && box.value.length < Number(box.dataset.minlength)) {
    return "Password must be at least " + box.dataset.minlength + " characters.";
  }
  if (box.dataset.match && box.value != document.getElementById(box.dataset.match).value) {
    return "Passwords do not match.";
  }
  return "";
}

// show or hide the red message under a box
function showProblem(box, message) {
  let error = document.getElementById(box.id + "-error");

  if (!error) {
    error = document.createElement("p");
    error.id = box.id + "-error";
    error.className = "field-error";
    box.after(error);
  }

  error.innerText = message;
  error.hidden = (message == "");

  let hint = error.nextElementSibling;
  if (message != "" && hint && hint.classList.contains("pw-hint")) {
    hint.hidden = true;
  }
  box.classList.toggle("invalid", message != "");
}

if (checkedBoxes.length > 0) {
  let form = checkedBoxes[0].form;
  form.noValidate = true;

  for (let i = 0; i < checkedBoxes.length; i++) {
    let box = checkedBoxes[i];

    box.addEventListener("blur", function () {
      showProblem(box, fieldProblem(box));
    });

    box.addEventListener("input", function () {
      showProblem(box, "");
    });
  }

  // check all boxes on submit
  form.addEventListener("submit", function (e) {
    let firstProblem = null;

    for (let i = 0; i < checkedBoxes.length; i++) {
      let message = fieldProblem(checkedBoxes[i]);
      showProblem(checkedBoxes[i], message);
      if (message != "" && firstProblem == null) {
        firstProblem = checkedBoxes[i];
      }
    }

    if (firstProblem != null) {
      e.preventDefault();
      firstProblem.focus();
    }
  });
}

// password hint
let pwBox = document.getElementById("txtPw");
let pwHint = document.getElementById("pw-hint");

if (pwBox && pwHint) {
  let typingInBox = false;

  function updatePasswordHint() {
    let length = pwBox.value.length;
    let error = document.getElementById("txtPw-error");

    if (error && !error.hidden) {
      pwHint.hidden = true;
      return;
    }

    if (length == 0 && !typingInBox) {
      pwHint.hidden = true;
      return;
    }

    pwHint.hidden = false;
    if (length >= 8) {
      pwHint.innerText = "✓ At least 8 characters";
      pwHint.classList.add("ok");
    } else {
      pwHint.innerText = "Minimum 8 characters (" + length + "/8)";
      pwHint.classList.remove("ok");
    }
  }

  pwBox.addEventListener("focus", function () { typingInBox = true; updatePasswordHint(); });
  pwBox.addEventListener("blur", function () { typingInBox = false; updatePasswordHint(); });
  pwBox.addEventListener("input", updatePasswordHint);
}
