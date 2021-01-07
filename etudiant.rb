require_relative 'voeu'

class Etudiant
    attr_accessor :nom
    attr_accessor :noteTOEFL
    attr_accessor :noteIELTS
    attr_accessor :moyenneAcademique
    attr_accessor :voeux
    attr_accessor :composante
    attr_accessor :evalComposante
    attr_accessor :rang

    # Création de l'objet eleve
    def initialize( ligne )
        @nom = ligne[0].value
        @composante = ligne[1].value  
        @noteTOEFL = ligne[4].value
        @noteIELTS = ligne[5].value
        @moyenneAcademique = ligne[6].value
        @evalComposante = ligne[7].value
        @voeux = Array.new
        @rang = 0
    end

    def ajoutVoeu( voeu )
        @voeux << Voeu.new( voeu[3].value, voeu[0].value, voeu[2].value, voeu[6].value, voeu[5].value )
    end

    def checkAdmission( listcritere )
        voeux.each do |voeu|
            critere = voeu.getcritere( listcritere )
            if critere 
                voeu.statut = true
                #check moyenne academique
                if @moyenneAcademique < critere.critereAcademique && critere.critereAcademique != 0
                    voeu.statut = false
                    voeu.failedMoy = true
                end
                #Check note TOEFL
                if @noteTOEFL != 0 && critere.critereTOEFL != 0  && @noteTOEFL< critere.critereTOEFL
                    voeu.statut = false
                    voeu.failedTOEFL = true 
                end
                #check note IELTS
                if @noteIELTS != 0 && critere.critereIELTS != 0 && @noteIELTS < critere.critereIELTS 
                    voeu.statut = false
                    voeu.failedIELTS = true 
                end
            end
        end
    end
end