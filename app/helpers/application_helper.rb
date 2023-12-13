# app/helpers/application_helper.rb
module ApplicationHelper
    def set_global_title(title)
      @global_title = title
    end
  
    def get_global_title
      @global_title || 'Default Title'
    end
  end
  