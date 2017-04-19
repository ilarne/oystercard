class Station #understands the details of your journey
attr_reader :name, :zone
def initialize(name,zone)
    @name = name
    @zone = zone
  end
end
