class FollowsController < ApplicationController
  before_filter :require_user
  
  def toggle_follow
    follower = User.find(params['follower_id'])
    @followable = params['followable_class'].constantize.find(params['followable_id'])
    if follower.following?(@followable)
      follower.stop_following(@followable)
    else
      follower.follow(@followable)
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end

end