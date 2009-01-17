module Jazzy
  @@uv_path = ""
  mattr_reader :uv_path 
  def self.init   
    @@uv_path = $:.select { |path| path if /ultraviolet.*lib/ =~ path }   
  end          
end