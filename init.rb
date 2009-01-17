begin 
  require 'jazzy'
  require 'jazzy_macro'         
rescue
  raise "Can't require, Oniguruma, Textpow or Ultraviolet may be missing. Open README and have a look to check everyone works properly."
end
Jazzy.init   
FilteredColumn.macros[:jzfilter_macro] = JazzyMacro           