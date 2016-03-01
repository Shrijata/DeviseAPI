class Api::EventsController < ApplicationController

  before_action :authenticate_user!
  respond_to :json

  def index
    @events = Event.all
    render json: @events
  end

	def create
		@events=Event.create(event_params)
		render json: @events
	end
	
	def update
		@events=Event.find(params[:id]).update(event_params)
		render json: @events
	end

	def show
		@events=Event.all
		render json: @events
	end

	private
	def event_params
  	params.permit(:id,:name,:occured_at)
	end
end
