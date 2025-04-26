const pool = require('../config/database');

module.exports = {
    modifierProduit: async (req, res, next) => {
        let connexion;
        try {
            const id = req.params.id;
            const nom = req.params.nom;
            const marque = req.params.marque;
            const poids = req.params.poids;
            const taille = req.params.taille;
            const quantite = req.params.quantite;
            const prix = req.params.prix;

            connexion = await pool.getConnection();

            const result = await connexion.query(
                `UPDATE t_produit 
                SET nom_produit = ?, 
                    marque_produit = ?, 
                    poids_produit = ?, 
                    taille_produit = ?, 
                    quantite_produit = ?, 
                    prix_produit = ?
                WHERE id_produit = ?`,
                [nom, marque, poids, taille, quantite, prix, id]
            );

            return res.status(200).json({ success: true, result });
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end();
        }
    }
}
