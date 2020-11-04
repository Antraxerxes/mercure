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

    def triVoeu
        numligne = 0
        if feuillet =  @structFichierExcel['voeu']
            feuillet.each do | ligne |
                numligne+1
                if ligne != feuillet[0]
                    if ligne[1].value.include?('UGA')
                        if ligne[1].value.include?('IUGA')
                        else
                            puts ligne[1].value    
                        end
                    else
                    end        
                end
            end
        else
            puts "pas de feuillet voeu"
        end
    end

end
