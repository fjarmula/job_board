FactoryBot.define do
  factory :job_offer do
    company_name { "Acme Corp" }
    position { "Software Engineer" }
    location { "New York" }
    work_mode { :onsite }
    work_dimension { :full_time }
    employment_type { :employment_contract }
    experience_level { :junior }
    salary_min { 50000 }
    salary_max { 100000 }
    description { "Great job opportunity" }
    tech_stack { "Ruby, Rails, JS" }
  end
end
