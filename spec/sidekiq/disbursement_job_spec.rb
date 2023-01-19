require 'rails_helper'

RSpec.describe DisbursementJob, type: :job do
  describe '#perform' do
    let(:previous_week) { 1.week.ago }
    let(:merchant_id_1) { create(:merchant).id }
    let(:merchant_id_2) { create(:merchant).id }
    let!(:order_1) { create(:order, merchant_id: merchant_id_1, completed_at: previous_week, amount: 49.00) }
    let!(:order_2) { create(:order, merchant_id: merchant_id_1, completed_at: previous_week, amount: 200.00) }
    let!(:order_3) { create(:order, merchant_id: merchant_id_2, completed_at: previous_week, amount: 300.00) }
    let!(:order_4) { create(:order, merchant_id: merchant_id_2, completed_at: previous_week, amount: 400.00) }
    let(:order_5) { create(:order, merchant_id: merchant_id_1, completed_at: Time.current, amount: 50) }
    let(:order_6) { create(:order, merchant_id: merchant_id_1, completed_at: Time.current, amount: 150) }
    let(:order_7) { create(:order, merchant_id: merchant_id_2, completed_at: Time.current, amount: 350) }
    let(:order_8) { create(:order, merchant_id: merchant_id_2, completed_at: Time.current, amount: 450) }

    it 'calculates the correct disbursement fee for completed orders on the previous week' do
      Timecop.freeze do
        calculated_amount_1 = BigDecimal((order_1.amount - (order_1.amount * 0.01)) + (order_2.amount - (order_2.amount * 0.0095)))
        calculated_amount_2 = BigDecimal((order_3.amount - (order_3.amount * 0.0095)) + (order_4.amount - (order_4.amount * 0.0085)))
        expect(Disbursement).to receive(:create).with(amount: calculated_amount_1, merchant_id: merchant_id_1, disbursed_at: Time.current)
        expect(Disbursement).to receive(:create).with(amount: calculated_amount_2, merchant_id: merchant_id_2, disbursed_at: Time.current)
        subject.perform(previous_week)
      end
      Timecop.return
    end

    it 'calculates the correct disbursement fee for completed orders on the previous week' do
      Timecop.freeze do
        calculated_amount_3 = BigDecimal((order_5.amount - (order_5.amount * 0.0095)) + (order_6.amount - (order_6.amount * 0.0095)))
        calculated_amount_4 = BigDecimal((order_7.amount - (order_7.amount * 0.0085)) + (order_8.amount - (order_8.amount * 0.0085)))
        expect(Disbursement).to receive(:create).with(amount: calculated_amount_3, merchant_id: merchant_id_1, disbursed_at: Time.current)
        expect(Disbursement).to receive(:create).with(amount: calculated_amount_4, merchant_id: merchant_id_2, disbursed_at: Time.current)
        subject.perform(Time.current)
      end
      Timecop.return
    end
  end
end
