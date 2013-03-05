# encoding: UTF-8
module Jekyll
  class YearPage < Page
    def initialize(site, base, dir, year)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'year.html')
      self.data['year'] = year.to_s
      self.data['title'] = "Adequately Good - Posts from #{year}"
    end
  end

  class YearPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'year'
        site.posts.map { |post| post.date.year }.uniq.each do |year|
          site.pages << YearPage.new(site, site.source, year.to_s, year)
        end
      end
    end
  end
end