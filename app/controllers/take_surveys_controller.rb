class TakeSurveysController < ApplicationController

  def show
    @survey_response = SurveyResponse.new
    @survey_response_option = SurveyResponseOption.new
    @survey = Survey.find(params[:id])

    render("surveys/show.html.erb")
  end

  def submit
    
    Survey.find(params[:survey_id]).response_options.each_with_index do |option, index|
      @survey_response = SurveyResponse.new
      
      @survey_response.survey_id = params[:survey_id]
      @survey_response.submitter_name = params[:submitter_name]
      
      @survey_response.response_id = option.id
      @survey_response.response_rank = params.fetch("response_" + index.to_s)
  
      @survey_response.save
    
    end
    
    if current_user == nil
      render("surveys/thanks.html.erb")
    else
      redirect_to("/surveys")
    end
    
  end
  
end
