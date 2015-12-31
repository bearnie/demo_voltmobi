module TasksHelper
  def links_to_possible_events_for task, hsh = {}
    return ''  unless can? :change_states, task
    hsh[:button_class] ||= "btn-xs"
    links = ""
    task.possible_events.each do |event|
      links += link_to t("task.events.#{event.to_s.downcase}"), task_path(task, event: event), :method => :put, :class => "btn btn-default #{hsh[:button_class]}"
    end
    links.html_safe
  end
end
