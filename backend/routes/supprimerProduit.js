const router = require('express-promise-router')();

const { supprimerProduit } = require('../controllers/supprimerProduit');

router.route('/:id')
    .get(supprimerProduit);

module.exports = router;