module UserHelpers
  
  def create_visitor
    @visitor ||= FactoryGirl.attributes_for :user
  end

  def find_user
    @user ||= User.where(email: @visitor[:email])
  end

  def delete_user
    @user ||= User.where(email: @visitor[:email]).first
    @user.destroy unless @user.nil?
  end

  def create_user
    create_visitor
    delete_user
    @user = FactoryGirl.create(:user)
  end

  def sign_in
    visit new_user_session_path
    fill_in "user[email]", :with => @visitor[:email]
    fill_in "user[password]", :with => @visitor[:password]
    click_button "Sign in"
  end

end

World(UserHelpers)
