tp = TracePoint.new(:class) do |t|
  curr = t.self
  if curr < ApplicationRecord && curr.name != "User" &&
    curr.name != "Document"

    curr.class_eval do
      default_scope -> {
        if Current.company.present?
          where(company_id: Current.company.id)
        else
          all
        end
      }
    end
  end
end

tp.enable
