window.addEventListener('DOMContentLoaded', function(){
  let slideIndex = 0;
  showSlides();
  function showSlides() {
    let slides = document.querySelectorAll('.slider img');
    if (slides.length == 0) return;
    slides.forEach((slide) => { slide.style.display = 'none'; });
    slideIndex++;
    if (slideIndex > slides.length) { slideIndex = 1; }
    slides[slideIndex-1].style.display = 'block';
    setTimeout(showSlides, 3000);
  }
});
