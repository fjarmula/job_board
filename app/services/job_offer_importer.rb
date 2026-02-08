class JobOfferImporter
  PASSWORD = "password123"
  def self.import(data)
    company = Company.find_or_create_by!(name: data[:company_name] || "Undefined") do |c|
      c.headquarters = "undefined"
    end
    recruiter = company.recruiters.first_or_create! do |r|
      r.first_name = "Crawler"
      r.last_name  = "Bot"
      r.password   = PASSWORD
      r.email      = "crawler#{company.id}@example.com"
    end
    JobOffer.find_or_initialize_by(source_url: data[:source_url]).tap do |offer|
      offer.assign_attributes(
        position: data[:position] || "Unknown",
        location: data[:location] || "Unknown",
        employment_type: data[:employment_type] || "other",
        work_dimension: data[:work_dimension] || "full_time",
        work_mode: data[:work_mode] || "onsite",
        experience_level: data[:experience_level] || "mid_level",
        recruiter: recruiter
      )
      offer.save!
    end
  end
end
