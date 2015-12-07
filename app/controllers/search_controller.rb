class SearchController < ApplicationController
before_action :clean_params
	def index
		api_call
	end
	def csv
		respond_to do |format|
		   	format.csv do
			    headers['Content-Disposition'] = "attachment; filename=\"Restaruant-List.csv\""
			    headers['Content-Type'] ||= 'text/csv'
			end
		end
	end
	def api_call
		@search = Search.new
		@results = @search.by("browse",@params)
	end
	def clean_params
		@params = params.permit(:location,:radius,:types,:keyword,:name,:format,clean_params: {})
	end
end