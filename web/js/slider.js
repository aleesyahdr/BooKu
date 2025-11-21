/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
 const slides = document.querySelectorAll('.slider-img');
  let current = 0;

  const showSlide = (index) => {
      slides.forEach((slide, i) => {
          slide.classList.remove('active');
          if(i === index) slide.classList.add('active');
      });
  };

  document.querySelector('.slide-btn.left').addEventListener('click', () => {
      current = (current === 0) ? slides.length - 1 : current - 1;
      showSlide(current);
  });

  document.querySelector('.slide-btn.right').addEventListener('click', () => {
      current = (current === slides.length - 1) ? 0 : current + 1;
      showSlide(current);
  });
