class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.integer :survey_id
      t.integer :response_id
      t.integer :response_rank
      t.string :submitter_name

      t.timestamps

    end
  end
end
