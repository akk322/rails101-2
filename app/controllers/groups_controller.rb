class GroupsController < ApplicationController
  before_action :authenticate_user!,only:[:new,:create,:edit, :update, :destroy]
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
  def index
    @groups = Group.all
  end

 def show
   @group = Group.find(params[:id])
 end

 def edit
 end

  def new
   @group = Group.new
 end

 def create
   @group = Group.new(group_params)
   @group.user =current_user

   if @group.save
     redirect_to groups_path
   else
     render :new
   end
 end

def update

  if @group.update(group_params)
      redirect_to groups_path, notice: "Update Success"
    else
      render :edit
    end
end

def destroy
  #@group= Group.find(params[:id])

  #if current_user != @group.user #如果当前用户不等于组成员，就重定向到root_path去，并且警告“没资格”
      #redirect_to root_path, alert: "You have no permission."
  #end

  @group.destroy
  redirect_to groups_path, alert: "Group deleted"#如果组被删掉了，重定向到group_path去，并且警告组被删除了
end

 private

 def find_group_and_check_permission
     @group = Group.find(params[:id])

     if current_user != @group.user
       redirect_to root_path, alert: "You have no permission."
     end
   end

 def group_params
   params.require(:group).permit(:title, :description)
 end

end
