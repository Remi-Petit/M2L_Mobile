const router = require('express-promise-router')();

const { listeProduit } = require('../controllers/listeProduit');

router.route('/')
    .get(listeProduit);

module.exports = router;