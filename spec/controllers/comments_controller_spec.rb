require 'spec_helper'

describe CommentsController do
  render_views

  def valid_attributes
    {:name => "Tryal name",
     :content => "stupid content"}
  end

  def user_attributes
    {:name => "Some user",
     :email => "example@mail.ua",
	 :password => "password",
	 :password_confirmation => "password"}
  end
    
  describe "unregistered user cannot" do
    it "create comment" do
	  article = Article.create! valid_attributes
      visit article_path article
      response.should render_template("articles/show")
      page.should have_selector("p", :text => "Tryal name")
      page.should have_selector("h2", :text => "New Comment")
      fill_in "Name",                   :with => "Some title"
      fill_in "comment_content",        :with => "some content"
      click_button 'Create Comment'
      response.should render_template("devise/sessions/new")
      page.should have_selector("p", :text => "You need to sign in or sign up before continuing.")
    end
  end

  describe "registered user can" do
    it "create comment" do
      user = User.create! user_attributes
      sign_out user
	  article = user.articles.create! valid_attributes
	  comment = user.comments.create! valid_attributes
	  comment.name.should == 'Tryal name'
    end
  end

end
