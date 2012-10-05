require 'spec_helper'

describe UsersController do
  describe "index" do
    it "returns a 200" do
      get :index
      response.should be_success
    end
  end
  describe "new" do
    describe "when logged in" do
      it "will not create a user if you are logged in" do
        user = FactoryGirl.create(:user)
        UserSession.create!(:login => user.login, :password => user.password)
        get :new
        response.should redirect_to user_path(user)
      end
    end
  end     
  describe "create" do
    describe "with good params" do
      it "will create a new user" do
        lambda {
          post :create, :user => {:login => "newlogin", :password => "newpassword", :password_confirmation => "newpassword"}
        }.should change {User.count}
      end
    
      it "will redirect" do
        post :create, :user => {:login => "newlogin", :password => "newpassword", :password_confirmation => "newpassword"}
        response.should be_redirect 
      end
    end
    describe "with bad params" do
      it "will not create a user" do
        lambda {
          post :create, :user => nil
        }.should_not change {User.count}
      end
      
      it "will render the new user page" do
        post :create, :user => nil
        should render_template :new
      end
    end
  end
end
