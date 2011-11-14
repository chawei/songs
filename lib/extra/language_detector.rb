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
  
  def self.translate_to_zh_TW(str)
    res = self.get("https://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=#{str}&langpair=zh-CN%7Czh-TW")
    res["responseStatus"].to_i == 200 ? res["responseData"]["translatedText"] : nil
  end
end
