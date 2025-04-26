const router = require('express-promise-router')();

const { verifConnexion } = require('../controllers/verifConnexion');

router.route('/:email/:password')
    .get(verifConnexion);

module.exports = router;