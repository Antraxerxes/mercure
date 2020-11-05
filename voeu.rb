class Voeu
    attr_accessor :nom
    attr_accessor :composante
    attr_accessor :index
    attr_accessor :duree
    attr_accessor :dateDebut

    def initialize ( nom, composante, index, duree, dateDebut)
        @nom        = nom  
        @composante = composante      
        @index      = index    
        @duree      = duree    
        @dateDebut  = dateDebut
    end
end