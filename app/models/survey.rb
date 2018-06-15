class Survey < ApplicationRecord
  # Direct associations

  has_many   :survey_responses,
             :dependent => :destroy

  has_many   :response_options,
             :class_name => "SurveyResponseOption",
             :dependent => :destroy

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
