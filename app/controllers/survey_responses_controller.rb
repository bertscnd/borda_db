class SurveyResponsesController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @q = SurveyResponse.ransack(params[:q])
    @survey_responses = @q.result(:distinct => true).includes(:survey, :response_option).page(params[:page]).per(10)

    render("survey_responses/index.html.erb")
  end
  
  def surveyindex
    @survey = Survey.find(params[:id])
    @survey_responses = @survey.survey_responses
    @survey_responses.each do |survey_response|
      survey_response.created_at = survey_response.created_at.change(:sec => 0)
      survey_response.save
    end

    render("survey_responses/one_survey.html.erb")
  end

  def show
    @survey_response = SurveyResponse.find(params[:id])

    render("survey_responses/show.html.erb")
  end

  def new
    @survey_response = SurveyResponse.new

    render("survey_responses/new.html.erb")
  end

  def create
    @survey_response = SurveyResponse.new
    @survey_response.created_at.change(:sec => 0)
    @survey_response.survey_id = params[:survey_id]
    @survey_response.response_id = params[:response_id]
    @survey_response.response_rank = params[:response_rank]
    @survey_response.submitter_name = params[:submitter_name]

    save_status = @survey_response.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/survey_responses/new", "/create_survey_response"
        redirect_to("/survey_responses")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey response created successfully.")
      end
    else
      render("survey_responses/new.html.erb")
    end
  end
  
  def submit
    
    Survey.find(params[:survey_id]).response_options.each_with_index do |option, index|
      @survey_response = SurveyResponse.new
      @survey_response.created_at.change(:sec => 0)
      @survey_response.survey_id = params[:survey_id]
      @survey_response.submitter_name = params[:submitter_name]
      
      @survey_response.response_id = option.id
      @survey_response.response_rank = params.fetch("response_" + index.to_s)
  
      @survey_response.save
    
    end

    redirect_to("/surveys")
    
  end

  def edit
    @survey_response = SurveyResponse.find(params[:id])

    render("survey_responses/edit.html.erb")
  end

  def update
    @survey_response = SurveyResponse.find(params[:id])

    @survey_response.survey_id = params[:survey_id]
    @survey_response.response_id = params[:response_id]
    @survey_response.response_rank = params[:response_rank]
    @survey_response.submitter_name = params[:submitter_name]

    save_status = @survey_response.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/survey_responses/#{@survey_response.id}/edit", "/update_survey_response"
        redirect_to("/survey_responses/#{@survey_response.id}", :notice => "Survey response updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey response updated successfully.")
      end
    else
      render("survey_responses/edit.html.erb")
    end
  end

  def destroy
    @survey_response = SurveyResponse.find(params[:id])

    @survey_response.destroy

    if URI(request.referer).path == "/survey_responses/#{@survey_response.id}"
      redirect_to("/", :notice => "Survey response deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Survey response deleted.")
    end
  end
end