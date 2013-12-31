#Interest/Category REST actions
class InterestsController < ApplicationController
  include Roles

  before_action :set_interest, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:edit, :update, :destroy]

  ##GET /interests
  def index
    @interests = Interest.all
  end

  ##GET /interests/1
  def show
  end

  ##GET /interests/new
  def new
    @interest = Interest.new
  end

  ##POST /interests
  def create
    @interest = Interest.new(interest_params)
    if @interest.save
      redirect_to @interest, notice: 'Interest/Category successfully created.'
    else
      render 'new'
    end
  end

  ##GET /interests/1/edit
  def edit
  end

  ##PATCH/PUT /interests/1
  def update
    if @interest.update(interest_params)
      redirect_to @interest, notice: 'Interest/Category successfully updated.'
    else
      render 'edit'
    end
  end

  ##DELETE /interests/1
  def destroy
    @interest.destroy
    redirect_to interests_url,
      notice: 'Interest/Category successfully deleted.'
  end

  private
    ##Use callbacks to share common setup or constraints between actions.
    #retreives the interest by requested parameter
    #IF it is owned by the current NP OR current role is member AND it exists
    def set_interest
      pid = params[:id]
      if Interest.exists?(pid)
        @interest = Interest.find(pid)
      else
        redirect_to interests_path,
          :alert => "Unable to find Interest with ID #{pid}!"
      end
    end
    ##Never trust parameters from the scary internet,
    #only allow the white list through.
    def interest_params
      params.require(:interest).permit(:name)
    end
  #end private
end