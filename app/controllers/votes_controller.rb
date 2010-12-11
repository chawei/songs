class VotesController < ApplicationController
  before_filter :require_user
  
  def thumbs_up
    voter = User.find(params['voter_id'])
    voteable = params['voteable_class'].constantize.find(params['voteable_id'])
    voter.vote_for(voteable)
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def thumbs_down
    voter = User.find(params['voter_id'])
    voteable = params['voteable_class'].constantize.find(params['voteable_id'])
    voter.vote_against(voteable)
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end