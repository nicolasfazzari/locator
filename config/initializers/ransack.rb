Ransack.configure do |config|
  config.add_predicate 'has_any_term',
  arel_predicate: 'eq_any',
  formatter: proc { |v| v.upcase.delete(' ').split(',').flatten.compact.map{|t| "#{t}"} },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
  config.add_predicate 'has_every_term',
  arel_predicate: 'matches_all',
  formatter: proc { |v| v.upcase.split(',').flatten.compact.map{|t| "%#{t}%"} },
  validator: proc { |v| v.present? },
  type: :string
end

Ransack.configure do |config|
    config.add_predicate 'eq_any_or_nil',
                        # What non-compound ARel predicate will it use? (eq, matches, etc)
                        :arel_predicate => 'eq_any',
                        # Format incoming values as you see fit. (Default: Don't do formatting)
                        :formatter => proc {|val|
                            "nil" == val ? nil : val
                        },
                        # Validate a value. An "invalid" value won't be used in a search.
                        # Below is default.
                         # :validator => proc {|v| v.present?},
                        :validator => proc {|val|
                            val.present? && !val.blank?
                        },
                        # Should compounds be created? Will use the compound (any/all) version
                        # of the arel_predicate to create a corresponding any/all version of
                        # your predicate. (Default: true)
                        :compounds => false,
                        # Lets us force per item array handling in the valiator and formatter
                        :wants_array => true
                        # Force a specific column type for type-casting of supplied values.
                        # (Default: use type from DB column)
                        # :type => :string
end





