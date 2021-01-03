require 'rubyXL'
require 'rubyXL/convenience_methods'

require_relative 'critereAdmission'
require_relative 'etudiant'
require_relative 'jury'

class FichierExcel

    def initialize( nom = "TestTab.xlsx" )
        @structFichierExcel = RubyXL::Parser.parse(nom) #ouvrir le fichier excel
        @outputTab = RubyXL::Workbook.new #creer le fichier de sortie
        @juryOutputTab = RubyXL::Workbook.new #creer le fichier de sortie
    end

    def parsingDesNotes ( nomFeuillet )
        list = Array.new
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            feuillet.each do | ligne |
                if ligne != feuillet[0]
                    if nomFeuillet.eql? 'Criteres par accords'
                        list << CritereAdmission.new( ligne )
                    elsif nomFeuillet.eql? 'Eligibilite etudiants'
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
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            13.times do |i| 
                list << Jury.new( feuillet[0][i], feuillet[1][i], feuillet[2][i] ) 
            end
        else
            puts "pas de feuillet #{nomFeuillet}"
        end
        list
    end

    def addVoeu( etudiantList )
        if feuillet =  @structFichierExcel['Voeux etudiants']
            feuillet.each do | voeu |
                if voeu != feuillet[0]
                    if voeu[3].value.include?('UGA')
                        if voeu[3].value.include?('IUGA')
                        else
                            etudiantList.each do |etudiant|

                                if etudiant.nom.casecmp? voeu[0].value
                                    etudiant.ajoutVoeu( voeu )
                                end
                            end
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
        feuillet.add_cell(0, 0 , 'Nom')
        feuillet.add_cell(0, 1 , 'Composante')
        feuillet.add_cell(0, 2 , 'Voeu')
        feuillet.add_cell(0, 3 , 'Date de debut')
        feuillet.add_cell(0, 4 , 'Date de fin')
        feuillet.add_cell(0, 5 , 'Admissibimlité')
        feuillet.add_cell(0, 6 , 'Raison refus')

    end

    def printTab( listeEtudiants )
        
        feuillet = @outputTab.worksheets[0]
        index = 1
        listeEtudiants.each do |etudiant|
            etudiant.voeux.each do |voeu|
                feuillet.add_cell(index, 0 , etudiant.nom)
                feuillet.add_cell(index, 1 , voeu.composante)
                feuillet.add_cell(index, 2 , voeu.nom)
                feuillet.add_cell(index, 3 , voeu.dateDebut)
                feuillet[index][3].set_number_format 'd-mm-yyyy' # set format for date
                feuillet.add_cell(index, 4 , voeu.dateFin)
                feuillet[index][4].set_number_format 'd-mm-yyyy' # set format for date
                #ajout du statut d'admission pour chaque voeu
                if voeu.statut == true
                    feuillet.add_cell(index, 5 , "admis" )
                    feuillet[index][5].change_fill('0ba53d')
                else
                    feuillet.add_cell(index, 5 , "refuse" )
                    feuillet[index][5].change_fill('c80d0d')
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
                feuillet.add_cell(index, 6 , failedstring )
                index = index + 1
            end
        end
        @outputTab.write("./resultatAdmission.xlsx")
    end

    def createJuryOutputCanva
        feuillet = @juryOutputTab.worksheets[0]
        feuillet.sheet_name = 'Jury'
        feuillet.add_cell(0, 0 , 'Nom')
        feuillet.add_cell(0, 1 , 'jureA')
        feuillet.add_cell(0, 2 , 'jureB')
        feuillet.add_cell(0, 3 , 'Etudiants')

    end

    def printJuryTab( listeJury )
        
        feuillet = @juryOutputTab.worksheets[0]
        index = 1
        listeJury.each do |jury|
            puts jury.nom
                feuillet.add_cell(index, 0 , jury.nom)
                feuillet.add_cell(index, 1 , jury.jureA)
                feuillet.add_cell(index, 2 , jury.jureB)
                jury.etudiants.each do |etudiant|
                    feuillet.add_cell(index, 3 , etudiant)
                    index = index + 1
                end
        end
        @juryOutputTab.write("./Jurys.xlsx")
    end

end
