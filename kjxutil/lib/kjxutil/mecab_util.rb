module Kjxutil
  module MecabUtil
    def self.get_surface(node)
      surface = node.surface
      surface.force_encoding("utf-8")
      return surface
    end
    
    def self.get_feature(node)
      feature = node.feature
      feature.force_encoding("utf-8")
      return feature
    end
    
    def self.get_feature_record(node)
      feature = self.get_feature(node)
      return CSV.parse_line(feature)
    end
  end
end