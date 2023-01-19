require 'rails_helper'

RSpec.describe "Disbursements", type: :request do
  describe "GET /index" do
		let!(:merchants) do
      [create(:merchant),create(:merchant),create(:merchant)]
    end

		context 'when params are send properly' do
			before do
				[merchants.first, merchants.second].each do |merchant|
					create(:disbursement, merchant:, disbursed_at: 1.week.ago.beginning_of_week )
				end

				[merchants.first, merchants.last].each do |merchant|
					create(:disbursement, merchant:, disbursed_at: 2.week.ago.beginning_of_week )
				end
			end

			context 'when no merchant id is given' do
				before do
					get api_disbursements_path, :params => {week: '2023-01-12'}
				end
				it 'will return a success response' do
					expect(response).to have_http_status(:success)
				end

				it "will return the last 2 disbursements" do
					expect(JSON.parse(response.body).length).to eq(2)		
				end

				it "will return the disbursements for the first 2 merchants" do
					expect(JSON.parse(response.body).map{ |x| x['merchant_id']}).to match_array([merchants.first, merchants.second].map(&:id))
				end
			end

			context 'when merchant id is given' do
				let(:merchant) { merchants.second }
				before do
					get api_disbursements_path, :params => {week: '2023-01-09', merchant_id: merchant.id}
				end
				it 'will return a success response' do
					expect(response).to have_http_status(:success)
				end
				
				it "will return disbursements for the given merchant id" do
					expect(JSON.parse(response.body).map{ |x| x['merchant_id']}).to match_array([merchant.id])
				end
			end
		end

		context 'when params are not send properly' do
			context 'when week is send in the wrong format' do
				before do
					get api_disbursements_path, :params => {week: '2022-31-12'}
				end

				it 'will return a bad request' do
					expect(response).to have_http_status(:bad_request)
				end

				it 'will return an error' do
					expect(JSON.parse(response.body)['error']).to eq("Invalid date format, please use the format 'YYYY-MM-DD'")
				end
			end

			context 'when week is not present' do
				before do
					get api_disbursements_path, :params => {}
				end

				it 'will return a success response' do
					expect(response).to have_http_status(:success)
				end

				it 'will return an empty array' do
					expect(JSON.parse(response.body)).to eq([])
				end
			end
		end
  end
end
