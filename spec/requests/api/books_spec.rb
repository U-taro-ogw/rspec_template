require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET api/books' do
    subject { proc { get api_books_path } }

    shared_examples '一覧検索成功' do
      it 'bookを全件返却する' do
        subject.call
        response = json_response[:data]
        expect(response.length).to eq books_count

        response.zip(books).each do |response_book, book|
          expect(response_book[:type]).to eq 'book'
          expect(response_book[:id]).to eq book.id.to_s

          response_attribute = response_book[:attributes]
          expect(response_attribute[:title]).to eq book.title
          expect(response_attribute[:author]).to eq book.author
          expect(response_attribute[:price]).to eq book.price
          expect(response_attribute[:created_at]).to eq to_iso8601(book.created_at)
          expect(response_attribute[:updated_at]).to eq to_iso8601(book.updated_at)
        end
      end
    end

    context 'bookが1件以上存在する場合' do
      let(:books_count) { books.length }

      context 'bookが1件の場合' do
        let!(:books) { [create(:book)] }

        it_behaves_like 'ステータス200を返却する'
        it_behaves_like '一覧検索成功'
      end

      context 'bookがn件の場合' do
        let!(:books) { (1..2).map { create(:book) } }

        it_behaves_like 'ステータス200を返却する'
        it_behaves_like '一覧検索成功'
      end
    end

    context 'bookが0件の場合' do
      let(:books) { [] }
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

        response = json_response[:data]
        expect(response[:type]).to eq 'book'
        expect(response[:id]).to eq book_id.to_s

        response_attribute = response[:attributes]
        expect(response_attribute[:title]).to eq book.title
        expect(response_attribute[:author]).to eq book.author
        expect(response_attribute[:price]).to eq book.price
        expect(response_attribute[:created_at]).to eq to_iso8601(book.created_at)
        expect(response_attribute[:updated_at]).to eq to_iso8601(book.updated_at)
      end
    end

    context '指定されたidのbookが存在しない場合' do
      let(:book_id) { book.id + 1 }

      it_behaves_like 'ステータス404を返却する'
    end
  end
end
