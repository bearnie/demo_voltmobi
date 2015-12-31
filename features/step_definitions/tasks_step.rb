Допустим(/^существует задача для "(.*?)" с:$/) do |email, table|
  @user = User.find_by_email(email) || FactoryGirl.create(:user)
  attributes = {}
	table.rows_hash.each do |row|
    if ["true", "false"].include? row[1]
      attributes[row[0].to_sym] = row[1] == "true" ? true : false
    else
      attributes[row[0].to_sym] = row[1]
    end
  end
  attributes.merge! user_id: @user.id
  attributes.merge! author_id: @user.id
	@task = FactoryGirl.create( :task, attributes )
	expect(@task).to be_persisted
end

Допустим(/^существует задача от "(.*?)" для "(.*?)" с:$/) do |author, executor, table|
  @author = User.find_by_email(author) || FactoryGirl.create(:user, email: author)
  @executor = User.find_by_email(executor) || FactoryGirl.create(:user, email: executor)
  attributes = {}
	table.rows_hash.each do |row|
    if ["true", "false"].include? row[1]
      attributes[row[0].to_sym] = row[1] == "true" ? true : false
    else
      attributes[row[0].to_sym] = row[1]
    end
  end
  attributes.merge! user_id: @executor.id
  attributes.merge! author_id: @author.id
	@task = FactoryGirl.create( :task, attributes )
	expect(@task).to be_persisted
end

То(/^к задаче должен быть прикреплен файл "(.*?)"$/) do |filename|
  @task  = Task.last
  expect(@task.attachments.last.file_name).to eq(filename)
end

То(/^у задачи "(.*?)" должны быть аттрибуты:$/) do |name, table|
  @task = Task.find_by_name name
  i18n_attr = {} 
  @task.attributes.each do |attr|
    i18n_attr[Task.human_attribute_name attr[0]] = attr[1].to_s
  end
	table.rows_hash.each do |row|
    expect(i18n_attr[row[0]]).to eq(row[1])
  end
end

То(/^должна существовать задача "(.*?)" с:$/) do |name, table|
  step %{у задачи "#{name}" должны быть аттрибуты:}, table
end

То(/^исполнителем задачи "(.*?)" должен быть "(.*?)"$/) do |task_name, email|
  @executor = User.find_by_email email
  @task = Task.find_by_name task_name
  expect(@task.executor.email).to eq(@executor.email)
end
