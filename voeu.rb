class Voeu
    attr_accessor :nom
    attr_accessor :composante
    attr_accessor :index
    attr_accessor :duree
    attr_accessor :dateDebut
    attr_accessor :statut
    attr_accessor :failedMoy
    attr_accessor :failedTOEFL
    attr_accessor :failedIELTS
    attr_accessor :failedCritere
    attr_accessor :failedrang

    def initialize ( nom, composante, index, dateDebut, duree)
        @nom           = nom  
        @composante    = composante      
        @index         = index  
        @dateDebut     = dateDebut  
        @duree         = duree    
        @statut        = false
        @failedMoy     = false
        @failedTOEFL   = false
        @failedIELTS   = false
        @failedCritere = false
        @failedrang    = false
    end

    def getcritere( listcritere )
        critereSortie = 0
        listcritere.each do |critere|
            if @nom.strip.eql?(critere.nomAccord.strip)
                critereSortie = critere
            end
        end
        if critereSortie!= 0
            critereSortie
        else
            false
        end
    end
end