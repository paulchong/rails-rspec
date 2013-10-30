require 'spec_helper'

describe Admin::PostsController do
  describe "admin panel" do
    it "#index" do
      get :index
      expect(response.status.should eq 200)
    end

    it "#new" do
      get :new
      expect(response.status.should eq 200)
    end

    context "#create" do
      let(:params) {
        {:post => {:title => "this is a title", :content => "more content"}}
      }
      it "creates a post with valid params" do
        expect {
          post :create, params
          }.to change(Post, :count).by(1)

          expect(Post.last.content).to eq(params[:post][:content])

        end
        it "doesn't create a post when params are invalid" do
          params[:post].delete(:content)
          expect {
            post :create, params
            }.to_not change(Post, :count)

          end
        end

        context "#edit" do
          let!(:post) {Post.create({title: "hey", content: "you"})}

          it 'checks that page renders correctly' do
            get :edit, id: post.id
            expect(response.status.should eq 200)
          end

          it "updates a post with valid params" do
            put :update, id: post.id
            post.title = "new title"
            expect(post.title).to eq "new title"
          end

          it "doesn't update a post when params are invalid" do
            put :update, id: post.id, post: {title: nil}
            response.should render_template('edit')
          end

          it "#destroy" do
            expect {
            delete :destroy, id: post.id
            }.to change(Post, :count).by(-1)
          end
        end
      end
    end
