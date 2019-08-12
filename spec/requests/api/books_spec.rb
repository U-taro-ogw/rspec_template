require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET api/books' do
    subject { proc { get api_books_path } }
    it 'hoge' do
      subject.call
      expect(json_response[:hoge]).to eq 'fuga'
    end
  end
end
