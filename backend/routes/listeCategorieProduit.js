const router = require('express-promise-router')();

const { listeCategorieProduit } = require('../controllers/listeCategorieProduit');

router.route('/')
    .get(listeCategorieProduit);

module.exports = router;