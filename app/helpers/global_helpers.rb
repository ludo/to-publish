module Merb
  module GlobalHelpers
    # Creates an html link for a Content
    #
    # The text for the link defaults to the content's title, but can be 
    # customized by passing a text in +name+; HTML options are given in the 
    # +opts+ hash.
    #
    # ==== Parameters
    # obj<Content>:: Content to link to
    # name<String>:: Text to display on page
    # opts<Hash>:: Additional options, passed to +link_to+ helper
    def link_to_content(obj, name=nil, opts={})
      # Is there no name, but is there an options Hash?
      if name.is_a?(Hash)
        opts = name
        name = nil
      end
      
      # TODO Make anchor fully functional
      anchor = "##{opts.delete(:anchor)}" if opts[:anchor]
      
      link_to(name || obj.title, "#{path_to_content(obj)}#{anchor}", opts)
    end
    
    # Little helper for selecting which menu will be active
    #
    # ==== Parameters
    # selected<Symbol>:: Name of the active menu
    #
    # --
    # @api public
    def menu(selected)
      @menu = selected
    end
    
    # Generates an url for a Content.
    #
    # ==== Parameters
    # obj<Content>:: A Content
    #
    # ==== Returns
    # String:: URL to +obj+
    #
    # --
    # @api public
    def path_to_content(obj)
      path = "/"
      path += "#{obj.published_at.strftime('%Y/%m/%d')}/" if obj.respond_to?(:published_at)
      path += obj.slug
      path
    end
    
    # Replace placeholders in content's body with real values
    #
    # This is used for displaying the title and timestamp of an article on
    # dynamic places on a page.
    #
    # ==== Parameters
    # article<Article>:: An article
    #
    # ==== Returns
    # String:: The body with placeholders replaced with their actual values
    #
    # --
    # @api public
    def prepare(content)
      body = content.body
      body.gsub!('<title />', "<h1>#{link_to_content(content)}</h1>")
      
      if content.respond_to?(:published_at)
        body.gsub!('<timestamp />', "<div class='date'>#{content.published_at.strftime("%B #{content.published_at.day.ordinalize}, %Y")}</div>")
        body.gsub!("<summary>", "")
        body.gsub!("</summary>", "")
      end
      
      body
    end

    def render_menu
      menu = ""
      menu_items.sort { |a,b| a[1][:position] <=> b[1][:position] }.each do |item|
        # Set the active menu
        if item[0] == @menu
          item[1][:attrs] ||= {}
          item[1][:attrs][:class] = "#{item[1][:attrs][:class]} active"
        end

        # Create a tag for each item
      	menu += tag "li", item[1][:content], item[1][:attrs]
    	end
    	tag "ul", menu
    end

    # Set the <title> for a page
    #
    # --
    # @api public
    def title(value)
      throw_content(:for_title, "#{h(value)} - ")
    end

    private

      # Collection of menu items
      #
      # ==== Returns
      # Hash:: Hash containing menu items
      #
      # --
      # @api private
      def menu_items
        {
          :articles => {
            :content => link_to("Articles", url(:admin_articles)),
            :position => 1
          },
          :pages => {
            :content => link_to("Pages", url(:admin_pages)),
            :position => 2
          }
        }
      end
  end
end
