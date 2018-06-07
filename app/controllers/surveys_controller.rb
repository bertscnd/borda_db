class SurveysController < ApplicationController
  before_action :current_user_must_be_survey_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_survey_user
    survey = Survey.find(params[:id])

    unless current_user == survey.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @surveys = current_user.surveys.page(params[:page]).per(10)

    render("surveys/index.html.erb")
  end

  def show
    @survey_response = SurveyResponse.new
    @survey_response_option = SurveyResponseOption.new
    @survey = Survey.find(params[:id])

    render("surveys/show.html.erb")
  end

  def new
    @survey = Survey.new

    render("surveys/new.html.erb")
  end

  def create
    @survey = Survey.new

    @survey.survey_name = params[:survey_name]
    @survey.user_id = params[:user_id]
    @survey.question_text = params[:question_text]

    save_status = @survey.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/surveys/new", "/create_survey"
        redirect_to("/surveys")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey created successfully.")
      end
    else
      render("surveys/new.html.erb")
    end
  end

  def edit
    @survey = Survey.find(params[:id])

    render("surveys/edit.html.erb")
  end

  def update
    @survey = Survey.find(params[:id])

    @survey.survey_name = params[:survey_name]
    @survey.user_id = params[:user_id]
    @survey.question_text = params[:question_text]

    save_status = @survey.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/surveys/#{@survey.id}/edit", "/update_survey"
        redirect_to("/surveys/#{@survey.id}", :notice => "Survey updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Survey updated successfully.")
      end
    else
      render("surveys/edit.html.erb")
    end
  end

  def destroy
    @survey = Survey.find(params[:id])

    @survey.destroy

    if URI(request.referer).path == "/surveys/#{@survey.id}"
      redirect_to("/", :notice => "Survey deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Survey deleted.")
    end
  end
end
