module Cucumber
  module Rails
    module Capybara
      # This module defines methods for selecting dates and times
      module SelectDatesAndTimes
        # Select a Rails date. Options has must include :from => +label+
        # day can be ignored using :ignore_day => true option
        def select_date(date, options)
          date = Date.parse(date)
          base_dom_id = get_base_dom_id_from_label_tag(options[:from])

          find(:xpath, ".//select[@id='#{base_dom_id}_1i']").select(date.year.to_s)
          find(:xpath, ".//select[@id='#{base_dom_id}_2i']").select(I18n.l(date, :format => '%d %B').split.last)
          find(:xpath, ".//select[@id='#{base_dom_id}_3i']").select(date.day.to_s) unless options[:ignore_day]
        end
      end
    end
  end
end
