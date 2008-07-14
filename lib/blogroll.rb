require 'yaml'
module BlogRoll
  BLOGYAML = File.join(File.dirname(__FILE__), 'blogroll.yml')
  BLOGROLL = YAML::load_file(BLOGYAML)
  
  def self.method_missing(meth, *args, &blk)
    BLOGROLL.send(meth, *args, &blk) rescue super
  end
  
  def self.to_html
    ret =  ""
    ret << "<ul class='no-bullet'>\n"
    sort_by{|full_name, info| full_name.split.last}.each do |full_name, info|
      ret << "  <li><a href='#{info['url']}' title='#{info['title']}'>#{full_name}</a></li>\n"
    end
    ret << "</ul>\n"
    ret
  end
  
end