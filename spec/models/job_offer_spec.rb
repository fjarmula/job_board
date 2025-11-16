require 'rails_helper'

RSpec.describe JobOffer, type: :model do
  subject do
    described_class.new(
      company_name: "Acme Corp",
      position: "Software Engineer",
      location: "New York",
      work_mode: :onsite,
      work_dimension: :full_time,
      employment_type: :employment_contract,
      experience_level: :junior,
      salary_min: 50000,
      salary_max: 100000,
      description: "Great job opportunity",
      tech_stack: "Ruby, Rails, JS"
    )
  end

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is invalid without company_name" do
      subject.company_name = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without position" do
      subject.position = nil
      expect(subject).to_not be_valid
    end

    it "is invalid without location" do
      subject.location = nil
      expect(subject).to_not be_valid
    end

    it "is invalid if salary_min > salary_max" do
      subject.salary_min = 120000
      subject.salary_max = 100000
      expect(subject).to_not be_valid
      expect(subject.errors[:salary_min]).to include("must be less than or equal to salary_max")
    end
  end
end
