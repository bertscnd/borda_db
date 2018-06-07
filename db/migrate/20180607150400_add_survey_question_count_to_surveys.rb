class AddSurveyQuestionCountToSurveys < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :survey_questions_count, :integer
  end
end
