class Survey < ApplicationRecord
  # Direct associations

  has_many   :survey_questions,
             :class_name => "SurveyResponseOption",
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
