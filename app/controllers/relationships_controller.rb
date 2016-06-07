class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    if @result = current_user.following?(@user)
        respond_to do |format|
          format.html { redirect_to @user }
          format.js 
        end
    else
      current_user.follow(@user)
        respond_to do |format|
          format.html { redirect_to @user}
          format.js
      end
    end
  end

  def destroy
    @relationship = Relationship.find_by_id params[:id]
    if @relationship 
      @user = @relationship.followed
      current_user.unfollow(@user)
      respond_to do |format|
      format.html { redirect_to @user }
      format.js
      end
    else
      respond_to do |format|
          format.html { redirect_to @user }
          format.js 
        end
    end
  end
end