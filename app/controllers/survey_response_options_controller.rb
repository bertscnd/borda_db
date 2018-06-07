class SurveyResponseOptionsController < ApplicationController
  def index
    @survey_response_options = SurveyResponseOption.all

    render("survey_response_options/index.html.erb")
  end

  def show
    @survey_response = SurveyResponse.new
    @survey_response_option = SurveyResponseOption.find(params[:id])

    render("survey_response_options/show.html.erb")
  end

  def new
    @survey_response_option = SurveyResponseOption.new

    render("survey_response_options/new.html.erb")
  end

  def create
    @survey_response_option = SurveyResponseOption.new

    @survey_response_option.response_text = params[:response_text]
    @survey_response_option.survey_id = params[:survey_id]

    save_status = @survey_response_option.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/survey_response_options/new", "/create_survey_response_option"
        redirect_to("/survey_response_options")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey response option created successfully.")
      end
    else
      render("survey_response_options/new.html.erb")
    end
  end

  def edit
    @survey_response_option = SurveyResponseOption.find(params[:id])

    render("survey_response_options/edit.html.erb")
  end

  def update
    @survey_response_option = SurveyResponseOption.find(params[:id])

    @survey_response_option.response_text = params[:response_text]
    @survey_response_option.survey_id = params[:survey_id]

    save_status = @survey_response_option.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/survey_response_options/#{@survey_response_option.id}/edit", "/update_survey_response_option"
        redirect_to("/survey_response_options/#{@survey_response_option.id}", :notice => "Survey response option updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey response option updated successfully.")
      end
    else
      render("survey_response_options/edit.html.erb")
    end
  end

  def destroy
    @survey_response_option = SurveyResponseOption.find(params[:id])

    @survey_response_option.destroy

    if URI(request.referer).path == "/survey_response_options/#{@survey_response_option.id}"
      redirect_to("/", :notice => "Survey response option deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Survey response option deleted.")
    end
  end
end
