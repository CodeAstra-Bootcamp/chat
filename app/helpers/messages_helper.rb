module MessagesHelper
  def load_more_link(threshold = nil)
    link_to "Show More", root_path(format: 'js', threshold: threshold), remote: true, id: "get_messages_link", class: "btn btn-sm"
  end
end
