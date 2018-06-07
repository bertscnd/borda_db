class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :survey_name
      t.integer :user_id
      t.string :question_text

      t.timestamps

    end
  end
end
