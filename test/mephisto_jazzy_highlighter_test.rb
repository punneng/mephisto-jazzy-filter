$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../../../../config/environment.rb'))
require 'breakpoint'

class MephistoJazzyHighlighterTest < Test::Unit::TestCase
  def test_should_retrieve_macro
    assert_equal JazzyMacro, FilteredColumn.macros[:jzfilter_macro]
  end

  def test_code_macro_with_language
    html = process_macros '<filter:jzfilter lang="ruby">assert_equal 4, 2 + 2</filter:jzfilter>'    
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"line_numbers\"><pre><span class=\"line-numbers\">  1</span>\n</pre></td><td class=\"code\"><pre class=\"sunburst\">assert_equal <span class=\"Constant\">4</span>, <span class=\"Constant\">2</span> <span class=\"Keyword\">+</span> <span class=\"Constant\">2</span>\n</pre></td></tr></table>"    
    assert_equal expected, html
  end
 
  def test_code_macro_with_language_and_inline_line_numbers
    html = process_macros '<filter:jzfilter lang="ruby" line_numbers="inline">assert_equal 4, 2 + 2</filter:jzfilter>'
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"code\"><pre class=\"sunburst\"><span class=\"line-numbers\">   1 </span> assert_equal <span class=\"Constant\">4</span>, <span class=\"Constant\">2</span> <span class=\"Keyword\">+</span> <span class=\"Constant\">2</span>\n</pre></td></tr></table>"    
    assert_equal expected, html
  end

  def test_code_macro_with_language_and_no_line_numbers
    html = process_macros '<filter:jzfilter lang="ruby" line_numbers="no">assert_equal 4, 2 + 2</filter:jzfilter>'   
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"code\"><pre class=\"sunburst\">assert_equal <span class=\"Constant\">4</span>, <span class=\"Constant\">2</span> <span class=\"Keyword\">+</span> <span class=\"Constant\">2</span>\n</pre></td></tr></table>"    
    assert_equal expected, html
  end

  def test_code_macro_with_language_and_invalid_line_numbers
    html = process_macros '<filter:jzfilter lang="ruby" line_numbers="whatever">assert_equal 4, 2 + 2</filter:jzfilter>'
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"code\"><pre class=\"sunburst\">assert_equal <span class=\"Constant\">4</span>, <span class=\"Constant\">2</span> <span class=\"Keyword\">+</span> <span class=\"Constant\">2</span>\n</pre></td></tr></table>"
    assert_equal expected, html
  end

  def test_code_macro_without_language
    html = process_macros '<filter:jzfilter>assert_equal 4, 2 + 2</filter:jzfilter>'
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"line_numbers\"><pre><span class=\"line-numbers\">  1</span>\n</pre></td><td class=\"code\"><pre class=\"sunburst\">assert_equal 4, 2 + 2\n</pre></td></tr></table>"
    assert_equal expected, html
  end

  def test_code_macro_with_invalid_line_numbers_and_language
    html = process_macros '<filter:jzfilter line_numbers="whatever">assert_equal 4, 2 + 2</filter:jzfilter>'
    expected = "<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"jazzy\"><tr><td class=\"code\"><pre class=\"sunburst\">assert_equal 4, 2 + 2\n</pre></td></tr></table>"
    assert_equal expected, html
  end

  private
    def process_macros(text)
      FilteredColumn::Processor.new(nil, text).filter
    end
end
