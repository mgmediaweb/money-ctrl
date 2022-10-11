module ApplicationHelper
  def showActive(icon, selected)
    'card-active' if icon == selected
  end

  def show_bg_image(image)
    image || image_url('empty_user.png')
  end
  
  def title_text(text)
    text.downcase.capitalize
  end  
end
