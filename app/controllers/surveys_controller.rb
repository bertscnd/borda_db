class SurveysController < ApplicationController
  
  before_action :authenticate_user!
  
  before_action :current_user_must_be_survey_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_survey_user
    survey = Survey.find(params[:id])

    unless current_user == survey.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.surveys.ransack(params[:q])
    @surveys = @q.result(:distinct => true).includes(:user, :response_options, :survey_responses).page(params[:page]).per(10)

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
        redirect_to("/surveys/#{@survey.id}/edit")
      else
        redirect_back(:fallback_location => "/surveys/#{@survey.id}/edit", :notice => "Survey created successfully.")
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
  
  def show_results
    @survey = Survey.find(params[:id])
    @survey.survey_responses.each do |survey_response|
      survey_response.created_at = survey_response.created_at.change(:sec => 0)
      survey_response.save
    end
    
    
    @survey_results = {}
    @survey.response_options.each_with_index do |option, oindex|
      @survey_results[option.response_text] = {}
      options_count = 0
      @survey.response_options.each_with_index do |optionb, obindex|
        @survey_results[option.response_text][obindex + 1] = 0
        options_count = options_count + 1
      end
      @survey_results[option.response_text]["borda"] = 0
      @survey_results[option.response_text]["dowdall"] = 0.000
      option.survey_responses.each_with_index do |resp, rindex|
        @survey_results[option.response_text][resp.response_rank] = @survey_results[option.response_text][resp.response_rank] + 1
        @survey_results[option.response_text]["borda"] = @survey_results[option.response_text]["borda"] + (options_count - resp.response_rank)
        @survey_results[option.response_text]["dowdall"] = @survey_results[option.response_text]["dowdall"] + (1.000/resp.response_rank)
      end
    end
    render("surveys/results.html.erb")
  end
  
end
