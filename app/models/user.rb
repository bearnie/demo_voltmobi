require 'rubygems'
require 'role_model'

class User < ActiveRecord::Base

  has_many :outcoming_tasks, class_name: "Task", foreign_key: "author_id"
  has_many :incoming_tasks, class_name: "Task", foreign_key: "user_id"

  before_create :accept_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include RoleModel
  roles_attribute :roles_mask
  roles :admin, :user

  paginates_per 5 

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/missing_images/:style/avatar.jpg"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # method to select appeal to users
  def appeal
    return name if name.present?
    email
  end

  def accept_roles
    self.roles = [:user] if self.roles.blank?
  end

  def User.executors_tasks_counts
    result = {}
    by_users_by_events = User.joins(:incoming_tasks).group(:user_id, :state).count
    by_users_by_events.map do |u|
      result[u.first.first.to_s] ||= {}
      result[u.first.first.to_s].merge!(u.first.last.to_s => u.last)
    end
    result
  end

  def self.executors
    where 1
  end

  def User.all_users_tasks_counts
    # Prepare all users with empty tasks
    all_users_hash = Hash[User.executors.map{|u| [u.id.to_s, {}]}]
    all_users_hash.merge User.executors_tasks_counts
  end

  def self.search search
    where("email LIKE ?", "%#{search}%")
  end

end
