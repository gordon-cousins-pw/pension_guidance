class Guide
  attr_reader :id, :source, :title, :content, :description

  def initialize(id, source = '', description = '')
    @id = id
    @source = source
    @description = description
  end

  def slug
    id.tr('_', '-')
  end

  def title
    @title ||= govspeak.headers.find { |header| header.level == 1 }.try(:text)
  end

  def content
    @content ||= govspeak.to_sanitized_html.html_safe
  end

  private

  def govspeak
    @govspeak ||= Govspeak::Document.new(@source)
  end
end