module ApplicationHelper
  def text_format(text)
    text.gsub(/(?:\n\r?|\r\n?)/, '<br>')
  end
end
