# frozen_string_literal: true

RSpec.describe MeiliSearch do
  it 'has a version number' do
    expect(MeiliSearch::VERSION).not_to be nil
  end

  it 'raises an exception when it is impossible to connect' do
    new_client = MeiliSearch::Client.new('http://127.0.0.1:8800', 'masterKey')
    expect do
      new_client.indexes
    end.to raise_error(MeiliSearch::CommunicationError)
  end

  it 'allows to set a custom timeout and max_retries' do
    new_client = MeiliSearch::Client.new(URL, MASTER_KEY, timeout: 20, max_retries: 2)
    expect(new_client.healthy?).to be true
  end

  it 'raises a timeout error when setting the timeout option' do
    new_client = MeiliSearch::Client.new(URL, MASTER_KEY, timeout: 0.00001)

    expect do
      new_client.indexes
    end.to raise_error(Timeout::Error)
  end
end
