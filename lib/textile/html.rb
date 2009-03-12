module RedCloth::Formatters::HTML
  def image(opts)
    opts.delete(:align)
    opts[:alt] = opts[:title]
    img = "<img src=\"#{escape_attribute opts[:src]}\"#{pba(opts)} alt=\"#{escape_attribute opts[:alt].to_s}\">"
    img = "<a href=\"#{escape_attribute opts[:href]}\">#{img}</a>" if opts[:href]
    img
  end

  def br(opts)
    if hard_breaks == false
      "\n"
    else
      "<br>\n"
    end
  end
end

