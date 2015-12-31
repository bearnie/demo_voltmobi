require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  before do
    @user = FactoryGirl.build(:user)
    @user.save
    sign_in @user
  end

end
