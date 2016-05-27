require 'govspeak'

Govspeak::Document.extension('calculator', %r(^{::calculator\sid="(?<id>.*?)"\s/})) do |id|
  classes = "t-calculator calculator calculator--in-article calculator--#{id} js-calculator hide-from-print"
  partial = "calculators/#{id.tr('-', '_')}/form"

  calculator = ApplicationController.new.render_to_string(partial: partial)

  %(\n\n<div class="#{classes}">#{calculator}</div>\n)
end

Govspeak::Document.extension('delayed-popup', %r(^{::delayed-popup(\sclass="(?<class>[^"]+)")?}(?<content>.+){/delayed-popup})m) do |classname, content|
  title, body = *content.strip.split("\n", 2)
  classes = "#{classname} js-delayed-popup"

  %(
<div id="myModal" class="modal fade #{classes}" role="dialog">
<div class="modal-dialog">
<!-- Modal content-->
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal">&times;</button>

#{Kramdown::Document.new(title).to_html}

</div>
<div class="modal-body">

#{Kramdown::Document.new(body).to_html}

</div>
</div>
</div>
</div>
  ).html_safe


end
