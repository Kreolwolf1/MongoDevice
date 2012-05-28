require 'spec_helper'

describe ArticlesController do
  render_views

  # This should return the minimal set of attributes required to create a valid
  # Article. As you add validations to Article, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {:name => "Tryal name",
     :content => "stupid content"}
  end

  describe "everyone can watch" do

    before(:each) do
      user = Factory(:user)
      sign_in user
      @article = user.articles.create! valid_attributes
      sign_out user
    end

    it "the list of articles" do
      visit root_path
      response.should render_template("articles/index")
      page.should have_selector("h1", :text => "Listing articles")
      page.should have_selector("li", :text => "Login")
    end

    it "any article" do
      visit article_path @article
      response.should render_template("articles/show")
      response.status.should be(200)
      page.should have_selector("p", :text => "Tryal name")
      page.should have_selector("li", :text => "Login")
    end
  end

  describe "unregistered user cannot" do

    before(:each) do
      user = Factory(:user)
      sign_in user
      @article = user.articles.create! valid_attributes
      sign_out user
    end
      
    it "create article" do
      visit root_path
      click_link 'New Article'
      response.should render_template("devise/sessions/new")
      page.should have_selector("p", :text => "You need to sign in or sign up before continuing.")
    end

    it "edit article" do
      visit edit_article_path @article
      response.should render_template("devise/sessions/new")
      page.should have_selector("p", :text => "You need to sign in or sign up before continuing.")
    end

    it "delete article" do
      expect {
        delete :destroy, {:id => @article.to_param}
      }.to change(Article, :count).by(0)
    end

  end

  describe "registered user can" do

    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @article = @user.articles.create! valid_attributes
    end
      
    it "create article" do
      expect {
        post :create, {:article => valid_attributes}
      }.to change(Article, :count).by(1)
    end

    it "edit article which belongs to him" do
      @article.update_attributes(:name => 'Another name', :content => 'Fair content')
      put :update, {:id => @article.to_param, :article => {'these' => 'params'}}
      @article.name.should == 'Another name'
    end

    it "delete article which belongs to him" do
      expect {
        delete :destroy, {:id => @article.to_param}
      }.to change(Article, :count).by(-1)
    end

  end

  describe "registered user cannot" do

    before(:each) do
      @user = Factory(:user)
      sign_in @user
      @article = @user.articles.create! valid_attributes
      sign_out @user
    end

    it "delete article which doesn't belong to him" do
      angry_user = Factory(:user)
      sign_in angry_user
      expect {
        delete :destroy, {:id => @article.to_param}
      }.to change(Article, :count).by(0)
    end
  end
end
