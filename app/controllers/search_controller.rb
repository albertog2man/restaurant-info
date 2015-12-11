class SearchController < ApplicationController
before_action :clean_params
	def index
		unless @params == {}
			api_call
		end
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
		@response = @search.by("browse",@params)
		@meta = @response['meta']['code']
		@results = @response['response']['groups'][0]['items']
		if @results.length == 50
			do_loop = true
			@params[:offset] = 50
			puts "&&&&&&#{@params}&&&&&&&"
			while do_loop == true
				@response= @search.by("browse",@params)
				puts "-------#{@response['response']['groups'][0]['items'].length}-------"
				@meta = @response['meta']['code']
				new_results = @response['response']['groups'][0]['items']
				@results += new_results

				if new_results.length != 50
					do_loop = false
					puts "++++++++#{@results.length}++++++++"
				else
					@params[:offset] = @params[:offset].to_i + 50
				end
			end
		end
	end

	def clean_params
		@params = params.permit(:ll,:radius,:limit,:categoryId,:format,:offset,clean_params: {})
	end
end