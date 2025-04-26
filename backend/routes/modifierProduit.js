const router = require('express-promise-router')();
const { modifierProduit } = require('../controllers/modifierProduit');

router.route('/:id/:nom/:marque/:poids/:taille/:quantite/:prix')
    .get(modifierProduit);

module.exports = router;
