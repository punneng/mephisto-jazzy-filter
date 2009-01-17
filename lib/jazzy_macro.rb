# MephistoJazzyFilter   
require 'jazzy_uv'     
class JazzyMacro < FilteredColumn::Macros::Base
  class << self
    include ActionView::Helpers::TagHelper
    
    def filter(attributes, inner_text='', text='')                                               
      attributes[:render] ||= "xhtml"
      attributes[:line_numbers] ||= attributes[:line_number] ||= "table"
      attributes[:template] ||= "sunburst"    
      attributes[:lang] ||= "plain_text"          
      block = Uv.jazzy_parse( inner_text.strip, attributes[:render], attributes[:lang], attributes[:line_numbers], attributes[:template])  
      if attributes[:line_numbers] == "table"
        pre_line_numbers = content_tag(:pre, block[:line_numbers])
        td_block = content_tag(:td, pre_line_numbers, :class => "line_numbers") << content_tag(:td, block[:code], :class => "code")
        tr_block = content_tag(:tr, td_block)     
      else
        td_block = content_tag(:td, block, :class => "code")
        tr_block = content_tag(:tr, td_block)
      end      
      content_tag(:table, tr_block, :border => "0", :cellspacing => "0", :cellpadding => "0", :class => "jazzy")
    end
  end
end