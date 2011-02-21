# encoding: utf-8
require File.dirname(__FILE__) + '/../spec_helper'

describe LanguageDetector do
  context "get_lang" do
    it "should return correct lang with given query string" do
      LanguageDetector.should_receive(:get_lang).with('我愛台灣').and_return('zh-TW')
      lang = LanguageDetector.get_lang('我愛台灣')
      lang.should == "zh-TW"
    end
  end
  
  context "asian_language?" do
    it "should return true if the given query string is zh-TW, zh-CN or ja" do
      LanguageDetector.should_receive(:get_lang).with('我愛台灣').and_return('zh-TW')
      LanguageDetector.should_receive(:get_lang).with('Hello').and_return('en-US')
       
      LanguageDetector.asian_language?('我愛台灣').should == true
      LanguageDetector.asian_language?('Hello').should == false
    end
  end
end