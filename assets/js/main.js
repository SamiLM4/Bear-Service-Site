// Pequenas interações: menu mobile
const navToggle = document.getElementById('nav-toggle');
const siteNav = document.getElementById('site-nav');
if(navToggle && siteNav){
  navToggle.addEventListener('click', ()=>{
    siteNav.classList.toggle('mobile-open');
  })
}

// Expandible: futuramente usar para carregamento condicional do Calendly
// (o widget já é carregado diretamente na página booking.html)