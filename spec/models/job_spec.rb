require 'rails_helper'

RSpec.describe Job, type: :model do
  let(:company) do
    User.create!(
      email: "company@example.com",
      password: "password",
      password_confirmation: "password",
      jti: SecureRandom.uuid
    )
  end

  context "validations" do
    it "is valid with title, description, location and company" do
      job = Job.new(
        title: "Software Engineer",
        description: "SE",
        location: "Remote",
        company: company
      )
      expect(job).to be_valid
    end

    it "is invalid without a title" do
      job = Job.new(description: "Missing title", location: "Lahore", company: company)
      expect(job).not_to be_valid
      expect(job.errors[:title]).to be_present
    end

    it "is invalid without a description" do
      job = Job.new(title: "No Description", location: "Lahore", company: company)
      expect(job).not_to be_valid
      expect(job.errors[:description]).to be_present
    end
  end

end
