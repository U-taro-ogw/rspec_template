require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:book) { create(:book) }

  describe '登録' do
    it 'commentを登録する' do
      expect { create(:comment, book_id: book.id) }.to change { Comment.count }.by(1)
    end
  end

  describe 'バリデーション' do

    shared_examples 'commentを登録する' do
      it 'バリデーションエラーを発生させない' do
        expect(comment).to be_valid
      end

      it 'commentを登録する' do
        expect { comment.save }.to change { Comment.count }.by(1)
      end
    end

    shared_examples 'commentを登録しない' do
      it 'バリデーションエラーを発生させる' do
        expect(comment).to be_invalid
      end

      it 'commentを登録しない' do
        expect { comment.save }.to change { Comment.count }.by(0)
      end
    end

    describe 'book_id' do
      let(:comment) { build(:comment, book_id: book_id) }
      context '存在するbookのidの場合' do
        let(:book_id) { book.id }
        it_behaves_like 'commentを登録する'
      end

      context '存在しないbookのidの場合' do
        let(:book_id) { book.id + 1 }
        it_behaves_like 'commentを登録しない'
      end

      context 'nullの場合' do
        let(:book_id) { nil }
        it_behaves_like 'commentを登録しない'
      end
    end

    describe 'text' do
      let(:comment) { build(:comment, book_id: book.id, text: text) }

      context '100文字の場合' do
        let(:text) { 'a' * 100 }
        it_behaves_like 'commentを登録する'
      end

      context '101文字の場合' do
        let(:text) { 'a' * 101 }
        it_behaves_like 'commentを登録しない'
      end

      context 'nullの場合' do
        let(:text) { nil }
        it_behaves_like 'commentを登録しない'
      end
    end
  end
end
