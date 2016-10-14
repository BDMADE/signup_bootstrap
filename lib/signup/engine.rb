module Signup
  class Engine < ::Rails::Engine

    config.generators do |g|
      g.assets false
    end

  end
end