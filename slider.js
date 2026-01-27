document.addEventListener('DOMContentLoaded', () => {
  const slides = document.querySelectorAll('#slider .slide');
  let index = 0;
  setInterval(() => {
    slides.forEach((s, i) => s.style.display = (i === index ? 'block' : 'none'));
    index = (index + 1) % slides.length;
  }, 3000);
});
