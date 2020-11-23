class CritereAdmission
    attr_accessor :nomAccord
    attr_accessor :critereTOEFL
    attr_accessor :critereIELTS
    attr_accessor :critereAcademique

    # Création de l'accord
    def initialize( ligne )
        @nomAccord = ligne[1].value
        @critereAcademique = ligne[2].value  
        @critereTOEFL = [ ligne[3].value, ligne[4].value, ligne[5].value, ligne[6].value, ligne[7].value ]  
        @critereIELTS = [ ligne[9].value, ligne[10].value, ligne[11].value, ligne[12].value, ligne[13].value ] 
    end
end