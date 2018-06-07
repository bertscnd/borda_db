class SurveyResponse < ApplicationRecord
  # Direct associations

  belongs_to :survey,
             :counter_cache => true

  # Indirect associations

  # Validations

end
