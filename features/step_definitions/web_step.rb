# encoding: utf-8
# language: ru
# Steps for cucumber testing, based on HTML elements and events. On RUSSIAN language

require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

# Commonly used webrat steps
# http://github.com/brynary/webrat


Допустим(/^я на странице (.+)$/) do |page_name|
  visit path_to(page_name)
	expect(current_path).to eq(path_to(page_name))
end

Допустим(/^я на Главной странице сайта$/) do
  step %{я на странице Главная}
end

Если /^(?:|я )перехожу на страницу (.+)$/ do |page_name|
  visit path_to(page_name)
end

Если /^(?:|я )перехожу на страницу "([^\"]*)" within "([^\"]*)"$/ do |link, parent|
  click_link_within(parent, link)
end


То /^(?:|я )должен оказаться на странице (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path, :query).compact.join('?')
	expect(current_path).to eq(path_to(page_name))
end

То /^(?:|я )должен оказаться в разделе (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path).compact.join('?')
	expect(current_path).to eq(path_to(page_name))
end

То(/^я вышел с сайта$/) do
  page.driver.submit :delete, path_to("Выход"), {}
  step %{я должен оказаться на странице Главная}
  step %{не должно быть ссылки на страницу Выход}
end


Если /^(?:|я )кликаю кнопку "([^\"]*)"$/ do |button|
  click_button(button)
end

Если /^(?:|я )кликаю ссылку "([^\"]*)"$/ do |link|
  click_link(link, :match => :first)
end

Если(/^кликаю по последней ссылке "(.*?)"$/) do |link|
  page.find(:xpath, "(//a[text()='#{link}'])[last()]").click
end

То(/^я кликаю ссылку на страницу (.+)$/) do |page_name|
    #find(:xpath, "(//a[href='#{path_to page_name}'])[last()]").click
    find(:xpath, "(//a[contains(@href, '#{path_to page_name}')])[last()]").click
end



Если /^(?:|я )ввожу в поле "([^\"]*)" значение "([^\"]*)"$/ do |field, value|
  find(:xpath, "(//input[@name='#{field}']|//textarea[@name='#{field}'])[last()]").set(value)
end

Если /^(?:|я )ввожу "([^\"]*)" в поле "([^\"]*)"$/ do |value, label|
  #fill_in(field, :with => value)
  #find(:xpath, "//label[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZАБВГДЕЁЖЗИКЛМНОПРСТУФХЦЧШЩЬЫЪЭЮЯ', 'abcdefghijklmnopqrstuvwxyzабвгдеёжзиклмнопрстуфхцчшщьыъэюя'),'#{label.downcase}')]/following-sibling::input | //label[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{label.downcase}')]/following-sibling::div/input").set value
  find(:xpath, "//label[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{label.downcase}')]/following-sibling::input | //label[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{label.downcase}')]/following-sibling::div/input | //label[contains(translate(., 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz'),'#{label.downcase}')]/following-sibling::textarea").set value
end

Если /^(?:|я )ввожу следующие значения:$/ do |fields|
  fields.rows_hash.each do |row|
		step %{я ввожу "#{row[1]}" в поле "#{row[0]}"}
  end
end

Если /^(?:|я )выбираю значение "([^\"]*)" из списка в поле "([^\"]*)"$/ do |value, field|
  select(value, :from => field)
end

Если /^(?:|я )выбираю дату и время "([^\"]*)"$/ do |time|
  select_datetime(time)
end

Если /^(?:|я )выбираю время "([^\"]*)"$/ do |time|
  select_time(time)
end

Если /^(?:|я )выбираю время "([^\"]*)" в поле "([^\"]*)"$/ do |time, time_label|
  select_time(time, :from => time_label)
end

Если /^(?:|я )выбираю дату"([^\"]*)"$/ do |date|
  select_date(date)
end

Если /^(?:|я )выбираю дату "([^\"]*)" в поле "([^\"]*)"$/ do |date, date_label|
  select_date(date, :from => date_label)
end

Если /^(?:|я )устанавливаю крестик в поле "([^\"]*)"$/ do |name|
  find(:xpath, "(//input[@name='#{name}'][@type='checkbox'])[1]").set true
end

Если /^(?:|я )ставлю крестик в поле "([^\"]*)"$/ do |field|
  check(field)
end

Если /^(?:|я )убираю крестик в поле "([^\"]*)"$/ do |field|
  uncheck(field)
end
Если(/^я ставлю крестик в поле "(.*?)" со значением "(.*?)"$/) do |name, val|
   find(:xpath, "//label[contains(.,'#{val}')]/input[@name='#{name}'][@type='checkbox']").set true
