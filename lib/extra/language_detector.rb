require 'httparty'

class LanguageDetector
  include HTTParty
  format :json
  
  API_KEY = "AIzaSyCYzgmA5cRyXe_6bPeOdZOQgho-srGMEBw"
  
  def self.get_lang(text)
    res = self.get("https://www.googleapis.com/language/translate/v2/detect?key=#{API_KEY}&q=#{URI.escape(text)}")
    return res #["responseData"]["language"]
  end
  
  def self.asian_language?(text)
    return ["zh-TW", "zh-CN", 'ja'].include? get_lang(text)
  end
  
  def self.translate_to_zh_TW(str)
    res = self.get("https://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=#{str}&langpair=zh-CN%7Czh-TW")
    res["responseStatus"].to_i == 200 ? res["responseData"]["translatedText"] : nil
  end
end
