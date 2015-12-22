class Task < ActiveRecord::Base
  belongs_to :user
  has_many :events_logs, as: :logable 
  validates :name, :description, presence: true

  # State of task can be new, started, finished
  include AASM
  aasm column: :state, whiny_transitions: false  do
    state :new, initial: true
    state :started
    state :finished

    event :start do
      transitions from: :new, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end


  end

  def possible_states
    self.aasm.states(:permitted => true).map(&:name)
  end
  def possible_events
    self.aasm.events.map(&:name)
  end

  def perform_event state_name, user
    return false if state_name.blank?
    if Task.events_names.include? state_name.try(:to_sym)
      unless self.send("may_#{state_name}?")
        self.errors.add(:event, "can't to be apply")
        false
      else
        self.send state_name
        self.touch_events_log state_name, user
        true
      end
    else
      self.errors.add(:event, "don't exists")
      false
    end
  end

  def touch_events_log event_name, user
    self.events_logs.create(event: event_name, user: user)
  end

  def Task.events_names
    Task.aasm.events.map(&:name)
  end


end
