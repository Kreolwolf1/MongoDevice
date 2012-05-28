require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Password confirmation", :with => ""
          click_button 'Sign up'          
          page.should have_css("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    describe "success" do

      it "should make a new user" do
        lambda do
          visit new_user_registration_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Password confirmation", :with => "foobar"
          click_button 'Sign up'
          page.should have_selector("p",:content => "Welcome! You have signed up successfully.")
        end.should change(User, :count).by(1)
      end
    end
    describe "sign in/out" do

      describe "failure" do
        it "should not sign a user in" do      	
          visit new_user_session_path
          fill_in "Name",    :with => ""
          fill_in "Password", :with => ""
          click_button 'Sign in'
          page.should have_selector("p", :content => "Invalid name or password.")
        end
      end

      describe "success" do
        it "should sign a user in and out" do
          user = Factory(:user)
          visit new_user_session_path
          fill_in "Name",    :with => user.name
          fill_in "Password", :with => user.password
          click_button 'Sign in'
          page.should have_selector("p", :content => "Signed in successfully.")        
          click_link 'Logout'
          page.should have_selector("p", :content => "Signed out successfully.")
        end
      end
    end
  end
end
