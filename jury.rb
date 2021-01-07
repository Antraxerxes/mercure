require_relative 'voeu'

class Jury
    attr_accessor :nom
    attr_accessor :jureA
    attr_accessor :jureB
    attr_accessor :composanteA
    attr_accessor :composanteB
    attr_accessor :etudiants

    # Création de l'objet jury
    def initialize( colonneA, colonneB, colonneC = 'juré seul' )
        @nom = colonneA.value
        @jureA = colonneB.value
        @composanteA = jureA.split(' ').first
        @jureB = colonneC.value
        @composanteB = jureB.split(' ').first
        @etudiants = Array.new { Array.new(2) }
    end

end