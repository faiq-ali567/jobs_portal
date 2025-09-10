module TenantScoped
  extend ActiveSupport::Concern

  included do
    before_action :set_tenant
  end

  private

  def set_tenant
    sub = request.subdomain.to_s
    # byebug
    if sub == "admin"
      Current.company =  nil
      unless current_user.admin? ||
             current_user.company_manager? || current_user.user_manager?
        render json: { error: "Forbidden" }, status: :forbidden and return
      end
    elsif sub.match?(/\A[a-z0-9\-]+\z/i)
      company = User.find_by(subdomain: sub, role: :company)
      unless company
        render json: { error: "Company not found" }, status: :not_found and return
      end
      if current_user != nil && current_user.company? && current_user.subdomain != sub
        render json: { error: "Forbidden" }, status: :forbidden and return
      end
      Current.company = company
    else
      Current.company = nil
    end

    Current.user = current_user if respond_to?(:current_user)
  end
end
