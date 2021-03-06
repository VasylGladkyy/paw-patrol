class NotificateReviewChangedJob < ApplicationJob
  queue_as :default

  def perform(review)
    ActionCable.server.broadcast(
      "company_dashboard:#{review.ticket.company.id}",
      { event: '@reviewRates',
        data: CompanyDashboard.new(review.ticket.company).review_rates }
    )
  end
end
