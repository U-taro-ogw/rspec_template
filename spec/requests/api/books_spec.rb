require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET api/books' do
    subject { proc { get api_books_path } }

    shared_examples '一覧検索成功' do
      it 'bookを全件返却する' do
        subject.call
        response_data = json_response[:data]
        expect(response_data.length).to eq books_count

        response_data.zip(books).each do |response_book, book|
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

        response_data = json_response[:data]
        expect(response_data[:type]).to eq 'book'
        expect(response_data[:id]).to eq book_id.to_s

        response_attribute = response_data[:attributes]
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

  describe 'POST api/books' do
    subject { proc { post api_books_path, params: post_params } }
    let(:post_params) { { books: books_param } }

    context '登録できるパラメータの場合' do
      shared_examples '登録成功' do
        it_behaves_like 'ステータス201を返却する'

        it 'bookをパラメータの件数分作成する' do
          expect { subject.call }.to change { Book.count }.by(param_count)
        end
      end

      context '登録件数が1件の場合' do
        let(:param_count) { 1 }
        let(:books_param) { [ { title: 'title', author: 'author', price: 1 } ] }

        it_behaves_like '登録成功'

        it 'パラメータ通りの値で登録する' do
          subject.call
          response_data = json_response[:data]

          response_data.each do |response_book|
            expect(response_book[:type]).to eq 'book'
            response_attribute = response_book[:attributes]
            expect(response_attribute[:title]).to eq post_params[:books][0][:title]
            expect(response_attribute[:author]).to eq post_params[:books][0][:author]
            expect(response_attribute[:price]).to eq post_params[:books][0][:price]
          end
        end
      end

      context '登録件数が複数件の場合' do
        let(:param_count) { 2 }
        let(:books_param) { (1..param_count).map { |i| { title: "title_#{i}", author: "author_#{i}", price: i } } }

        it_behaves_like '登録成功'

        it 'パラメータ通りの値で登録する' do
          subject.call
          response_data = json_response[:data]

          response_data.zip(post_params[:books]) do |response_book, post_param|
            expect(response_book[:type]).to eq 'book'
            response_attribute = response_book[:attributes]
            expect(response_attribute[:title]).to eq post_param[:title]
            expect(response_attribute[:author]).to eq post_param[:author]
            expect(response_attribute[:price]).to eq post_param[:price]
          end
        end
      end
    end

    xcontext 'バリデーションエラーが発生する場合' do
      context '必須項目が入力されていない場合' do
        let(:books_param) { [ { title: '', author: 'author', price: 1 } ] }
        it_behaves_like 'ステータス400を返却する'
      end
    end
  end
end
