require('dotenv').config({ path: `./config/${process.env.NODE_ENV}.env` })

const express = require('express');

const app = express();

const cors = require('cors');
app.use(cors())

app.use(express.json());

const panierRoute = require('./routes/panier');
const listeProduitRoute = require('./routes/listeProduit');
const listeClientsRoute = require('./routes/listeClients');
const produitRoute = require('./routes/produit');
const listeCategorieProduitRoute = require('./routes/listeCategorieProduit');
const listeProduitsCategorieRoute = require('./routes/listeProduitsCategorie');

const ajoutProduitRoute = require('./routes/ajoutProduit');
const modifierProduitRoute = require('./routes/modifierProduit');
const supprimerProduitRoute = require('./routes/supprimerProduit');
const verifConnexionRoute = require('./routes/verifConnexion');


app.use('/api/panier', panierRoute);
app.use('/api/listeProduit', listeProduitRoute);
app.use('/api/listeClients', listeClientsRoute);
app.use('/api/produit', produitRoute);
app.use('/api/listeCategorieProduit', listeCategorieProduitRoute);
app.use('/api/listeProduitsCategorie', listeProduitsCategorieRoute);

app.use('/api/ajoutProduit', ajoutProduitRoute);
app.use('/api/modifierProduit', modifierProduitRoute);
app.use('/api/supprimerProduit', supprimerProduitRoute);
app.use('/api/verifConnexion', verifConnexionRoute);


app.get('/api', (_, res) => res.send("Hello from API v1"));

app.listen(process.env.PORT, () => console.log(`Back end is running on PORT ${process.env.PORT}`));

module.exports = app;