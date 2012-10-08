require 'spec_helper'

describe UserSessionsController do
  describe "create" do
    describe "does not log you in when" do
      it "is not given params" do
        post :create, :user_session => nil
        UserSession.find.should be_nil
      end
      
      it "is given non-relevant params" do
        post :create, :user_session => "String"
        UserSession.find.should be_nil
      end
      
      it "is given incorrect params" do
        post :create, :user_session => {:login => "test", :password => "test"}
        UserSession.find.should be_nil
      end
    end
    describe "given correct params" do
      before do
        @user = FactoryGirl.create(:user)
        post :create, :user_session => {:login => @user.login, :password => @user.password}
      end
      
      it "logs you in when given correct params" do
        UserSession.find.should_not be_nil
      end
      
      it "redirects you to the current user page" do
        response.should redirect_to user_path(@user)
      end
    end  
  end
  
  describe "destroy" do
    before do
      user = FactoryGirl.create(:user)
      post :create, :user_session => {:login => user.login, :password => user.password}
      delete :destroy
    end
    
    it "destroys the user session" do
      UserSession.find.should be_nil
    end
  
    it "redirects to login page" do
      response.should redirect_to(new_user_sessions_path)
    end
  end
end
