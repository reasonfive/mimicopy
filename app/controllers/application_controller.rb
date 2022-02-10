class ApplicationController < ActionController::Base

    helper_method :notes
    def notes
        Note.order(:id)
    end
end
