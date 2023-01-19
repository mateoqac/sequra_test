# frozen_string_literal: true

class DisbursementJob
  include Sidekiq::Job

  def perform(week)
    week_to_date = week.to_date
    # Retrieve all completed orders from the previous week
    orders = Order.where('completed_at >= ? AND completed_at < ?', week_to_date.beginning_of_week,
                         week_to_date.end_of_week)

    # Group orders by merchant
    orders_by_merchant = orders.group_by(&:merchant_id)

    # Calculate disbursement amount for each merchant
    disbursements = orders_by_merchant.map do |merchant_id, orders|
      total_amount = 0
      orders.each do |order|
        fee = if order.amount < 50
                order.amount * 0.01
              elsif order.amount <= 300
                order.amount * 0.0095
              else
                order.amount * 0.0085
              end
        total_amount += order.amount - fee
      end

      { merchant_id:, disbursement_amount: total_amount }
    end

    # Persist disbursements in the database
    disbursements.each do |disbursement|
      Disbursement.create(merchant_id: disbursement[:merchant_id], amount: disbursement[:disbursement_amount],
                          disbursed_at: Time.current)
    end
  end
end
