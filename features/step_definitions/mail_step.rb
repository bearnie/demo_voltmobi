include ActionView::Helpers::SanitizeHelper

То(/^на почту "(.*?)" должно быть отправлено сообщение "(.*?)"$/) do |email, subject|
  open_email(email)
  expect(current_email.subject).to match(subject)
  #p @email.body
  #expect(strip_tags(@email.body.to_s).gsub(/\r?\n/, ' ')).to match(message)
end

Если(/^я перехожу по ссылке из сообщения "(.*?)"$/) do |link|
  #Needs to change mthod of getting email_address
  p "Needs to change mthod of getting email_address"
  email_address = ActionMailer::Base.deliveries.last.to.last
  open_email(email_address)
  current_email.click_link link
end
