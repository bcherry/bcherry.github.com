# encoding: UTF-8
module Jekyll
  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag.html')
      self.data['tag'] = tag
      self.data['title'] = "Adequately Good - Posts tagged “#{tag}”"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag'
        site.tags.keys.each do |tag|
          site.pages << TagPage.new(site, site.source, File.join('tag', tag), tag)
        end
      end
    end
  end
end