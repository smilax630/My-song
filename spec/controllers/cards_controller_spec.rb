require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  describe "createアクション" do
    context "有料会員の場合" do

      before do
        @user = FactoryBot.create(:user, member_status: 1 )
      end

      it "レスポンスのステータスが[302（失敗)」になる" do
        sign_in @user
        get :create
        expect(response).to have_http_status "302"
      end

      it "投稿一覧ページに遷移する" do
        sign_in @user
        get :create
        expect(response).to redirect_to songs_path
      end
    end

    context "未ログイン時" do
      
      it "レスポンスのステータスが[302（失敗)」になる" do
        get :create
        expect(response).to have_http_status "302"
      end

      it "サインインページに遷移する" do
        get :create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
