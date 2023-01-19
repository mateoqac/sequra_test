# frozen_string_literal: true

module Api
  class DisbursementsController < ApplicationController
    def index
      return render json: [], status: :ok unless params[:week]

      begin
        week = params[:week].to_date
        disbursements = if params[:merchant_id] # Filter by merchant if provided
                          Disbursement.where('disbursed_at >= ? AND disbursed_at < ?', week.beginning_of_week,
                                             week.end_of_week).where(merchant_id: params[:merchant_id])
                        else
                          Disbursement.where('disbursed_at >= ? AND disbursed_at < ?', week.beginning_of_week,
                                             week.end_of_week)
                        end
      rescue ArgumentError
        return render json: { error: "Invalid date format, please use the format 'YYYY-MM-DD'" },
                      status: :bad_request
      end

      render json: disbursements
    end
  end
end
