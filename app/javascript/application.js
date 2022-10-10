// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const mobileMenu = document.getElementById('movil-menu'); 

const menuClose = () => mobileMenu.classList.remove('menu-show');
const menuOpen = () => mobileMenu.classList.add('menu-show');

document.getElementById('btn-open').addEventListener('click', menuOpen);
document.getElementById('btn-close').addEventListener('click', menuClose);
