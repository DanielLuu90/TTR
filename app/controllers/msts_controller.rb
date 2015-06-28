class MstsController < ApplicationController
  def index
  	if params[:keyword]
			@list = Mst.where('ten like ?', params[:keyword])
		else
			@list = Mst.all
		end

		@list = @list.paginate(page: params[:page], per_page: 50).order(ten: :asc)
  end
end
