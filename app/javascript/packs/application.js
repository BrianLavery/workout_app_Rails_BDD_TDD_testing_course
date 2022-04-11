require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("bootstrap/dist/js/bootstrap");

// From Margot file
import "bootstrap"
import Rails from '@rails/ujs'

// https://github.com/iblue/d3-rails
require("d3")

// https://matthewhoelter.com/2021/08/13/how-to-install-bootstrap-5-in-ruby-on-rails-6-with-webpack.html
require("@popperjs/core")

// https://stackoverflow.com/questions/57555708/rails-6-how-to-add-jquery-ui-through-webpacker
global.$ = require("jquery") // THIS IS MAKING jQuery AVAILABLE EVEN INSIDE Views FOLDER
require("jquery") // Don't really need to require this...
require("jquery-ui")

// Import the specific modules you may need (Modal, Alert, etc)
import { Tooltip, Popover } from "bootstrap"

// The stylesheet location we created earlier
require("../../assets/stylesheets/application.scss")

// If you're using Turbolinks. Otherwise simply use: jQuery(function () {
document.addEventListener("turbolinks:load", () => {
    // Both of these are from the Bootstrap 5 docs
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
        return new Tooltip(tooltipTriggerEl)
    })

    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function(popoverTriggerEl) {
        return new Popover(popoverTriggerEl)
    })
})
