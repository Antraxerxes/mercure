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

    def checkAdmission( listcritere )
        voeux.each do |voeu|
            critere = voeu.getcritere( listcritere )
            if critere != false
                voeu.statut = true
                #check moyenne academique
                if @moyenneAcademique < critere.critereAcademique && critere.critereAcademique != 0
                    voeu.statut = false
                end
                #Check note TOEFL
                if @noteTOEFL[0] != 0 && @noteTOEFL[0] < critere.critereTOEFL[0] && @noteTOEFL[1] < critere.critereTOEFL[1] && @noteTOEFL[2] < critere.critereTOEFL[2] && @noteTOEFL[3] < critere.critereTOEFL[3]
                    voeu.statut = false 
                end
                #check note IELTS
                if @noteIELTS[0] != 0 && @noteIELTS[0] < critere.critereIELTS[0] && @noteIELTS[1] < critere.critereIELTS[1] && @noteIELTS[2] < critere.critereIELTS[2] && @noteIELTS[3] < critere.critereIELTS[3]
                    voeu.statut = false    
                end
            end
        end
    end
end