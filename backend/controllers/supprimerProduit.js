const pool = require('../config/database');

module.exports = {
    supprimerProduit: async (req, res, next) => {
        let connexion;
        try {
            const id = req.params.id
            connexion = await pool.getConnection();
            const result = await connexion.query('DELETE FROM t_produit WHERE id_produit = "'+id+'";');
            return res.status(200).json(result)
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    }
}