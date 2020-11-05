require 'rubyXL'

require_relative 'critereAdmission'
require_relative 'etudiant'

class FichierExcel

    def initialize( nom = "TestTab.xlsx" )
        @structFichierExcel = RubyXL::Parser.parse(nom) #ouvrir le fichier excel
    end

    def parsingDesNotes ( nomFeuillet )
        list = Array.new
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir le feuillet en argument
            feuillet.each do | ligne |
                if ligne != feuillet[0]
                    if nomFeuillet.eql? 'critere'
                        list << CritereAdmission.new( ligne )
                    elsif nomFeuillet.eql? 'etudiants'
                        list << Etudiant.new( ligne )
                    end
                end 
            end
        else
            puts "pas de feuillet #{nomFeuillet}"
        end
        list
    end

    def addVoeu( etudiantList )
        if feuillet =  @structFichierExcel['voeu']
            feuillet.each do | voeu |
                if voeu != feuillet[0]
                    if voeu[1].value.include?('UGA')
                        if voeu[1].value.include?('IUGA')
                        else
                            etudiantList.each do |etudiant|
                                if etudiant.nom.eql? voeu[0].value
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
end
