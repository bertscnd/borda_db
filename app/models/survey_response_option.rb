class SurveyResponseOption < ApplicationRecord
  # Direct associations

  has_many   :survey_responses,
             :foreign_key => "response_id",
             :dependent => :destroy

  belongs_to :survey,
             :counter_cache => :survey_questions_count

  # Indirect associations

  # Validations

end
