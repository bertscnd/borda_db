class AddSurveyResponseCountToSurveyResponseOptions < ActiveRecord::Migration[5.0]
  def change
    add_column :survey_response_options, :survey_responses_count, :integer
  end
end
