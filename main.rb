require_relative 'excel'

# texte d'introduction 
puts "Bienvenue dans Mercure l'outil de gestion des mobilités internationales de l'UGA"
# Etape 1 Creation de la liste des critéres d'admission

fichier = FichierExcel.new

puts "\t Etape 1: Création de la liste des critéres d'admission par accord"
ListeCritereAdmission = fichier.parsingDesNotes 'critere'
# Etape 2 Créer la liste des étudiants avec leur résultat
puts "\t Etape 2:  Création de la liste des résultats des étudiants"
ListeEtudiants = fichier.parsingDesNotes 'etudiants'

# Etape 3 Tri du tableau des voeu
fichier.addVoeu( ListeEtudiants )



###########################################################
# Test parsing des structures
# ListeEtudiants.each do |etudiant|
#    puts etudiant.nom + " a une moyenne academique de"
#    puts etudiant.moyenneAcademique 
#    puts etudiant.voeux[0].nom
# end
###########################################################