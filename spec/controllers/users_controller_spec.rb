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
      before do
        @user = FactoryGirl.create(:user)
        UserSession.create!(:login => @user.login, :email => @user.email, :password => @user.password)
      end
      
      it "will redirect to currently logged in user page" do
        get :new
        response.should redirect_to user_path(@user)
      end
      
      it "will not not create a new user" do
        lambda {get :new}.should_not change {User.count}
      end
    end
  end     
  describe "create" do
    describe "with good params" do
      it "will create a new user" do
        lambda {
          post :create, :user => {:login => "newlogin", :email => "test@example.com", :password => "newpassword", :password_confirmation => "newpassword"}
        }.should change {User.count}
      end
    
      it "will redirect" do
        post :create, :user => {:login => "newlogin", :email => "test@example.com", :password => "newpassword", :password_confirmation => "newpassword"}
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
  
  describe "update" do
    describe "correct password" do
      before do
        @user = FactoryGirl.create(:user)
        UserSession.create!(:login => @user.login, :password => @user.password)
        put :update, :user => {:login => @user.login, :email => @user.email, :password => "Isherwood", :password_confirmation => "Isherwood"},
                     :old_password => @user.password,
                     :id => @user.id
      end
      it "will change your password" do
        
        @user.reload.valid_password?("Isherwood").should be_true
      end
      
      it "redirects to the user page" do
        response.should redirect_to user_path(@user)
      end
    end
    
    describe "incorrect old password" do
      before do
        @user = FactoryGirl.create(:user)
        UserSession.create!(:login => @user.login, :password => @user.password)
        put :update, :user => {:login => @user.login, :password => "Isherwood", :password_confirmation => "Isherwood"},
                     :old_password => "wouldyoukindlychangethepassword",
                     :id => @user.id
      end
      it "will not change your password" do  
        @user.reload.valid_password?("Isherwood").should_not be_true
      end
      
      it "will render edit" do
        should render_template :edit
      end
    end
  end
end
