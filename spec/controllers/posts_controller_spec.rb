require 'spec_helper'

describe PostsController do
  describe "index" do
    it "returns a 200" do
      get :index
      response.should be_success
    end
  end
end
