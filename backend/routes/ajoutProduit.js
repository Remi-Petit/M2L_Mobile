const router = require('express-promise-router')();

const { ajoutProduit } = require('../controllers/ajoutProduit');

router.route('/:nom/:marque/:poids/:taille/:quantite/:prix')
    .get(ajoutProduit);

module.exports = router;