require 'spec_helper'

describe PostsController do
  describe "index" do
    it "returns a 200" do
      get :index
      response.should be_success
    end
  end
  describe "create" do
    before do
      @user = FactoryGirl.create(:user)
      UserSession.create!(:login => @user.login, :password => @user.password)
    end
    describe "with good params" do
      it "saves the post" do
        lambda {
          post :create, :post => { :title => "Test title", :content => "Test content"}
        }.should change {Post.count}
      end
      
      it "redirects" do
        post :create, :post => { :title => "Test title", :content => "Test content"}
        response.should be_redirect
      end
      
      it "adds the post to the current user" do
        lambda {
          post :create, :post => { :title => "Test title", :content => "Test content"}
        }.should change {@user.posts.count}
      end
    end
  end
end
