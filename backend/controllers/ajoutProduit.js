const pool = require('../config/database');

module.exports = {
    ajoutProduit: async (req, res, next) => {
        let connexion;
        try {
            const nom = req.params.nom
            const marque = req.params.marque
            const poids = req.params.poids
            const taille = req.params.taille
            const quantite = req.params.quantite
            const prix = req.params.prix
            connexion = await pool.getConnection();
            const result = await connexion.query('CALL ajoutProduit("'+nom+'","'+marque+'","'+poids+'","'+taille+'","'+quantite+'","'+prix+'")');
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    }
}