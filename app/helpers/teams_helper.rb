module TeamsHelper
    def inlist(lists)
      colors = %w[bg-red-50 bg-blue-50 bg-green-50 bg-yellow-50 bg-purple-50] # Define different colors
      lists.map.with_index do |list, index|
        color_class = colors[index % colors.size] # Cycle through colors based on index
        content_tag(:span, list, class: "inline-flex items-center rounded-md mx-1 px-2 py-1 text-xs font-medium text-black ring-1 ring-inset #{color_class}")
      end.join.html_safe
    end
  end
  