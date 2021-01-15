require 'rubyXL'
require 'rubyXL/convenience_methods'


require_relative 'critereAdmission'
require_relative 'etudiant'
require_relative 'jury'
require_relative 'place'

class FichierExcel

    attr_accessor :structFichierExcel

    def initialize( nom = "TestTab.xlsx" )
        @structFichierExcel = RubyXL::Parser.parse(nom) #ouvrir le fichier excel
        @outputTab = RubyXL::Workbook.new #creer le fichier de sortie
        @juryOutputTab = RubyXL::Workbook.new #creer le fichier de sortie
        @repartitionOutputTab = RubyXL::Workbook.new
    end

    def parsingDesNotes ( nomFeuillet )
        list = Array.new
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            feuillet.each do | ligne |
                if ligne != feuillet[0]
                    if nomFeuillet.eql? 'Critères par accords'
                        if ligne[4].value
                            list << CritereAdmission.new( ligne )
                        end
                    elsif nomFeuillet.eql? 'Eligibilité etudiants'
                        list << Etudiant.new( ligne )
                    end
                end 
            end
        else
            puts "pas de feuillet #{nomFeuillet}"
        end
        list
    end

    def parsingJurys ( nomFeuillet)
        list = Array.new
        index = 8
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            15.times do |i|
                list << Jury.new( feuillet[index][0], feuillet[index][1], feuillet[index][2] )
                index = index+1
            end
        end
        list
    end

    def parsingPlace ( nomFeuillet)
        list = Array.new
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            feuillet.each do | ligne |
                list << Place.new( ligne )
            end
        end
        list
    end

    def addVoeu( etudiantList )
        if feuillet =  @structFichierExcel['Voeux étudiants']
            feuillet.each do | voeu |
                if voeu != feuillet[0]
                    etudiantList.each do |etudiant|
                        if etudiant.nom.casecmp? voeu[1].value
                            etudiant.ajoutVoeu( voeu )
                        end
                    end
                end
            end
        else
            puts "pas de feuillet voeu"
        end
    end

    def createOutputCanva
        feuillet = @outputTab.worksheets[0]
        feuillet.sheet_name = 'Resultats'
        feuillet.add_cell(0, 0 , 'rang')
        feuillet.add_cell(0, 1 , 'Nom')
        feuillet.add_cell(0, 2 , 'Composante')
        feuillet.add_cell(0, 3 , 'Voeu')
        feuillet.add_cell(0, 4 , 'Date de debut')
        feuillet.add_cell(0, 5 , 'Duree')
        feuillet.add_cell(0, 6 , 'Admissibimlité')
        feuillet.add_cell(0, 7 , 'Raison refus')

    end

    def printTab( listeEtudiants )
        
        feuillet = @outputTab.worksheets[0]
        index = 1
        listeEtudiants.each do |etudiant|
            etudiant.voeux.each do |voeu|
                feuillet.add_cell(index, 0 , voeu.index)
                feuillet.add_cell(index, 1 , etudiant.nom)
                feuillet.add_cell(index, 2 , voeu.composante)
                feuillet.add_cell(index, 3 , voeu.nom)
                feuillet.add_cell(index, 4 , voeu.dateDebut)
                feuillet[index][3].set_number_format 'd-mm-yyyy' # set format for date
                feuillet.add_cell(index, 5 , voeu.duree)
                #ajout du statut d'admission pour chaque voeu
                if voeu.statut == true
                    feuillet.add_cell(index, 6 , "admis" )
                    feuillet[index][6].change_fill('0ba53d')
                else
                    feuillet.add_cell(index, 6 , "refuse" )
                    feuillet[index][6].change_fill('c80d0d')
                end
                failedstring = ""
                # raison du refus si refus
                if voeu.failedMoy == true
                    failedstring +="Moyenne academique insuffisante"
                end
                if voeu.failedTOEFL == true
                    failedstring +=" Resultat TOEFL insuffisant"
                end
                if voeu.failedIELTS == true
                    failedstring +=" Resultat IELTS insuffisant"
                end
                if voeu.failedCritere == true
                    failedstring +=" Pas de critére pour ce voeu"
                end
                if voeu.failedrang == true
                    failedstring +=" Pas plus de 3 voeux"
                end
                feuillet.add_cell(index, 7 , failedstring )
                index = index + 1
            end
        end
        @outputTab.write("resultatAdmission.xlsx")
    end

    def createJuryOutputCanva
        feuillet = @juryOutputTab.worksheets[0]
        feuillet.sheet_name = 'Jury'
        feuillet.add_cell(0, 0 , 'Nom')
        feuillet.add_cell(0, 1 , 'jureA')
        feuillet.add_cell(0, 2 , 'jureB')
        feuillet.add_cell(0, 3 , 'Etudiants')
        feuillet.add_cell(0, 4 , 'Composante')

    end

    def printJuryTab( listeJury )
        feuillet = @juryOutputTab.worksheets[0]
        index = 1
        listeJury.each do |jury|
            feuillet.add_cell(index, 0 , jury.nom)
            feuillet.add_cell(index, 1 , jury.jureA)
            feuillet.add_cell(index, 2 , jury.jureB)
            jury.etudiants.each do |etudiant|
                feuillet.add_cell(index, 3 , etudiant.nom)
                feuillet.add_cell(index, 4 , etudiant.composante)
                index = index + 1

            end
        end
        @juryOutputTab.write("Jurys.xlsx")
    end

    def createRepartitionCanva
        feuillet = @repartitionOutputTab.worksheets[0]
        feuillet.sheet_name = 'Atribution places'
        feuillet.add_cell(0, 0 , 'Nom Etudiant')
        feuillet.add_cell(0, 1 , 'Composante')
        feuillet.add_cell(0, 2 , 'Evaluation Composante ')
        feuillet.add_cell(0, 3 , 'Evaluation Jury ')
        feuillet.add_cell(0, 4 , 'Classement')
        feuillet.add_cell(0, 5 , 'Vœu Attribué')
        feuillet.add_cell(0, 6 , 'Durée')
        feuillet.add_cell(0, 7 , 'Début mobilité')
        feuillet = @repartitionOutputTab.add_worksheet("Proposition remplacement")
        feuillet.add_cell(0, 0 , 'Nom Etudiant')
        feuillet.add_cell(0, 1 , 'Composante')
        feuillet.add_cell(0, 2 , 'Classement')
        feuillet.add_cell(0, 3 , 'Destination disponibles qui matchent critères ')
    end

    def printRepartitionTab( listeEtudiants )
        index = 1
        feuillet = @repartitionOutputTab['Atribution places']
        listeEtudiants.each do |etudiant|
            if etudiant.statutAttribution == true
                feuillet.add_cell(index, 0 , etudiant.nom)
                feuillet.add_cell(index, 1 , etudiant.composante)
                feuillet.add_cell(index, 2 , etudiant.evalComposante)
                feuillet.add_cell(index, 3 , etudiant.evalJury)
                feuillet.add_cell(index, 4 , etudiant.rang)
                feuillet.add_cell(index, 5 , etudiant.attribution.nom)
                feuillet.add_cell(index, 6 , etudiant.attribution.duree)
                feuillet.add_cell(index, 7 , etudiant.attribution.dateDebut)
                index += 1
            end
        end
        feuillet = @repartitionOutputTab["Proposition remplacement"]
        index = 1
        listeEtudiants.each do |etudiant|
            if etudiant.statutAttribution == false
                feuillet.add_cell(index, 0 , etudiant.nom)
                feuillet.add_cell(index, 1 , etudiant.composante)
                feuillet.add_cell(index, 2 , etudiant.rang)
                iteration = 0
                etudiant.listadmissible.each do |admissible|
                    feuillet.add_cell(index, 3 + iteration , admissible)
                    iteration +=1 
                end
                index += 1
            end
        end
        @repartitionOutputTab.write("RepartitionDesVoeux.xlsx")
    end

    def correctionVoeu (listEtudiants)
        feuillet =  @structFichierExcel[' admissibilité voeux']
        feuillet.each do | voeuTab |
            listEtudiants.each do |etudiant|
                if voeuTab[0].value.eql?(etudiant.nom )
                    etudiant.voeux.each do |voeuEtudiant|
                        if voeuEtudiant.nom.eql?(voeuTab[3].value )
                            voeuEtudiant.duree = voeuTab[5].value
                            if voeuTab[6].value.eql?('admis')
                                voeuEtudiant.statut = true
                            else
                                voeuEtudiant.statut = false
                            end
                        end
                    end
                end
            end
        end
    end

end
