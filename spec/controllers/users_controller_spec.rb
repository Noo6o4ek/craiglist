require 'spec_helper'

describe UsersController do
  render_views

  let(:admin) { create :admin }
  let(:advert) { create :advert }

  before do
    sign_in admin
  end

  describe "#index" do
    it "renders user" do
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end
  end

  describe "#show" do
    it 'is success' do
      get :show, id: admin.to_param
      response.should be_success
    end
  end

  describe '#edit' do
    it 'is success' do
      get :show, id: admin.to_param
      response.should be_success
    end
  end

  describe '#new' do
    it 'is success' do
      get :new
      response.should be_success
    end
  end

  describe '#destroy' do
    def do_delete
      delete :destroy, id: vasya.to_param
    end

    let!(:comment) { create(:comment, advert_id: advert_by_vasya.id) }
    let(:vasya) { create(:user) }
    let(:moder) { create(:moderator) }
    let!(:advert_by_vasya) { create(:advert, user_id: vasya.id) }

    it 'is success' do
      do_delete
      response.status.should eq 302
    end

    it 'redirects to users path' do
      do_delete
      response.should redirect_to("/users")
    end

    it 'destroys user' do
      sign_in vasya
      expect { do_delete }.to change { User.count }.by(-1)
    end

    it 'destroys advert' do
      sign_in vasya
      expect { do_delete }.to change { Advert.count }.by(-1)
    end

    it 'destroys joined comment' do
      sign_in vasya
      expect { do_delete }.to change { Comment.count }.by(-1)
    end

    it 'renders error' do
      sign_in moder
      do_delete
      flash[:error].should eq "You can't perform this action."
    end
  end
end
