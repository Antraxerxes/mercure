class CritereAdmission
    attr_accessor :nomAccord
    attr_accessor :critereTOEFL
    attr_accessor :critereIELTS
    attr_accessor :critereAcademique

    # Création de l'accord
    def initialize( ligne )
        @nomAccord = ligne[0].value
        @critereAcademique = ligne[1].value  
        @critereTOEFL = [ ligne[1].value, ligne[2].value, ligne[3].value, ligne[4].value ]  
        @critereIELTS = [ ligne[5].value, ligne[6].value, ligne[7].value, ligne[8].value ] 
    end
end