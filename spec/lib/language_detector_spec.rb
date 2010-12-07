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
end