const router = require('express-promise-router')();

const { listeClients } = require('../controllers/listeClients');

router.route('/')
    .get(listeClients);

module.exports = router;