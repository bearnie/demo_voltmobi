class Task < ActiveRecord::Base

  belongs_to :author, class_name: "User"
  belongs_to :executor, class_name: "User", foreign_key: "user_id"

  has_many :events_logs, as: :logable 
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments

  validates :name, :description, presence: true

  paginates_per 10 

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

  def Task.states_names
    Task.aasm.states.map(&:name)
  end

  def date_for_event event
    events_logs.where(event: event).last.try(:created_at)
  end

  def self.with_options params, user
    search(params[:search]).state_filter(params[:state]).direction_filter(params[:direction], user).page(params[:page])
  end

  def self.direction_filter direction, user
    return where(1) unless direction || user
    return joins(:author).where('users.id = ?', user.id) if direction == "for_me"
    return joins(:executor).where('users.id = ?', user.id) if direction == "I"
    self
  end

  def self.search search
    return where(1) unless search
    joins("INNER JOIN users ON (users.id = tasks.author_id OR users.id = tasks.user_id)").where("tasks.name LIKE ? or users.email LIKE ?", "%#{search}%", "%#{search}%")
  end

  def self.state_filter state
    return where(1) unless state
    where("tasks.state LIKE ?", "#{state}")
  end


end
