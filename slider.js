document.addEventListener("DOMContentLoaded", function() {
    const slides = document.querySelector(".slides");
    const totalSlides = slides.children.length;
    let index = 0;
    document.querySelector(".next").onclick = () => {
        index = (index + 1) % totalSlides;
        slides.style.transform = `translateX(-${index * 100}%)`;
    };
    document.querySelector(".prev").onclick = () => {
        index = (index - 1 + totalSlides) % totalSlides;
        slides.style.transform = `translateX(-${index * 100}%)`;
    };
});
