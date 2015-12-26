Допустим(/^существует пользователь "(.*?)"$/) do |email|
  FactoryGirl.create(:user, email: email)
  expect(User.find_by_email email).to be_persisted
end

Допустим(/^существует пользователь с:$/) do |table|
  attributes = {}
	table.rows_hash.each do |row|
    if ["true", "false"].include? row[1]
      attributes[row[0].to_sym] = row[1] == "true" ? true : false
    else
      attributes[row[0].to_sym] = row[1]
    end
  end
	@user = FactoryGirl.create( :user, attributes )
	expect(@user).to be_persisted
end

То(/^должен быть создан пользователь с email "(.*?)"$/) do |email|
  user =  User.find_by_email email
  expect(user).to be_persisted
end

То(/^пользователь "(.*?)" должен быть залогинен$/) do |email|
  #user =  User.find_by_email email
  expect(page.body).to match('Выход')
  #pending #need to improove this step
end

То(/^пользователь "(.*?)" не должен быть залогинен$/) do |arg1|
  expect(page.body).to match('Вход')
end

То(/^пользователь "(.*?)" должен иметь следующие данные$/) do |email, table|
  @user = User.find_by_email email
  user_i18n_attr = {} 
  @user.attributes.each do |attr|
    user_i18n_attr[User.human_attribute_name attr[0]] = attr[1].to_s
  end
	table.rows_hash.each do |row|
    expect(user_i18n_attr[row[0]]).to eq(row[1])
  end
end

То(/^пользователя "(.*?)" не должно существовать$/) do |email|
  expect(User.find_by_email email).to be_nil
end

То(/^не должно быть ссылки для удаления пользователя "(.*?)"$/) do |email|
  page_path = path_to "пользователя \"#{email}\"" 
  expect(page.body).not_to have_xpath("//a[contains(@href, '#{page_path}')][@data-method='delete']")
end

То(/^пользователь "(.*?)" должен иметь аватарку "(.*?)"$/) do |email, avatar|
  @user = User.find_by_email email
  expect(@user.avatar_file_name).to eq(avatar)
end
