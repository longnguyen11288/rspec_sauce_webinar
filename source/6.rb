require 'rubygems'
require "selenium/client"
require "selenium/rspec/spec_helper"

describe "Sauce Labs Homepage Test" do
    attr_reader :selenium_driver
    alias :page :selenium_driver

    before(:all) do
        @selenium_driver = Selenium::Client::Driver.new \
            :host => "localhost",
            :port => 4444,
            :browser => "*firefox",
            :url => "http://www.saucelabs.com",
            :timeout_in_second => 60
    end

    before(:each) do
    @selenium_driver.start_new_browser_session
    end

    # The system capture need to happen BEFORE closing the Selenium session
    append_after(:each) do
        @selenium_driver.close_current_browser_session
    end

    it "should have a sane title" do
        page.open "/"
        page.title.should eql("There is no way this will work - Sauce Labs")
    end

    it "should contain the word 'selenium'" do
        page.open "/"
        page.get_html_source.should match /selenium/
    end

    it "should contain the word 'Sauce Labs'" do
        page.open "/"
        page.get_html_source.should match /Sauce Labs/
    end
end
