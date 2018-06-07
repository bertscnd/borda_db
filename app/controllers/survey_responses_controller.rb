class SurveyResponsesController < ApplicationController
  def index
    @survey_responses = SurveyResponse.all

    render("survey_responses/index.html.erb")
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
