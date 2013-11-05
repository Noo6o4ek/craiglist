require 'spec_helper'

describe AdvertsController do
  render_views

  let(:user) { create :user }
  let(:advert) { create :advert }

  before do
    sign_in user
  end

  describe "#index" do
    it "renders advert" do
      get :index
      response.should be_success
    end
  end
end