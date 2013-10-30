require 'spec_helper'

feature 'Admin panel' do
  before(:each) do
    visit new_admin_post_path
    fill_in 'post_title', with: 'this is a title'
    fill_in 'post_content', with: 'this is a comment'
    check('post_is_published')
    click_on 'Save'
  end
  context "on admin homepage" do  

    it "can see a list of recent posts" do 
      expect(page).to have_content('This Is A Title')
    end

    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      click_on 'Edit'
      expect(find_field('post_title').value).to have_content('This Is A Title')
    end

    it "can delete a post by clicking the delete link next to a post" do
      visit admin_posts_path
      expect {
      click_on 'Delete'
      wait(3)
            }.to change(Post, :count).by(-1)
    end

    it "can create a new post and view it" do
       visit new_admin_post_url

       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       expect(page).to have_content "Published: true"
       expect(page).to have_content "Post was successfully saved."
     end
  end

  context "editing post" do
  let(:post) {Post.create title: 'hey', content: 'you'}
    it "can mark an existing post as unpublished" do
      visit edit_admin_post_path(post)
      uncheck('post_is_published')
      click_on 'Save'
      
      expect(page).to have_content "Published: false"
    end
  end

  context "on post show page", :js => true  do
    let(:post) {Post.create title: 'Title Here', content: 'content here'}

    it "can visit a post show page by clicking the title" do
      visit admin_posts_path(post)
      click_on 'Title Here'
      expect(page).to have_content "content here"
    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_post_path(post)
      expect(page).to have_content 'Edit'
      click_on 'Edit post'
      expect(find_field('post_title').value).to have_content('Title Here')
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_post_path(post)
      expect(page).to have_content 'Admin welcome page'
      click_on 'Admin welcome page'
      expect(page).to have_content('Welcome to the admin panel!')
    end
  end
end

# , :js => true
