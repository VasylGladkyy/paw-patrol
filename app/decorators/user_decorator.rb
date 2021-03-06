class UserDecorator < Draper::Decorator
  delegate_all
  decorates_association :telegram_profile

  def full_name
    [first_name, last_name].join(' ').strip
  end

  def display_role
    if admin?
      'Admin'
    else
      role.humanize.capitalize
    end
  end

  def after_sign_in_path
    admin? ? h.admin_dashboard_path : h.company_dashboard_path
  end

  def role_at_company
    if admin?
      'Admin'
    else
      "#{display_role} at #{company_name}"
    end
  end

  def company_name
    company.name if company.present?
  end

  def created_tickets_count
    h.pluralize(tickets.count, 'ticket')
  end

  def resolved_tickets_count
    h.pluralize(resolved_tickets.count, 'ticket')
  end

  def unread_notifications
    notifications.unread.includes(:user, :notified_by, noticeable: [:commentable])
  end
end
