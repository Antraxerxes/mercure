require_relative 'excel'

# texte d'introduction 
puts "Bienvenue dans Mercure l'outil de gestion des mobilites internationales de l'UGA"
# Etape 1 Creation de la liste des critéres d'admission

fichier = FichierExcel.new

puts "\t Etape 1: Creation de la liste des criteres d'admission par accord"
ListeCritereAdmission = fichier.parsingDesNotes 'Critères par accords'
# Etape 2 Créer la liste des étudiants avec leur résultat
puts "\t Etape 2: Creation de la liste des resultats des etudiants"
ListeEtudiants = fichier.parsingDesNotes 'Eligibilité etudiants'
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

#Etape 7 Création des jurys 
puts "\t Etape 7: Attribution des jury "
ListeEtudiants.each do |etudiant|
    jury = ListeJury.sample
    while jury.composanteA.casecmp(etudiant.composante) == 0 || jury.composanteB.casecmp(etudiant.composante) == 0
        jury = ListeJury.sample
    end
    jury.etudiants << etudiant
    jury1 = jury
    jury = ListeJury.sample
    while jury1 == jury || ( jury.composanteA.casecmp(etudiant.composante) == 0 || jury.composanteB.casecmp(etudiant.composante) == 0 )
        jury = ListeJury.sample
    end
    jury.etudiants << etudiant
end

# Etape 8 Création du tableau des jury
puts "\t Etape 8: Création du tableau des jurys"
fichier.createJuryOutputCanva
fichier.printJuryTab(ListeJury)

# Etape 9 Classement des etudiant
puts "\t Etape 9: Classement des etudiant"
ListeEtudiants.sort! { |a, b|  b.evalComposante <=> a.evalComposante }
i = 1
ListeEtudiants.each do |etudiant|
    etudiant.rang = i
    i = i+1
end

verif = false
# # Etape 10 Correction 
puts "\t Etape 10: Correction"
if fichier.structFichierExcel[' admissibilité voeux']
    fichier.correctionVoeu(ListeEtudiants)
    verif=true
else
    puts "Verification manuelle necessaire pour l'attribution des voeux"
end

if verif
    # Etape 11 attribution des voeux
    puts "\t Etape 11: Attribution des voeux"
    ListPlace = fichier.parsingPlace( 'places par accords' )
    ListeEtudiants.each do |etudiant|
        etudiant.attributionDeVoeu ( ListPlace )
    end

    # Etape 12 listing accord potentiel
    puts "\t Etape 12: listing accord potentiel"
    ListeEtudiants.each do |etudiant|
        if etudiant.statutAttribution == false
            etudiant.creerListAdmissible( ListeCritereAdmission, ListPlace )
        end
    end

    # Etape 13 tableau de repartition des voeux
    puts "\t Etape 13: tableau de repartition des voeux"
    fichier.createRepartitionCanva
    fichier.printRepartitionTab(ListeEtudiants)
end

###########################################################
#Test parsing des structures
# ListeEtudiants.each do |etudiant|
#     puts etudiant.nom
#     if etudiant.attribution = 0 
#         etudiant.listadmissible.each do |admissible|
#             puts admissible
#         end
#     else
#         puts etudiant.attribution.nom
#     end
# end
###########################################################