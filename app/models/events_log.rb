class EventsLog < ActiveRecord::Base
  belongs_to :user
  belongs_to :logable
end
