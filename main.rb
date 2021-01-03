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

# Etape 6 Création des jurys 
puts "\t Etape 6: Création des jurys "
ListeJury = fichier.parsingJurys "Jurés"

# Etape 7 Création des jurys 
puts "\t Etape 7: attribution des jury "
listEtudiantJury =  Array.new { Array.new(2) }
ListeEtudiants.each do |etudiant|
    if listEtudiantJury.include?([etudiant.nom , etudiant.composante]) == false
        listEtudiantJury << [etudiant.nom , etudiant.composante]
    end
end
listEtudiantJury.each do |etudiant|
    jury = ListeJury.sample
    while jury.composanteA.casecmp(etudiant[1]) == 0 || jury.composanteB.casecmp(etudiant[1]) == 0
        puts 'la'
        jury = ListeJury.sample
    end
    jury.etudiants << etudiant[0]
end

# Etape 8 Création du tableau des jury
puts "\t Etape 8: Création du tableau des jurys"
fichier.createJuryOutputCanva
fichier.printJuryTab(ListeJury)



###########################################################
# Test parsing des structures
#ListeJury.each do |jury|
#    puts jury.nom 
#    puts jury.jureA 
#    puts jury.jureB
#    puts jury.etudiants.first
#end
###########################################################