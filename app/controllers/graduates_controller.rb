#Graduate user REST actions
class GraduatesController < ApplicationController
  include Roles

  before_action :set_graduate, only: [:show, :edit, :update, :destroy]
  before_action :set_interests, only: [:index, :edit, :update]
  before_filter :is_nonprofit, only: [:index, :show]
  before_filter :is_graduate, only: [:edit, :update]

  #graduates listing
  ### GET /graduates
  def index
    ints = ints
    if ints.present?
      @graduates = Graduate.includes(:user)
        .joins(:interesteds => :interest)
        .where(:interests => {:id => ints})
        .group('graduates.id')
        .order('graduates.first_name')
      @selected_interests = ints
    else
      @graduates = Graduate.includes(:user)
      @selected_interests = []
    end
    back_search_w_params(graduates_path)
  end

  #graduate profile
  ### GET /graduates/1
  def show
  end

  #profile
  def edit
    @selected_interests = @graduate.interest_ids.to_a.map!(&:to_s)
  end

  #profile handler
  ### PATCH/PUT /graduates/1
  def update
    params[:graduate][:interest_ids] ||= [] #if no boxes are checked
    if @graduate.update(graduate_params)
      redirect_to edit_graduate_path(@graduate),
        notice: 'Profile successfully updated.'
    else
      @selected_interests = params[:graduate][:interest_ids] ||= []
      render 'edit'
    end
  end

  private
    ###Use callbacks to share common setup or constraints between actions.
    #retreives the graduate by requested parameter
    #IF it is owned by the current Grad AND it exists
    def set_graduate
      pid = params[:id]
      if Graduate.exists?(pid)
        @graduate = Graduate.find_by_id(pid)
        if current_role(Graduate)
          if @graduate.id != current_user.role_id || !@graduate
            redirect_to logout_path
          end
        end
      else
        redirect_to logout_path
      end
    end
    def set_interests
      @interests = Interest.all.order('name ASC')
    end
    ###Never trust parameters from the scary internet,
    #only allow the white list through.
    def graduate_params
      params.require(:graduate).permit(
        :first_name,
        :last_name,
        :address_1,
        :address_2,
        :city,
        :state,
        :zip_code,
        :phone,
        :volunteer_experience,
        :work_experience,
        :skip,
        :interest_ids => []
      )
    end
  #end private
end