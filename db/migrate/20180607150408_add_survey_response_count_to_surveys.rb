class AddSurveyResponseCountToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :survey_responses_count, :integer
  end
end
