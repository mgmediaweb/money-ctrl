module ApplicationHelper
  def showActive(icon, selected)
    'card-active' if icon == selected
  end
end
