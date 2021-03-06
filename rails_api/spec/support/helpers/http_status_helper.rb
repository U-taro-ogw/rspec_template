shared_examples 'ステータス200を返却する' do
  it 'ステータス200を返却する' do
    subject.call
    expect(response).to have_http_status(:ok)
  end
end

shared_examples 'ステータス201を返却する' do
  it 'ステータス201を返却する' do
    subject.call
    expect(response).to have_http_status(:created)
  end
end

shared_examples 'ステータス400を返却する' do
  it 'ステータス400を返却する' do
    subject.call
    expect(response).to have_http_status(:bad_request)
  end
end

shared_examples 'ステータス404を返却する' do
  it 'ステータス404を返却する' do
    subject.call
    expect(response).to have_http_status(:not_found)
  end
end
