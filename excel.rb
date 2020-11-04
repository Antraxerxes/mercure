require 'rubyXL'

require_relative 'critereAdmission'
require_relative 'etudiant'


class FichierExcel

    def initialize( nom = "TestTab.xlsx" )
        @structFichierExcel = RubyXL::Parser.parse(nom) #ouvrir le fichier excel
    end

    def parsingDesNotes ( nomFeuillet )

        list = Array.new
        if feuillet =  @structFichierExcel[nomFeuillet] #Ouvrir la feuille critére
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
        
    end
end
