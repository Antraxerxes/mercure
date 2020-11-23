require_relative 'excel'


# texte d'introduction 
puts "Bienvenue dans Mercure l'outil de gestion des mobilites internationales de l'UGA"
# Etape 1 Creation de la liste des critéres d'admission

fichier = FichierExcel.new

puts "\t Etape 1: Creation de la liste des criteres d'admission par accord"
ListeCritereAdmission = fichier.parsingDesNotes 'Criteres par accords'
# Etape 2 Créer la liste des étudiants avec leur résultat
puts "\t Etape 2: Creation de la liste des resultats des etudiants"
ListeEtudiants = fichier.parsingDesNotes 'Eligibilite etudiants'
# Etape 3 Ajout des voeux pour chaque etudiant
puts "\t Etape 3: Recuperation des voeux de chaque etudiants"
fichier.addVoeu( ListeEtudiants )
# Etape 4 Verification des admissibilité pour chaque eleve
puts "\t Etape 4: Verifications de l'admissibilite de chaque eleve dans chacun de ses voeux"
ListeEtudiants.each do |etudiant|
    etudiant.checkAdmission( ListeCritereAdmission )
end
# Etape 5 Création du tableau des résultats
puts "\t Etape 5: Création du tableau des resultats"
fichier.createOutputCanva
fichier.printTab(ListeEtudiants)


###########################################################
# Test parsing des structures
# ListeEtudiants.each do |etudiant|
#    puts etudiant.nom + " a une moyenne academique de"
#    puts etudiant.moyenneAcademique 
#    puts etudiant.voeux[0].nom
# end
###########################################################