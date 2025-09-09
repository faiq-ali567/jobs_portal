class TextSubdomain
  def self.matches?(request)
    sub = request.subdomain.to_s
    sub.present? && (sub =~ /\A[a-z0-9\-]+\z/i)
  end
end
