require 'spec_helper'

describe Post do
  it "is not valid without a title" do
    post = Post.new(:title => nil, :content => "CONTENT")
    post.should_not be_valid
  end
  
  it "is not valid without content" do
    post = Post.new(:title => "TITLE", :content => nil)
    post.should_not be_valid
  end
  
  it "is valid when both title and content are present" do
    post = Post.new(:title => "TITLE", :content => "CONTENT")
    post.should be_valid
  end
end
