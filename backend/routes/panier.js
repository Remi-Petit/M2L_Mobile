const router = require('express-promise-router')();

const { panier } = require('../controllers/panier');

router.route('/')
    .get(panier);

module.exports = router;