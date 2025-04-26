-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3307
-- Généré le : sam. 26 avr. 2025 à 16:27
-- Version du serveur : 10.10.2-MariaDB
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `m2l_mobile`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `ajoutClient`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutClient` (IN `nom_client` VARCHAR(100), IN `prenom_client` VARCHAR(100), IN `adresse_client` VARCHAR(100))   BEGIN

INSERT INTO t_client (`nom_client`,`prenom_client`,`mail_client`,`adresse_client`,`mdp_client`,`admin_client`) VALUES (nom_client,prenom_client,mail_client,adresse_client,mdp_client,admin_client);

END$$

DROP PROCEDURE IF EXISTS `ajoutPanier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutPanier` (IN `idclient_panier` VARCHAR(100), IN `produit_panier` VARCHAR(100), IN `nbproduit_panier` VARCHAR(100))   BEGIN

INSERT INTO t_panier (`idclient_panier`,`produit_panier`,`nbproduit_panier`) VALUES (idclient_panier,produit_panier,nbproduit_panier);

END$$

DROP PROCEDURE IF EXISTS `ajoutProduit`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutProduit` (IN `nom_produit` VARCHAR(100), IN `marque_produit` VARCHAR(100), IN `poids_produit` VARCHAR(100), IN `taille_produit` VARCHAR(100), IN `quantite_produit` VARCHAR(100), IN `prix_produit` VARCHAR(100))   BEGIN

INSERT INTO t_produit (`nom_produit`,`marque_produit`,`poids_produit`,`taille_produit`,`quantite_produit`,`prix_produit`) VALUES (nom_produit,marque_produit,poids_produit,taille_produit,quantite_produit,prix_produit);

END$$

DROP PROCEDURE IF EXISTS `ajoutStockage`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ajoutStockage` (IN `localisation_stockage` VARCHAR(100), IN `taille_stockage` VARCHAR(100), IN `nom_stockage` VARCHAR(100), IN `produit_stockage` VARCHAR(100))   BEGIN

INSERT INTO t_stockage (`localisation_stockage`,`taille_stockage`,`nom_stockage`,`produit_stockage`) VALUES (localisation_stockage,taille_stockage,nom_stockage,produit_stockage);

END$$

DROP PROCEDURE IF EXISTS `modificationPanier`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificationPanier` (IN `idclient_panier` VARCHAR(100), IN `produit_panier` VARCHAR(100), IN `nbproduit_panier` VARCHAR(100))   BEGIN

UPDATE t_panier SET produit_panier = produit_panier, nbproduit_panier = nbproduit_panier WHERE idclient_panier;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_categorie`
--

DROP TABLE IF EXISTS `t_categorie`;
CREATE TABLE IF NOT EXISTS `t_categorie` (
  `id_categorie` int(11) NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(512) NOT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `t_categorie`
--

INSERT INTO `t_categorie` (`id_categorie`, `nom_categorie`) VALUES
(1, 'raquette'),
(2, 'filet'),
(3, 'volant'),
(4, 'sac');

-- --------------------------------------------------------

--
-- Structure de la table `t_client`
--

DROP TABLE IF EXISTS `t_client`;
CREATE TABLE IF NOT EXISTS `t_client` (
  `id_client` int(11) NOT NULL AUTO_INCREMENT,
  `nom_client` varchar(255) NOT NULL,
  `prenom_client` varchar(255) NOT NULL,
  `mail_client` varchar(250) NOT NULL,
  `adresse_client` varchar(512) NOT NULL,
  `mdp_client` text NOT NULL,
  `admin_client` varchar(512) NOT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `t_client`
--

INSERT INTO `t_client` (`id_client`, `nom_client`, `prenom_client`, `mail_client`, `adresse_client`, `mdp_client`, `admin_client`) VALUES
(1, 'LAUNAY', 'Erwan', 'b@b.com', 'TEST', 'b', 'true'),
(3, 'PETIT', 'Rémi', 'a@a.com', '11 Grande Rue', 'a', 'true'),
(4, 'BEAULIEU', 'Mattéo', 'c@c.com', 'Crécy-La-Chapelle', 'c', '');

-- --------------------------------------------------------

--
-- Structure de la table `t_panier`
--

DROP TABLE IF EXISTS `t_panier`;
CREATE TABLE IF NOT EXISTS `t_panier` (
  `id_panier` int(11) NOT NULL AUTO_INCREMENT,
  `idclient_panier` varchar(100) NOT NULL,
  `produit_panier` varchar(100) NOT NULL,
  `nbproduit_panier` varchar(100) NOT NULL,
  PRIMARY KEY (`id_panier`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `t_panier`
--

INSERT INTO `t_panier` (`id_panier`, `idclient_panier`, `produit_panier`, `nbproduit_panier`) VALUES
(2, '2', 'Raquette', '12');

-- --------------------------------------------------------

--
-- Structure de la table `t_produit`
--

DROP TABLE IF EXISTS `t_produit`;
CREATE TABLE IF NOT EXISTS `t_produit` (
  `id_produit` int(11) NOT NULL AUTO_INCREMENT,
  `nom_produit` varchar(255) NOT NULL,
  `marque_produit` varchar(255) NOT NULL,
  `poids_produit` varchar(10) DEFAULT NULL,
  `taille_produit` varchar(10) DEFAULT NULL,
  `quantite_produit` varchar(11) NOT NULL,
  `prix_produit` varchar(10) NOT NULL,
  `categorie_produit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `t_produit`
--

INSERT INTO `t_produit` (`id_produit`, `nom_produit`, `marque_produit`, `poids_produit`, `taille_produit`, `quantite_produit`, `prix_produit`, `categorie_produit`) VALUES
(24, 'C3', 'Citroën', '1050', '4015', '3', '15750', NULL),
(25, 'Kuga', 'Ford', '1613', '4604', '1', '39490', NULL),
(27, '208', 'Peugeot', '1050', '4055', '1', '21000', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `t_stockage`
--

DROP TABLE IF EXISTS `t_stockage`;
CREATE TABLE IF NOT EXISTS `t_stockage` (
  `id_stockage` int(11) NOT NULL AUTO_INCREMENT,
  `localisation_stockage` varchar(100) NOT NULL,
  `taille_stockage` varchar(100) NOT NULL,
  `nom_stockage` varchar(100) NOT NULL,
  `produit_stockage` varchar(100) NOT NULL,
  PRIMARY KEY (`id_stockage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
