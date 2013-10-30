require 'spec_helper'

feature 'User browsing the website' do
  before(:each) do
    visit new_admin_post_path
    fill_in 'post_title', with: 'this is a title'
    fill_in 'post_content', with: 'this is a comment'
    check('post_is_published')
    click_on 'Save' 
  end

  context "on homepage" do
    it "sees a list of recent posts titles" do
      visit root_path
      expect(page).to have_content 'This Is A Title'
    end

    it "can click on titles of recent posts and should be on the post show page" do
      visit root_path
      click_on('This Is A Title')
      expect(page).to have_content 'this is a comment'
    end
  end

  context "post show page" do
    it "sees title and body of the post" do
      pending
      # given a user and post(s)
      # user visits the post show page
      # user should see the post title
      # user should see the post body
    end
  end
end
