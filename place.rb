class Place
    attr_accessor :nom
    attr_accessor :nbplace

    def initialize ( ligne )
        @nom     = ligne[1].value  
        @nbplace = ligne[2].value        
    end   
end