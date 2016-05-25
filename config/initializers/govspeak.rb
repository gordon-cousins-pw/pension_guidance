require 'govspeak'

Govspeak::Document.extension('calculator', %r(^{::calculator\sid="(?<id>.*?)"\s/})) do |id|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator hide-from-print"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial)

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end

Govspeak::Document.extension('delayed-popup', %r(^{::delayed-popup(\sdelay="(?<delay>[^"]*)")?}(?<content>.+){/delayed-popup})m) do |delay, content|
  classes = "delayed-popup delayed-popup--bottom js-delayed-popup"
  %(\n\n<div class="#{classes}" data-delay="#{delay}">#{content}</div>\n)
end
