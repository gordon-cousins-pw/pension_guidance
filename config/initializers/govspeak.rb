require 'govspeak'

Govspeak::Document.extension('calculator', /^{::calculator\sid="(?<id>.*?)"\s\/}/) do |id|
  calculator = ApplicationController.new.render_to_string(partial: "calculators/#{id.tr('-', '_')}/form")
  %{\n\n<div class="t-calculator calculator calculator--in-article calculator--#{id}">#{calculator}</div>\n}
end
