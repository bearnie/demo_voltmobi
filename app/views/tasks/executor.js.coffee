<% if params[:selected_for_task] %>
  $('#task_<%= params[:selected_for_task] %> .select_executors_wrapper').replaceWith("<%= j render 'user_label_short', user: @user %>")
  $('#task_<%= params[:selected_for_task] %> form input[name="task[user_id]"]').attr('value', '<%= @user.id %>')
<% end %>
