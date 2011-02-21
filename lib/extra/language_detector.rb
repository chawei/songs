require 'httparty'

class LanguageDetector
  include HTTParty
  format :json
  
  def self.get_lang(text)
    res = self.get("https://ajax.googleapis.com/ajax/services/language/detect?v=1.0&q=#{URI.escape(text)}")
    return res["responseData"]["language"]
  end
  
  def self.asian_language?(text)
    return ["zh-TW", "zh-CN", 'ja'].include? get_lang(text)
  end
end
