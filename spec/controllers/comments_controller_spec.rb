require 'spec_helper'

describe CommentsController do
  render_views

  describe "#destroy" do
    def do_delete
      delete :destroy, id: comment.to_param
    end

    let(:comment) { create(:comment, advert_id: advert_by_vasya.id, user_id: vasya.to_param) }
    let!(:vasya) { create(:user) }
    let!(:advert_by_vasya) { create(:advert, user_id: vasya.id) }

    it 'is success' do
      do_delete
      response.status.should eq 200
    end
  end
end