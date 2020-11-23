class Voeu
    attr_accessor :nom
    attr_accessor :composante
    attr_accessor :index
    attr_accessor :dateFin
    attr_accessor :dateDebut
    attr_accessor :statut
    attr_accessor :failedMoy
    attr_accessor :failedTOEFL
    attr_accessor :failedIELTS

    def initialize ( nom, composante, index, dateDebut, dateFin)
        @nom         = nom  
        @composante  = composante      
        @index       = index  
        @dateDebut   = dateDebut  
        @dateFin     = dateFin    
        @statut      = false
        @failedMoy   = false
        @failedTOEFL = false
        @failedIELTS = false
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