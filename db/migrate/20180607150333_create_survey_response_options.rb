class CreateSurveyResponseOptions < ActiveRecord::Migration
  def change
    create_table :survey_response_options do |t|
      t.string :response_text
      t.integer :survey_id

      t.timestamps

    end
  end
end