end

Если(/^я ставлю крестик в поле "(.*?)" в строке с "(.*?)"$/) do |name, val|
   find(:xpath, "//tr/*[contains(.,'#{val}')]/ancestor::tr/descendant::input[@name='#{name}'][@type='checkbox']").set true
   #find(:xpath, "//tr[contains(.,'#{val}')]/input[@name='#{name}'][@type='checkbox']").set true
end

Если /^(?:|я )убираю крестик в поле "([^\"]*)" cо значением "([^\"]*)"$/ do |field, value|
  uncheck(field)
end

Если /^(?:|я )выбираю поле "([^\"]*)"$/ do |field|
  choose(field)
end

# Adds support for validates_attachment_content_type. Without the mime-type getting
# passed to attach_file() you will get a "Photo file is not one of the allowed file types."
# error message
Если /^(?:|я )выбираю файл "([^\"]*)" в поле "([^\"]*)"$/ do |path, field|
  attach_file(field, Rails.root + path)
end

Если /^я оказался на странице (.+)$/ do |page_name|
  current_path = URI.parse(current_url).select(:path).compact.join('?')
  expect(current_path).to eq(path_to(page_name))
end

Если /^я вижу ссылку на страницу (.+)$/ do |page_name|
  expect(page).to have_selector("a[href='#{path_to page_name}']")
end


То /^(?:|я )должна быть ссылка "([^\"]*)"$/ do |text|
 #puts current_url
 step %{я должен увидеть текст "#{text}"}
end

То /^(?:|я )должен увидеть форму с полями\:$/ do |table|
		table.hashes.each do |row|
			page.should have_text row[:title]
      if row[:type] == "textarea"
        expect(page).to have_selector("form textarea[name='#{row[:name]}']")
      else
        expect(page).to have_selector("form input[name='#{row[:name]}'][type='#{row[:type]}']")
      end
		end
end

И /^кнопкой "([^\"]*)"$/ do |name|
		expect(page).to have_selector("form input[type='submit'][value='#{name}']")
end

То /^(?:|я )должен увидеть кнопку "([^\"]*)"$/ do |name|
  expect(page.body).to have_selector("form input[value='#{name}'][type='submit']")
end

То /^(?:|я )должен увидеть ссылку на страницу (.+)$/ do |page_name|
  expect(page.body).to have_selector("a[href='#{path_to page_name}']")
end

То /^(?:|на странице )не должно быть ссылки на страницу (.+)$/ do |page_name|
  expect(page.body).not_to have_selector("a[href='#{path_to page_name}']")
end




То /^(?:|я )должен увидеть текст "([^\"]*)"$/ do |text|
  #expect(page.text).to have_text(text)
  expect(page.text.gsub(/\s+/, '')).to have_content(text.gsub(/\s+/, ''))
end

То /^(?:|я )должен увидеть сообщение "([^\"]*)"$/ do |text|
 #puts current_url
 step %{я должен увидеть текст "#{text}"}
end

То /^увидеть сообщение "(.*?)"$/ do |text|
 step %{я должен увидеть текст "#{text}"}
end

То /^(?:|я )должен увидеть ошибку "([^\"]*)"$/ do |text|
 step %{я должен увидеть текст "#{text}"}
end

То(/^(?:|на странице )не должно быть текста "(.*?)"$/) do |text|
		expect(page).to have_no_content(text)
end

То(/^не должно быть видно поля "(.*?)"$/) do |field_name|

	page.should have_no_selector("input[type='text'][name='#{field_name}']")
end


То /^поле "([^\"]*)" должно содержать "([^\"]*)"$/ do |field, value|
    expect(field_labeled(field).value).to match(value)
end

То /^в поле "([^\"]*)" должен быть крестик$/ do |label|
  expect(field_labeled(label)).to be_checked
end

То /^в поле "([^\"]*)" не должно быть крестика$/ do |label|
  expect(field_labeled(label)).not_to be_checked
end

То /^сохранить страницу$/ do
  screenshot_and_save_page
  #screenshot_and_open_image
end

То /^показать страницу$/ do
	puts page.html
  #save_and_open_page
end

Если /^покажи текст$/ do
	puts page.body
end

То(/^я должен получить файл "(.*?)"$/) do |arg1|
  page.response_headers['Content-Type'].should == "application/zip"
end

То(/^я должен увидеть хоть что\-нибудь$/) do
  expect(page.status_code).to eq(200)
  expect(page.body).to be_present
end

Если(/^подождал (\d+) сек.$/) do |pause|
  sleep(pause.to_i)

end
