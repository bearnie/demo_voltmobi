require 'rubygems'
require 'role_model'

class User < ActiveRecord::Base

  before_create :accept_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include RoleModel
  roles_attribute :roles_mask
  roles :admin, :user

  has_attached_file :avatar, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/missing_images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # method to select appeal to users
  def appeal
    return name if name.present?
    email
  end

  def accept_roles
    self.roles = [:user] if self.roles.blank?
  end

end
