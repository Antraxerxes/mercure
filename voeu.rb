class Voeu
    attr_accessor :nom
    attr_accessor :composante
    attr_accessor :index
    attr_accessor :duree
    attr_accessor :dateDebut
    attr_accessor :statut

    def initialize ( nom, composante, index, duree, dateDebut)
        @nom        = nom  
        @composante = composante      
        @index      = index    
        @duree      = duree    
        @dateDebut  = dateDebut
        @statut     = false
    end

    def getcritere( listcritere )
        critereSortie = 0
        listcritere.each do |critere|
            if @nom.eql?(critere.nomAccord)
                critereSortie = critere
            end
        end
        if critereSortie!= 0
            critereSortie
        else
            puts "pas de critere pour le voeu #{nom}"
        end
    end
    
end