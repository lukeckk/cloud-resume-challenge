function toggleMenu() {
  const menu = document.querySelector(".menu-links");
  const icon = document.querySelector(".hamburger-icon");
  menu.classList.toggle("open");
  icon.classList.toggle("open");
}

const counter = document.querySelector('.counter-number');
async function updateCounter() {
  let response = await fetch("https://2etq6dd5hazdylhnt7z36zznvu0zwdvm.lambda-url.us-east-1.on.aws/");
  let data = await response.json();
  counter.innerHTML = `Views: ${data.views}`
}

updateCounter();