require 'rubyXL'
require_relative 'critereAdmission'
require_relative 'etudiant'

def creationList ( nomFeuillet )

    list = Array.new

    fichierExcel = RubyXL::Parser.parse("critereadmission.xlsx") #ouvrir le fichier excel

    if feuillet = fichierExcel[nomFeuillet] #Ouvrir la feuille critére

        feuillet.each do | ligne |
            if nomFeuillet.eql? 'critere'
                list << CritereAdmission.new( ligne )
            elsif nomFeuillet.eql? 'eleve'
                list << Etudiant.new( ligne )
            end
            
        end
    else
        puts "pas de feuillet #{nomFeuillet}"
    end
    list
end


# texte d'introduction 
puts "Bienvenue dans Mercure l'outil de gestion des mobilités internationales de l'UGA"
# Etape 1 Creation de la liste des critéres d'admission
puts "\t Etape 1: Création de la liste des critéres d'admission par accord"
ListeCritereAdmission = creationList 'critere'
# Etape 2 Créer la liste des étudiants avec leur résultat
puts "\t Etape 2:  Création de la liste des résultats des étudiants"
ListeEtudiantAdmission = creationList 'etudiants'
# Etape 3 Tri du tableau des voeu

