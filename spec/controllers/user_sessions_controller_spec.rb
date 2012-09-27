require 'spec_helper'

describe UserSessionsController do
  describe "create" do
    describe "does not log you in when" do
      it "is not given params" do
        post :create, :user_session => nil
        response.should redirect_to(new_user_sessions_path)
      end
      
      it "is given non-relevant params" do
        post :create, :user_session => "String"
        response.should redirect_to(new_user_sessions_path)
      end
      
      it "is given incorrect params" do
        post :create, :user_session => {:login => "test", :password => "test"}
        response.should redirect_to(new_user_sessions_path)
      end
    end
  end
end
