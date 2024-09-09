let currentIndex1 = 0;
let currentIndex2 = 0;
const slidesToShow = 5; // 한 번에 보여줄 슬라이드 개수

function nextSlide(sliderId) {
    const slides = document.querySelectorAll(`#slider${sliderId} .slide`);
    const maxIndex = slides.length - slidesToShow; // 빈 공간이 보이지 않도록 마지막 슬라이드까지 제어

    if (sliderId === 1) {
        currentIndex1 = (currentIndex1 + 1) > maxIndex ? 0 : currentIndex1 + 1;
        showSlide(sliderId, currentIndex1);
    } else if (sliderId === 2) {
        currentIndex2 = (currentIndex2 + 1) > maxIndex ? 0 : currentIndex2 + 1;
        showSlide(sliderId, currentIndex2);
    }
}

function prevSlide(sliderId) {
    if (sliderId === 1) {
        currentIndex1 = (currentIndex1 - 1) < 0 ? 0 : currentIndex1 - 1;
        showSlide(sliderId, currentIndex1);
    } else if (sliderId === 2) {
        currentIndex2 = (currentIndex2 - 1) < 0 ? 0 : currentIndex2 - 1;
        showSlide(sliderId, currentIndex2);
    }
}

function showSlide(sliderId, index) {
    const slidesContainer = document.querySelector(`#slider${sliderId}`);
    const slideWidth = 100 / slidesToShow; // 슬라이드 하나의 너비를 계산하여 이동

    slidesContainer.style.transform = `translateX(-${index * slideWidth}%)`;
    slidesContainer.style.transition = "transform 0.5s ease-in-out";
}
// 자동 슬라이드 (5초마다)
//setInterval(() => nextSlide(1), 5000);
//setInterval(() => nextSlide(2), 5000);