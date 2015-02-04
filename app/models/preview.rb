require 'nokogiri'
class Preview < ActiveRecord::Base

  

  def build_html(html,css_input,js_input)

    merged = Nokogiri::HTML(html);
    head   = merged.at_css "html > head";
    body   = merged.at_css "html > body";


    if not head then;
      head = Nokogiri::XML::Node.new "head", merged;
      merged.at_css("html").prepend_child(head);
    end

    # gsap = Nokogiri::XML::Node.new "script", merged;
    # gsap['src'] = 'http://cdnjs.cloudflare.com/ajax/libs/gsap/1.14.2/TweenMax.min.js';
    # head.add_child(gsap);

    jq  = Nokogiri::XML::Node.new "script", merged;
    jq['src'] = 'http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js';
    head.add_child(jq);

    dat = Nokogiri::XML::Node.new "script", merged;
    dat['src'] ="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"
    head.add_child(dat);
    #
    # d3 = Nokogiri::XML::Node.new "script", merged;
    # d3['src'] = 'http://d3js.org/d3.v3.min.js';
    # d3['charset'] = 'utf-8'
    # head.add_child(d3);



    css = Nokogiri::XML::Node.new "style", merged;
    head.add_child(css);
    css.content = css_input;


    js  = Nokogiri::XML::Node.new "script", merged;
    body.add_child(js);
    js.content = js_input;


    self.combined = merged.to_html;
    self.save!
  end


end
