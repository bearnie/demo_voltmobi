$ ->
  <% if params[:for_task] %>
    $('#task_<%= params[:for_task] %> .select_executors_wrapper').replaceWith("<%= j render 'select_executors' %>")
  <% end %>
