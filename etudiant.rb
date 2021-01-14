require_relative 'voeu'

class Etudiant
    attr_accessor :nom
    attr_accessor :noteTOEFL
    attr_accessor :noteIELTS
    attr_accessor :moyenneAcademique
    attr_accessor :voeux
    attr_accessor :composante
    attr_accessor :evalComposante
    attr_accessor :evalJury
    attr_accessor :rang
    attr_accessor :attribution
    attr_accessor :listadmissible
    attr_accessor :statutAttribution

    # Création de l'objet eleve
    def initialize( ligne )
        @nom = ligne[0].value.strip
        @composante = ligne[1].value  
        @noteTOEFL = ligne[4].value
        @noteIELTS = ligne[5].value
        @moyenneAcademique = ligne[6].value
        @evalComposante = ligne[7].value
        @evalJury = 0
        @voeux = Array.new
        @rang = 0
        @attribution = Voeu.new(0,0,0,0,0)
        @listadmissible = Array.new
        @statutAttribution = false
    end

    def ajoutVoeu( voeu )
        @voeux << Voeu.new( voeu[3].value, voeu[0].value, voeu[2].value, voeu[6].value, voeu[5].value )
    end

    def checkAdmission( listcritere )
        voeux.each do |voeu|
            critere = voeu.getcritere( listcritere )
            if critere != false 
                voeu.statut = false
                #check moyenne admission
                if @moyenneAcademique >= critere.critereAcademique && ( @noteTOEFL >= critere.critereTOEFL || @noteIELTS >= critere.critereIELTS  ) 
                    voeu.statut = true
                end
                #Check fail academique
                if voeu.statut == false && @moyenneAcademique < critere.critereAcademique 
                    voeu.failedMoy = true 
                end
                #Check fail IELTS
                if voeu.statut == false && @noteIELTS < critere.critereIELTS
                    voeu.failedIELTS = true 
                end
                #Check fail toefl
                if voeu.statut == false && @noteTOEFL < critere.critereTOEFL 
                    voeu.failedTOEFL = true 
                end
                if voeu.index > 3
                    voeu.statut = false
                    voeu.failedrang = true 
                end
            else
                voeu.statut = false
                voeu.failedCritere = true
            end
        end
    end

    def attributionDeVoeu ( listPlaces)
        voeux.sort { |a, b|  b.index <=> a.index }
        voeux.each do |voeu|
            if voeu.statut == true && statutAttribution == false 
                listPlaces.each do |place|
                    if (place.nom.casecmp? voeu.nom) && (place.nbplace >= voeu.duree)
                        @attribution = voeu  
                        place.nbplace -= voeu.duree
                        @statutAttribution = true
                    end
                end
            end
        end
    end

    def creerListAdmissible( listeCritereAdmission, listPlaces )
        listeCritereAdmission.each do |critere |
            if   @moyenneAcademique >= critere.critereAcademique && ( @noteTOEFL >= critere.critereTOEFL || @noteIELTS >= critere.critereIELTS  ) 
                listPlaces.each do |place|
                    if (place.nom.casecmp? critere.nomAccord) && (place.nbplace > 0)
                        listadmissible << critere.nomAccord
                    end
                end
            end
        end
    end
end