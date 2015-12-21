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

  # method to select appeal to users
  def appeal
    return name if name.present?
    email
  end

  def accept_roles
    self.roles = [:user] if self.roles.blank?
  end

end
