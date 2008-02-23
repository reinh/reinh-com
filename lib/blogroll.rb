require 'yaml'
module BlogRoll
  BLOGYAML = File.join(File.dirname(__FILE__), 'blogroll.yml')
  BLOGROLL = YAML::load_file(BLOGYAML)
  
  def self.method_missing(meth, *args, &blk)
    return BLOGROLL.send(meth, *args, &blk) if BLOGROLL.respond_to?(meth)
    super
  end
  
  def self.to_html
    ret =  ""
    ret << "<ul class='no-bullet'>\n"
    sort_by{|k,v| k.split.last}.each do |blogger, info|
      ret << "  <li><a href='#{info['url']}' title='#{info['title']}'>#{blogger}</a></li>\n"
    end
    ret << "</ul>\n"
    ret
  end
  
end