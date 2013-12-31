#Member user REST actions
class MembersController < ApplicationController
  include Roles

  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :set_interests, only: [:index, :edit, :update]
  before_filter :is_employer, only: [:index, :show]
  before_filter :is_member, only: [:edit, :update]

  #members listing
  ### GET /members
  def index
    ints = ints
    if ints.present?
      @members = Member.includes(:user)
        .joins(:interesteds => :interest)
        .where(:interests => {:id => ints})
        .group('members.id')
        .order('members.first_name')
      @selected_interests = ints
    else
      @members = Member.includes(:user)
      @selected_interests = []
    end
    back_search_w_params(members_path)
  end

  #member profile
  ### GET /members/1
  def show
  end

  #profile
  def edit
    @selected_interests = @member.interest_ids.to_a.map!(&:to_s)
  end

  #profile handler
  ### PATCH/PUT /members/1
  def update
    params[:member][:interest_ids] ||= [] #if no boxes are checked
    if @member.update(member_params)
      redirect_to edit_member_path(@member),
        notice: 'Profile successfully updated.'
    else
      @selected_interests = params[:member][:interest_ids] ||= []
      render 'edit'
    end
  end

  private
    ###Use callbacks to share common setup or constraints between actions.
    #retreives the member by requested parameter
    #IF it is owned by the current Grad AND it exists
    def set_member
      pid = params[:id]
      if Member.exists?(pid)
        @member = Member.find_by_id(pid)
        if current_role(Member)
          if @member.id != current_user.role_id || !@member
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
    def member_params
      params.require(:member).permit(
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