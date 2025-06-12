Kaminari.configure do |config|
  config.page_method_name = :page
  config.default_per_page = 5
  config.params_on_first_page = false
end
