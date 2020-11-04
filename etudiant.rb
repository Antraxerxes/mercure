class Etudiant
    attr_accessor :nom
    attr_accessor :noteTOEFL[4]
    attr_accessor :noteIELTS[4]
    attr_accessor :moyenneAcademique
    attr_accessor :noteTOEFL[4]

    # Création de l'objet eleve
    def initialize( ligne )
        @nom = ligne[0].value
        @moyenneAcademique = ligne[1].value 
        @noteTOEFL = [ ligne[1].value, ligne[2].value, ligne[3].value, ligne[4].value ]
        @noteIELTS = [ ligne[5].value, ligne[6].value, ligne[7].value, ligne[8].value ]
    end
end