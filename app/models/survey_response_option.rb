class SurveyResponseOption < ApplicationRecord
  # Direct associations

  belongs_to :survey,
             :counter_cache => :survey_questions_count

  # Indirect associations

  # Validations

end
