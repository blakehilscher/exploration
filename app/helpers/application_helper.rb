module ApplicationHelper

  def active_page?(*args)
    options = args.extract_options!
    options.assert_valid_keys(:controller, :action)
    if options[:action] && options[:controller]
      (options[:action] == params[:action] && options[:controller] == controller.controller_name) ? 'active' : ''
    elsif options[:action]
      (options[:action] == params[:action]) ? 'active' : ''    
    elsif options[:controller]
      (options[:controller] == controller.controller_name) ? 'active' : ''
    end
  end

  def date_range(start, finish)
    s = Time.parse(start)
    f = Time.parse(finish)
    r = []
    while s < f
      s = s.tomorrow
      r << s.strftime('%Y-%m-%d')
    end
    Rails.logger.debug r
    return r    
  end
  
end
