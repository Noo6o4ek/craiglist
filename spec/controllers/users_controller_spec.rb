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
end
