# encoding: utf-8
# language: ru

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
   
    when /Главная/
      '/'     

    when /Авторизация/
      '/sign_in'     
    when /Регистрация/
      '/sign_up'     
    when /Восстановление пароля/
      '/recovery_passwd'     
    when /Вход/
      '/sign_in'     
    when /Выход/
      '/sign_out'     

    when /Новый пользователь/
      '/users/new'
    when /Профиль/, /Страница пользователя/
      '/profile'
    when /Пользователи/
      '/users'
    when /пользователя "(.+)"/
      user_path(User.find_by_email $1)
    when /Редактировать профиль "(.+)"/
      edit_user_path(User.find_by_email $1)

    when /Новая задача/
      '/tasks/new'
    when /Список задач/
      '/tasks'
    when /Выбор исполнителя/
      '/tasks/executors'

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
