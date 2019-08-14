require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET api/books' do
    subject { proc { get api_books_path } }

    shared_examples '一覧検索成功' do
      it '検索成功のステータスを返却する' do
        subject.call
        expect(json_response[:status]).to eq 200
      end

      it 'bookを全件返却する' do
        subject.call
        expect(json_response[:books].length).to eq books_count
      end
    end

    context 'bookが1件以上存在する場合' do
      context 'bookが1件の場合' do
        let!(:books) { create(:book) }
        let(:books_count) { 1 }

        it_behaves_like '一覧検索成功'
      end

      context 'bookがn件の場合' do
        let!(:books) { (1..2).map{ |i| create(:book) } }
        let(:books_count) { books.length }

        it_behaves_like '一覧検索成功'
      end
    end

    context 'bookが0件の場合' do
      let(:books_count) { 0 }
      it_behaves_like '一覧検索成功'
    end
  end
end
