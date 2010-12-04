class UserSession < Authlogic::Session::Base
  # configuration here, see documentation for sub modules of Authlogic::Session
  def to_key
    id ? id : nil
  end
end