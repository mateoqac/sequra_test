# frozen_string_literal: true

class DisbursementWorker
  include Sidekiq::Worker

  def perform
    DisbursementJob.perform_later(Time.current)
  end
end
