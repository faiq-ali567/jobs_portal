class Job < ApplicationRecord
  
  belongs_to :company, class_name: "User"

  has_one :document, as: :documentable, dependent: :destroy


  validates :title, :description, :location, presence: true

  accepts_nested_attributes_for :document

  has_many :applications, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    
      ["title", "description", "salary", "location", "company_id", "created_at", "updated_at"]
  end 
  def self.ransackable_associations(auth_object = nil)
    ["applications", "company", "document"]
  end
end
