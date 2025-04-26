const pool = require('../config/database');

module.exports = {
    listeProduitsCategorie: async (req, res, next) => {
        let connexion;
        try {
            const id = req.params.id;
            connexion = await pool.getConnection();
            const result = await connexion.query('select * from t_produit AS p JOIN t_categorie AS pc ON p.categorie_produit = pc.id_categorie WHERE pc.id_categorie ="'+id+'";');
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    }
}