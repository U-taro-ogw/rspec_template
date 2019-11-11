require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:book) { create(:book) }

  describe '登録' do
    it 'commentを登録する' do
      expect { create(:comment, book_id: book.id) }.to change { Comment.count }.by(1)
    end
  end

  describe 'バリデーション' do

    describe 'book_id' do

    end

    describe 'text' do
      let(:comment) { build(:comment, book_id: book.id, text: text) }

      context 'nullの場合' do
        let(:text) { nil }
        it 'バリデーションエラーを発生させる' do
          expect(comment).to be_invalid
        end

        it 'commentを登録しない' do
          expect { comment.save }.to change { Comment.count }.by(0)
        end
      end

      context '100文字の場合' do
        let(:text) { 'a' * 100 }
        it 'バリデーションエラーを発生させない' do
          expect(comment).to be_valid
        end

        it 'commentを登録する' do
          expect { comment.save }.to change { Comment.count }.by(1)
        end
      end

      context '101文字の場合' do
        let(:text) { 'a' * 101 }
        it 'バリデーションエラーを発生させる' do
          expect(comment).to be_invalid
        end

        it 'commentを登録しない' do
          expect { comment.save }.to change { Comment.count }.by(0)
        end
      end
    end
  end
end
