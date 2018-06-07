class AddSurveyCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :surveys_count, :integer
  end
end
