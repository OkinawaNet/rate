module ApplicationHelper
  def current_nav_link(path)
    current_page?(path) ? "active" : nil
  end
end
