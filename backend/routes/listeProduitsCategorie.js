const router = require('express-promise-router')();

const { listeProduitsCategorie} = require('../controllers/listeProduitsCategorie');

router.route('/:id')
    .get(listeProduitsCategorie);

module.exports = router;