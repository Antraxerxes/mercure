require_relative 'voeu'

class Etudiant
    attr_accessor :nom
    attr_accessor :noteTOEFL
    attr_accessor :noteIELTS
    attr_accessor :moyenneAcademique
    attr_accessor :voeux

    # Création de l'objet eleve
    def initialize( ligne )
        @nom = ligne[0].value
        @moyenneAcademique = ligne[1].value 
        @noteTOEFL = [ ligne[1].value, ligne[2].value, ligne[3].value, ligne[4].value ]
        @noteIELTS = [ ligne[5].value, ligne[6].value, ligne[7].value, ligne[8].value ]
        @voeux = Array.new
    end

    def ajoutVoeu( voeu )
        @voeux << Voeu.new( voeu[1].value, voeu[2].value, voeu[3].value, voeu[4].value, voeu[5].value )
    end
end