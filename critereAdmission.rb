class CritereAdmission
    attr_accessor :nomAccord
    attr_accessor :critereTOEFL
    attr_accessor :critereIELTS
    attr_accessor :critereAcademique

    # Création de l'accord
    def initialize( ligne )
        @nomAccord = ligne[1].value
        @critereAcademique = ligne[2].value  
        @critereTOEFL = ligne[3].value
        @critereIELTS = ligne[4].value
    end
end