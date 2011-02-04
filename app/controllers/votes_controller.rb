class VotesController < ApplicationController
  before_filter :require_user
  
  def thumbs_up
    voter = User.find(params['voter_id'])
    @voteable = params['voteable_class'].constantize.find(params['voteable_id'])
    if voter.voted_for?(@voteable)
      voter.clear_votes(@voteable)
    else
      voter.vote_exclusively_for(@voteable)
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
  
  def thumbs_down
    voter = User.find(params['voter_id'])
    @voteable = params['voteable_class'].constantize.find(params['voteable_id'])
    if voter.voted_against?(@voteable)
      voter.clear_votes(@voteable)
    else
      voter.vote_exclusively_against(@voteable)
    end
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end