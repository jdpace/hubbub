module PostHelper
  
  def link_to_post(post)
    post.external_url.blank? ?
      link_to(h(post.title), post_path(post)) :
      link_to(h(post.title), post.external_url, :target => '_blank')
  end
  
end