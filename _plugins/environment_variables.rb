module Jekyll
 
  class EnvironmentVariablesGenerator < Generator
 
    def generate(site)
      site.config['url'] = ENV['SITE_URL'] || 'http://www.jamiekurtz.com'
    end
 
  end
 
end
