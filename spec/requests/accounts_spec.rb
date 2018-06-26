require 'rails_helper'

RSpec.describe 'Accounts', type: :request do
  let!(:account) { create(:account, :active, :matrix) }
  let(:account_id) { account.id }
  let!(:corporation) { create(:corporation, account_id: account_id) }

  describe 'GET /v1/accounts/:id' do
    before { get "/v1/accounts/#{account_id}" }

    context 'when the record exists' do
      it 'returns the account' do
        expect(json_data).not_to be_empty
        expect(json_data[:data][:id].to_i).to eq(account_id)
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /v1/accounts' do
    let(:account_attributes) do
      {
        account: {
          name: 'Test Account',
          person_type: 'corporation',
          cnpj: '12345678901234',
          social_name: 'Test Co.',
          trade_name: 'Test Co. 2'
          # "parent_id": 29
        }
      }
    end

    context 'when the request params are valid' do
      before { post '/v1/accounts', params: account_attributes }


      it 'creates an account' do
        expect(json_data).not_to be_empty
      end

      it 'returns the status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request params are invalid' do
      before do
        post '/v1/accounts',
          params: { account: { person_type: 'Corporation' } }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /v1/accounts/:id' do
    let(:account_attributes) { { account: { name: 'Account updated' } } }

    context 'when the record exists' do
      before do
        put "/v1/accounts/#{account_id}", params: account_attributes
      end

      it 'updates the record' do
        expect(json_data).not_to be_empty
      end

      it 'returns the status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /v1/accounts/:id' do
    before { delete "/v1/accounts/#{account_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
