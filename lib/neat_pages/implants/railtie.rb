require 'neat_pages/implants/action_controller_implant'

module NeatPages::Implants
  class Railtie < Rails::Railtie
    initializer "neat-pages" do |app|
      ActiveSupport.on_load :action_controller do
        include NeatPages::Implants::ActionControllerImplant
      end

      ActiveSupport.on_load :action_view do
        require 'neat_pages/helpers'
      end

      Mime::Type.register "text/html", :neatpage if not Mime::Type.lookup_by_extension :neatpage
    end
  end
end

dir = File.expand_path(File.dirname(__FILE__))

I18n.load_path << File.join(dir, '../../../config/locales', 'fr.yml')

