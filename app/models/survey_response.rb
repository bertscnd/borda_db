class SurveyResponse < ApplicationRecord
  # Direct associations

  belongs_to :response_option,
             :class_name => "SurveyResponseOption",
             :foreign_key => "response_id",
             :counter_cache => true

  belongs_to :survey,
             :counter_cache => true

  # Indirect associations

  # Validations

end
