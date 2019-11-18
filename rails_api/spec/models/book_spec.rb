require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'bookを登録する' do
    expect { create(:book) }.to change { Book.count }.by(1)
  end

  describe 'バリデーション' do

    shared_examples 'bookを登録する' do
      it 'バリデーションエラーを発生させない' do
        expect(book).to be_valid
      end

      it 'bookを登録する' do
        expect { book.save }.to change { Book.count }.by(1)
      end
    end

    shared_examples 'bookを登録しない' do
      it 'バリデーションエラーを発生させる' do
        expect(book).to be_invalid
      end

      it 'bookを登録しない' do
        expect { book.save }.to change { Book.count }.by(0)
      end
    end

    describe 'title' do
      let(:book) { build(:book, title: title) }
      context '100文字の場合' do
        let(:title) { 'a' * 100 }
        it_behaves_like 'bookを登録する'
      end

      context '101文字の場合' do
        let(:title) { 'a' * 101 }
        it_behaves_like 'bookを登録しない'
      end

      context 'nullの場合' do
        let(:title) { nil }
        it_behaves_like 'bookを登録しない'
      end
    end

    describe 'author' do
      let(:book) { build(:book, author: author) }
      context '50文字の場合' do
        let(:author) { 'a' * 50 }
        it_behaves_like 'bookを登録する'
      end

      context '51文字の場合' do
        let(:author) { 'a' * 51 }
        it_behaves_like 'bookを登録しない'
      end

      context 'nullの場合' do
        let(:author) { nil }
        it_behaves_like 'bookを登録しない'
      end
    end

    describe 'price' do
      let!(:book) { build(:book, price: price) }
      context 'intの場合' do
        let(:price) { 1 }
        it_behaves_like 'bookを登録する'
      end

      context 'floatの場合' do
        let(:price) { 1.11 }
        it_behaves_like 'bookを登録しない'
      end

      context 'stringの場合' do
        let(:price) { 'a' }
        it_behaves_like 'bookを登録しない'
      end

      context 'nullの場合' do
        let(:price) { nil }
        it_behaves_like 'bookを登録しない'
      end
    end
  end
end
