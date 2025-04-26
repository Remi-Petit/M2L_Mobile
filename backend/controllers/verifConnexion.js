const pool = require('../config/database');

module.exports = {
    verifConnexion: async (req, res, next) => {
        let connexion;
        try {
            const email = req.params.email
            const password = req.params.password
            connexion = await pool.getConnection();
            const result = await connexion.query('SELECT mdp_client, admin_client FROM t_client WHERE mail_client = "'+email+'";');
            console.log("salut");
            console.log(result[0].mdp_client);

            if (result[0]) {
                if (password === result[0].mdp_client) {
                    return res.status(200).json({"result":"true", "admin":result[0].admin_client})
                } else {
                    return res.status(200).json({"result":"false"})
                }
            } else {
                return res.status(200).json({"result":"false"})
            }
        } catch (error) {
            return res.status(400).json({ error: error.message });
        } finally {
            if (connexion) connexion.end()
        }
    }
}