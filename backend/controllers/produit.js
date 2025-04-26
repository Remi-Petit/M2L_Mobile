const pool = require('../config/database');

module.exports = {
    produit: async (req, res, next) => {
        let connexion;
        try {
            const id = req.params.id;

            console.log("l'id du produit est : " + id);
            connexion = await pool.getConnection();
            const result = await connexion.query('SELECT * FROM t_produit WHERE id_produit = "'+id+'";');

            console.log(result[0]);
            return res.status(200).json(result[0])
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    }
}