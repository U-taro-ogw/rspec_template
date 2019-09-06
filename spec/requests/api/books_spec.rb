require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET api/books' do
    subject { proc { get api_books_path } }

    shared_examples '一覧検索成功' do
      it 'bookを全件返却する' do
        subject.call
        expect(json_response[:books].length).to eq books_count
      end
    end

    context 'bookが1件以上存在する場合' do
      context 'bookが1件の場合' do
        let!(:books) { create(:book) }
        let(:books_count) { 1 }

        it_behaves_like 'ステータス200を返却する'
        it_behaves_like '一覧検索成功'
      end

      context 'bookがn件の場合' do
        let!(:books) { (1..2).map{ |i| create(:book) } }
        let(:books_count) { books.length }

        it_behaves_like 'ステータス200を返却する'
        it_behaves_like '一覧検索成功'
      end
    end

    context 'bookが0件の場合' do
      let(:books_count) { 0 }

      it_behaves_like 'ステータス200を返却する'
      it_behaves_like '一覧検索成功'
    end
  end

  describe 'GET api/books/:id' do
    subject { proc { get api_book_path(book_id) } }
    let!(:book) { create(:book) }

    context '指定されたidのbookが存在する場合' do
      let(:book_id) { book.id }

      it_behaves_like 'ステータス200を返却する'

      it 'bookを返却する' do
        subject.call
        p json_response.class
        puts json_response[:data][:id]

        expect(1).to eq 2
        # book.each do |element|
        #   expect().to eq book.to_json
        # end
      end
    end

    context '指定されたidのbookが存在しない場合' do
      let(:book_id) { book.id + 1 }

      it_behaves_like 'ステータス404を返却する'
    end
  end
end
