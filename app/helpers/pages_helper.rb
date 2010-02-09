module PagesHelper
  
  def on_page?(permalink)
    controller.controller_name == 'pages' &&
      controller.action_name == 'show' &&
      @page.url == permalink.to_s
  end
  
end