require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'bookを登録する' do
    expect { create(:book) }.to change { Book.count }.by(1)
  end

  describe 'バリデーション' do
    describe 'title' do
      context 'nullの場合' do
        let!(:book) { build(:book, title: nil) }
        it 'バリデーションエラーを発生させる' do
          expect(book).to be_invalid
        end

        it 'bookを登録しない' do
          expect { book.save }.to change { Book.count }.by(0)
        end
      end
    end

    describe 'author' do
      context 'nullの場合' do
        let!(:book) { build(:book, author: nil) }
        it 'バリデーションエラーを発生させる' do
          expect(book).to be_invalid
        end

        it 'bookを登録しない' do
          expect { book.save }.to change { Book.count }.by(0)
        end
      end
    end

    describe 'price' do
      context 'nullの場合' do
        let!(:book) { build(:book, price: nil) }
        it 'バリデーションエラーを発生させる' do
          expect(book).to be_invalid
        end

        it 'bookを登録しない' do
          expect { book.save }.to change { Book.count }.by(0)
        end
      end
    end
  end
end
