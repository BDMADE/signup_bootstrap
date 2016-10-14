module Signup
  class Engine < ::Rails::Engine
    isolate_namespace Signup

    config.generators do |g|
      g.assets false
    end

  end
end
