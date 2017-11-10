class TablesController < ApplicationController

  def index
    @guests = Guest.where(admin_id: current_admin[:id])
    @admin = Admin.find(current_admin[:id])


    #creating table for guest
    @guest_list = []
    @tables_list = []
    @admin.num_tables.times do
      @tables_list << []
    end
    @guests.each do |g|
      if g.table_num
        @tables_list[g.table_num-1] << g.name
      end
        #checking for RSVP
      if g.RSVP != false
        @guest_list << g
      else
        g.table_num = nil
        @guest_list.delete g
        g.save
      end
    end
  end

  def new
    @guest = Guest.new
  end

  def edit
    @guest = Guest.find(params[:table_num])
  end

  def update
    @guest = Guest.find(params[:table_guest_id])
    @guest.update(post_params)
    redirect_to tables_path
  end

  private
  def post_params
  params.require(:guest).permit(:table_num)
  end
end
