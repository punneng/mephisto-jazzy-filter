require 'uv'  

module Uv
  def Uv.jazzy_parse text, output = "xhtml", syntax_name = nil, line_numbers = false, render_style = "classic", headers = false
     init_syntaxes unless @syntaxes
     renderer = File.join( Jazzy.uv_path, '..',"render", output,"#{render_style}.render")
     raise( ArgumentError, "Output for #{output} is not yet implemented" ) unless File.exists?(renderer)
     css_class = render_style
     render_options = YAML.load( File.open(  renderer ) )
     render_processor = JazzyRenderProcessor.new( render_options, line_numbers, headers )
     @syntaxes[syntax_name].parse( text,  render_processor )  
     if line_numbers == "table"  
       return {:code => render_processor.string, :line_numbers => render_processor.line_number_string}
     else
       render_processor.string        
     end
  end 
    
  class JazzyRenderProcessor < RenderProcessor 
    attr_reader :line_number_string
    def initialize *args
      super *args        
      @line_number_string = ""
    end       
    
    def new_line line
       if @line
          print escape(@line[@position..-1].gsub(/\n|\r/, ''))
          close_line
          print @render_options["line"]["end"]
          print "\n" 
       end
       @position = 0
       @line_number += 1
       @line = line
       print @render_options["line"]["begin"]            
       if @line_numbers == "table"   
         @line_number_string << @render_options["line-numbers"]["begin"] << "#{@line_number.to_s.rjust(3) }" << @render_options["line-numbers"]["end"]  << "\n" 
       elsif @line_numbers == "inline"
         print @render_options["line-numbers"]["begin"] 
         print @line_number.to_s.rjust(4).ljust(5)
         print @render_options["line-numbers"]["end"] 
         print " "    
       end
       open_line
    end
  end
end