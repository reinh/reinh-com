def textile_fig(tag, atts, cite, content)
  span_class = "img "
  if atts =~ /class="([^\"]+)"/
    span_class += $1
  end
  (figure_number, img_url) = content.split("|").map { |w| w.strip }
  figure_name = "Figure #{figure_number}"
  figure_id = "figure-#{figure_number}".tr(".", "-")

  %{
  <div class="#{span_class}" id="#{figure_id}">
    <a class="fig" href="http://reinh.com/images/#{img_url}">
      <img src="http://reinh.com/images/thumbs/#{img_url}" alt="#{figure_name}" />
    </a>
    <p>#{figure_name}</p>
  </div>
  }
end

def textile_code( tag, atts, cite, content )
  "<pre><code#{ atts }>#{ content }</code></pre>" 
end

if __FILE__ == $PROGRAM_NAME
  require 'rubygems'
  require 'RedCloth'
  puts RedCloth.new(DATA.read).to_html
end

__END__

fig(foo). 1.1 | Bar.jpg
