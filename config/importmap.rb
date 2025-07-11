# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap" # @5.3.6
pin "popper", to: "popper.js", preload: true
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "@rails/ujs", to: "rails-ujs.js"
pin "add_nested_fields", to: "add_nested_fields.js"
pin "imask", to: "imask.min.js", preload: true
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
