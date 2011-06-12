require "application_responders"
class ApplicationController < ActionController::Base
  protect_from_forgery

    self.responder = ApplicationResponder
  respond_to :html
end
