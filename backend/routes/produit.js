const router = require('express-promise-router')();

const { produit } = require('../controllers/produit');

router.route('/:id')
    .get(produit);

module.exports = router;