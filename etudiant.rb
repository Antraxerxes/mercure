class Etudiant
    attr_accessor :nomEtudiant
    attr_accessor :noteTOEFL[4]
    attr_accessor :noteIELTS[4]
    attr_accessor :moyenneAcademique

    # Création de l'accord
    def initialize( ligne )
        @nomEtudiant = ligne[0].value
        @noteTOEFL = [ ligne[1].value, ligne[2].value, ligne[3].value, ligne[4].value ]  
        @noteIELTS = [ ligne[5].value, ligne[6].value, ligne[7].value, ligne[8].value ] 
        @moyenneAcademique = ligne[9]  
    end
end