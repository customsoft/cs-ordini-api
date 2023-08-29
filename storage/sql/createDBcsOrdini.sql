SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';
SET NAMES utf8mb4;

DROP TABLE IF EXISTS `t_associates`;

CREATE TABLE `t_associates` (
  `idAssociate` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `idProtocolRegistry` int(10) unsigned NOT NULL,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `section` char(1) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '[vuoto] = domanda iscrizione - A = sez.A - B = sez.B',
  `lastName` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `firstName` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `birthDate` date DEFAULT NULL,
  `idBirthState` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idBirthCity` int(10) unsigned DEFAULT NULL,
  `birthCity` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `gender` char(1) CHARACTER SET utf8 NOT NULL DEFAULT 'F',
  `fiscalCode` varchar(16) CHARACTER SET utf8 NOT NULL DEFAULT 'AAAAAA00A00A000A',
  `comments` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `commentsQuota` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `notAllowNewsletters` char(0) CHARACTER SET utf8 DEFAULT NULL,
  `notAllowInitiatives` char(0) CHARACTER SET utf8 DEFAULT NULL,
  `notAllowSearches` char(0) CHARACTER SET utf8 DEFAULT NULL,
  `jobSearch` char(0) CHARACTER SET utf8 DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociate`),
  UNIQUE KEY `fiscalCode` (`fiscalCode`),
  KEY `idAssociation` (`idAssociation`),
  KEY `lastName` (`lastName`),
  KEY `firstName` (`firstName`),
  KEY `idBirthState` (`idBirthState`),
  KEY `idBirthCity` (`idBirthCity`),
  KEY `gender` (`gender`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_address`;

CREATE TABLE `t_associates_address` (
  `idAssociateAddress` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idAddress` int(10) unsigned DEFAULT NULL,
  `address` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `number` smallint(5) unsigned DEFAULT NULL,
  `letter` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idCity` int(10) unsigned DEFAULT NULL,
  `postalCode` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `locality` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateAddress`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idAddress` (`idAddress`),
  KEY `idCity` (`idCity`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_address_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_address_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_address_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_address_types`;

CREATE TABLE `t_associates_address_types` (
  `idAssociateAddressType` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociateAddress` int(10) unsigned DEFAULT NULL,
  `idTypeAddress` smallint(5) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateAddressType`),
  KEY `idAssociateAddress` (`idAssociateAddress`),
  KEY `idTypeAddress` (`idTypeAddress`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_address_types_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_address_types_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_address_types_ibfk_3` FOREIGN KEY (`idAssociateAddress`) REFERENCES `t_associates_address` (`idAssociateAddress`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_address_types_ibfk_4` FOREIGN KEY (`idTypeAddress`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_contacts`;

CREATE TABLE `t_associates_contacts` (
  `idAssociateContact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `contact` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `numberOnly` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateContact`),
  KEY `idAssociate` (`idAssociate`),
  KEY `contact` (`contact`),
  KEY `numberOnly` (`numberOnly`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_contacts_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_contacts_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_contacts_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_contacts_types`;

CREATE TABLE `t_associates_contacts_types` (
  `idAssociateContactType` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociateContact` int(10) unsigned DEFAULT NULL,
  `idTypeContact` smallint(5) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateContactType`),
  KEY `idAssociateContact` (`idAssociateContact`),
  KEY `idTypeContact` (`idTypeContact`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_contacts_types_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_contacts_types_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_contacts_types_ibfk_3` FOREIGN KEY (`idAssociateContact`) REFERENCES `t_associates_contacts` (`idAssociateContact`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_contacts_types_ibfk_4` FOREIGN KEY (`idTypeContact`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_date_sends`;

CREATE TABLE `t_associates_date_sends` (
  `idAssociateDateSend` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idTypeSend` smallint(5) unsigned DEFAULT NULL COMMENT 'DataInvio, Formazione, InvioINIPEC, ecc',
  `dateSend` date DEFAULT NULL,
  PRIMARY KEY (`idAssociateDateSend`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeSend` (`idTypeSend`),
  KEY `dateSend` (`dateSend`),
  CONSTRAINT `t_associates_date_sends_ibfk_2` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_date_sends_ibfk_3` FOREIGN KEY (`idTypeSend`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_deliberations`;

CREATE TABLE `t_associates_deliberations` (
  `idAssociateDeliberation` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idTypeDeliberation` smallint(5) unsigned DEFAULT NULL COMMENT 'SezA, SezB, Sospeso, Eliminato, Trasferito',
  `deliberationNumber` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deliberationDate` date DEFAULT NULL,
  `deliberationDateRequest` date DEFAULT NULL,
  `deliberationDateFrom` date DEFAULT NULL,
  `idTypeReason` smallint(5) unsigned DEFAULT NULL,
  `idAssociationFrom` smallint(5) unsigned DEFAULT NULL,
  `idAssociationTo` smallint(5) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateDeliberation`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeDeliberation` (`idTypeDeliberation`),
  KEY `idReason` (`idTypeReason`),
  KEY `idAssociationFrom` (`idAssociationFrom`),
  KEY `idAssociationTo` (`idAssociationTo`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_deliberations_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_deliberations_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_deliberations_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_deliberations_ibfk_4` FOREIGN KEY (`idTypeDeliberation`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_associates_deliberations_ibfk_5` FOREIGN KEY (`idTypeReason`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_associates_deliberations_ibfk_6` FOREIGN KEY (`idAssociationFrom`) REFERENCES `t_associations` (`idAssociation`),
  CONSTRAINT `t_associates_deliberations_ibfk_7` FOREIGN KEY (`idAssociationTo`) REFERENCES `t_associations` (`idAssociation`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_details`;

CREATE TABLE `t_associates_details` (
  `idAssociateDetail` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idTypeDetail` smallint(5) unsigned DEFAULT NULL,
  `detail` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idDetail` smallint(5) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateDetail`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeDetail` (`idTypeDetail`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_detailsTypes_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_detailsTypes_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_details_ibfk_1` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_details_ibfk_2` FOREIGN KEY (`idTypeDetail`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_disciplinary_proceedings`;

CREATE TABLE `t_associates_disciplinary_proceedings` (
  `idAssociateDisciplinaryProceedings` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `startDisciplinaryProceedings` date NOT NULL DEFAULT '0000-00-00',
  `endDisciplinaryProceedings` date DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateDisciplinaryProceedings`),
  KEY `idAssociate` (`idAssociate`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_disciplinary_proceedings_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_disciplinary_proceedings_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_disciplinary_proceedings_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_professions`;

CREATE TABLE `t_associates_professions` (
  `idAssociateProfessions` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idTypeEmployer` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idTypeRating` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idTypeWorkRelation` smallint(5) unsigned DEFAULT NULL,
  `startWork` date DEFAULT NULL,
  `endWork` date DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateProfessions`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeEmployer` (`idTypeEmployer`),
  KEY `idTypeRating` (`idTypeRating`),
  KEY `idTypeWorkRelation` (`idTypeWorkRelation`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_professions_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_professions_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_professions_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_professions_ibfk_4` FOREIGN KEY (`idTypeEmployer`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_associates_professions_ibfk_5` FOREIGN KEY (`idTypeRating`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_associates_professions_ibfk_6` FOREIGN KEY (`idTypeWorkRelation`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_quotas`;

CREATE TABLE `t_associates_quotas` (
  `idAssociateQuota` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `idChapter` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `quotaYear` smallint(4) unsigned DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  `valueDate` date DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateQuota`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idChapter` (`idChapter`),
  KEY `quotaYear` (`quotaYear`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_quotas_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_quotas_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_quotas_ibfk_3` FOREIGN KEY (`idChapter`) REFERENCES `t_chapters` (`idChapter`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_sanctions`;

CREATE TABLE `t_associates_sanctions` (
  `idAssociateSanction` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `dateSanction` date NOT NULL DEFAULT '0000-00-00',
  `reasonSanction` char(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `idTypeSanction` smallint(5) unsigned NOT NULL DEFAULT '0',
  `startSanction` date DEFAULT NULL,
  `endSanction` date DEFAULT NULL,
  `daysSanction` mediumint(8) unsigned DEFAULT NULL,
  `startPublication` date DEFAULT NULL,
  `endPublication` date DEFAULT NULL,
  `daysPublication` mediumint(8) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateSanction`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeSanction` (`idTypeSanction`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_sanctions_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_sanctions_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_sanctions_ibfk_4` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_sanctions_ibfk_5` FOREIGN KEY (`idTypeSanction`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_sections_codes`;

CREATE TABLE `t_associates_sections_codes` (
  `idAssociate` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `section` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'A = sez.A - B = sez.B',
  `code` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`idAssociate`),
  UNIQUE KEY `section_SectionCode` (`section`, `code`),
  CONSTRAINT `t_associates_sections_codes_ibfk_2` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associates_studies`;

CREATE TABLE `t_associates_studies` (
  `idAssociateStudy` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `year` year(4) NOT NULL DEFAULT '0000',
  `idTypeStudy` smallint(5) unsigned DEFAULT NULL,
  `idTypeAt` smallint(5) unsigned DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociateStudy`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeStudy` (`idTypeStudy`),
  KEY `idTypeAt` (`idTypeAt`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associates_studies_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_studies_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associates_studies_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_associates_studies_ibfk_4` FOREIGN KEY (`idTypeStudy`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_associates_studies_ibfk_5` FOREIGN KEY (`idTypeAt`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associations`;

CREATE TABLE `t_associations` (
  `idAssociation` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idProtocolRegistry` int(10) unsigned NOT NULL,
  `association` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `associationCode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `idRegion` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `idProvince` tinyint(3) unsigned DEFAULT NULL,
  `preposition` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `postalCode` char(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `province` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fiscalCode` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipaCode` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `officeCode` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `president` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociation`),
  KEY `idRegion` (`idRegion`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associations_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associations_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_associations_contacts`;

CREATE TABLE `t_associations_contacts` (
  `idAssociationContact` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `idTypeContact` tinyint(2) unsigned DEFAULT NULL COMMENT 'eMail, SitoWeb, Telefono, Fax',
  `contact` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idAssociationContact`),
  KEY `idAssociation` (`idAssociation`),
  KEY `idTypeContact` (`idTypeContact`),
  KEY `contact` (`contact`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_associations_contacts_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associations_contacts_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_associations_contacts_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_chapters`;

CREATE TABLE `t_chapters` (
  `idChapter` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `chapter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `chapterCode` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `chapterYear` year(4) NOT NULL DEFAULT '0000',
  `quotaYear` year(4) DEFAULT NULL,
  `prevision` double(11, 4) NOT NULL DEFAULT '0.0000',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idChapter`),
  UNIQUE KEY `chapterCode_ChapterYear` (`chapterCode`, `chapterYear`),
  KEY `quotaYear` (`quotaYear`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_chapters_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_chapters_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_companies`;

CREATE TABLE `t_companies` (
  `idCompany` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idProtocolRegistry` int(10) unsigned NOT NULL,
  `company` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCompany`),
  KEY `company` (`company`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_companies_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_companies_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_companies` (
    `idCompany`,
    `idProtocolRegistry`,
    `company`,
    `comments`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    0,
    'Customsoft di Zordan Marco',
    NULL,
    0,
    1,
    '2017-11-01 21:44:22',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_companies_address`;

CREATE TABLE `t_companies_address` (
  `idCompanyAddress` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idCompany` smallint(5) unsigned NOT NULL,
  `companyAddress` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `zipCode` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `province` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCompanyAddress`),
  KEY `idCompany` (`idCompany`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_companies_address_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_companies_address_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_companies_address_ibfk_3` FOREIGN KEY (`idCompany`) REFERENCES `t_companies` (`idCompany`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_companies_address` (
    `idCompanyAddress`,
    `idCompany`,
    `companyAddress`,
    `zipCode`,
    `city`,
    `province`,
    `comments`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    1,
    'Via Ghisa 41/A',
    '36071',
    'Arzignano',
    'VI',
    NULL,
    0,
    1,
    '2017-11-01 21:45:00',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_companies_tags`;

CREATE TABLE `t_companies_tags` (
  `idCompanyTag` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `idCompany` smallint(5) unsigned NOT NULL,
  `idTag` smallint(5) unsigned NOT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCompanyTag`),
  KEY `idTag` (`idTag`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idCompany` (`idCompany`),
  CONSTRAINT `t_companies_tags_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_companies_tags_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_companies_tags_ibfk_3` FOREIGN KEY (`idCompany`) REFERENCES `t_companies` (`idCompany`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_companies_tags` (
    `idCompanyTag`,
    `idCompany`,
    `idTag`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    1,
    18,
    0,
    1,
    '2016-12-31 23:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_councilors`;

CREATE TABLE `t_councilors` (
  `idCouncilor` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociate` mediumint(10) unsigned DEFAULT NULL,
  `idTypeSkill` smallint(5) unsigned DEFAULT NULL,
  `startCouncilor` date DEFAULT NULL,
  `endCouncilor` date DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idCouncilor`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idTypeSkill` (`idTypeSkill`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_councilors_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_councilors_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_councilors_ibfk_3` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_councilors_ibfk_4` FOREIGN KEY (`idTypeSkill`) REFERENCES `t_types_skills` (`idTypeSkill`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_documents_templates`;

CREATE TABLE `t_documents_templates` (
  `idDocumentTemplate` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `idDocumentTemplateType` smallint(5) unsigned DEFAULT NULL,
  `title` varchar(100) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `numberFields` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idDocumentTemplate`),
  KEY `idAssociation` (`idAssociation`),
  KEY `idDocumentTemplateType` (`idDocumentTemplateType`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_documents_templates_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_documents_templates_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_documents_templates_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_documents_templates_ibfk_4` FOREIGN KEY (`idDocumentTemplateType`) REFERENCES `t_types_standard` (`idTypeStandard`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_documents_templates_text`;

CREATE TABLE `t_documents_templates_text` (
  `idDocumentTemplate` smallint(5) unsigned NOT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `sql` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  `neededFields` text CHARACTER SET latin1 COLLATE latin1_bin NOT NULL,
  PRIMARY KEY (`idDocumentTemplate`),
  CONSTRAINT `t_documents_templates_text_ibfk_1` FOREIGN KEY (`idDocumentTemplate`) REFERENCES `t_documents_templates` (`idDocumentTemplate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_events`;

CREATE TABLE `t_events` (
  `idEvent` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `event` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `descriptionEvent` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `startEvent` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `endEvent` timestamp NULL DEFAULT NULL,
  `eventPlace` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `seats` smallint(5) unsigned NOT NULL DEFAULT '0',
  `enrollBy` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `price` float DEFAULT NULL,
  `enrollWeb` char(0) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idEvent`),
  KEY `idAssociation` (`idAssociation`),
  KEY `event` (`event`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_events_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_events_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_events_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_events_subscribers`;

CREATE TABLE `t_events_subscribers` (
  `idEventsSubscribers` int(10) unsigned NOT NULL DEFAULT '0',
  `idEvent` smallint(5) unsigned DEFAULT NULL,
  `idAssociate` mediumint(8) unsigned DEFAULT NULL,
  `status` smallint(5) DEFAULT '0',
  `dataConferma` timestamp NULL DEFAULT NULL,
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idEventsSubscribers`),
  KEY `idAssociate` (`idAssociate`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idEvent` (`idEvent`),
  CONSTRAINT `t_events_subscribers_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_events_subscribers_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_events_subscribers_ibfk_3` FOREIGN KEY (`idEvent`) REFERENCES `t_events` (`idEvent`),
  CONSTRAINT `t_events_subscribers_ibfk_4` FOREIGN KEY (`idAssociate`) REFERENCES `t_associates` (`idAssociate`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_faq`;

CREATE TABLE `t_faq` (
  `idFaq` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `question` text COLLATE utf8mb4_unicode_ci,
  `answer` text COLLATE utf8mb4_unicode_ci,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idFaq`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_faq_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_faq_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_fast_links`;

CREATE TABLE `t_fast_links` (
  `idFastLink` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `fast_link` tinytext COLLATE utf8mb4_unicode_ci,
  `fast_linkDescription` text COLLATE utf8mb4_unicode_ci,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idFastLink`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_fast_links_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_guides`;

CREATE TABLE `t_guides` (
  `idGuide` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `guide` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idGuide`),
  KEY `title` (`title`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_guides_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_guides_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_hotstudio_registry`;

CREATE TABLE `t_hotstudio_registry` (
  `iDAZ` int(10) unsigned NOT NULL DEFAULT '0',
  `tIPO` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `HS_RAGSOCIALE` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `HS_INDIRIZZO` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `HS_CAP` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `nOTE` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `HS_LOCALITA` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`iDAZ`, `tIPO`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_import_fc`;

CREATE TABLE `t_import_fc` (
  `idImportFC` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ordine` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sezione` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `primaIscrizione` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `dataIscrizione` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `numeroIscrizione` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `dataIscrizB` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `numIscrizB` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `stato` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cognome` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `nome` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sesso` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `luogoNascita` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `dataNascita` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `codiceFiscale` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sospeso` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tarLazio` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `occupazione` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancellato` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nullaOstaAlTrasferimento` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `espulso` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pubblicoDipendente` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idValutazione` tinyint(1) unsigned DEFAULT NULL,
  `idOperatore` int(10) unsigned DEFAULT NULL,
  `dataModifica` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idImportFC`),
  UNIQUE KEY `ordine_codice fiscale` (`ordine`, `codiceFiscale`),
  KEY `idValutazione` (`idValutazione`),
  KEY `idOperatore` (`idOperatore`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_import_fc_address`;

CREATE TABLE `t_import_fc_address` (
  `idImportFCAddress` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idImportFC` int(10) unsigned NOT NULL DEFAULT '0',
  `tipoIndirizzo` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `indirizzo` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `frazione` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cap` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `comune` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `provincia` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `idValutazione` tinyint(1) unsigned DEFAULT NULL,
  `idOperatore` int(10) unsigned DEFAULT NULL,
  `dataModifica` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idImportFCAddress`),
  UNIQUE KEY `idFormContImport_TipoIndirizzo_Indirizzo_Cap` (
    `idImportFC`,
    `tipoIndirizzo`,
    `indirizzo`,
    `cap`
  ),
  KEY `idImportFC` (`idImportFC`),
  KEY `tipoIndirizzo` (`tipoIndirizzo`),
  KEY `idValutazione` (`idValutazione`),
  KEY `idOperatore` (`idOperatore`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_import_fc_contacts`;

CREATE TABLE `t_import_fc_contacts` (
  `idImportFCContact` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idImportFC` int(10) unsigned NOT NULL DEFAULT '0',
  `tipoRecapito` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `recapito` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `annotazione` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idValutazione` tinyint(1) unsigned DEFAULT NULL,
  `idOperatore` int(10) unsigned DEFAULT NULL,
  `dataModifica` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idImportFCContact`),
  UNIQUE KEY `idFormContImport_Recapito` (`idImportFC`, `recapito`),
  KEY `idImportFC` (`idImportFC`),
  KEY `tipoRecapito` (`tipoRecapito`),
  KEY `idValutazione` (`idValutazione`),
  KEY `idOperatore` (`idOperatore`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_import_fc_recapiti`;

CREATE TABLE `t_import_fc_recapiti` (
  `idFormContImportRecapito` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idFormContImport` int(10) unsigned NOT NULL DEFAULT '0',
  `tipoRecapito` char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `recapito` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `annotazione` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idValutazione` tinyint(1) unsigned DEFAULT NULL,
  `idOperatore` int(10) unsigned DEFAULT NULL,
  `dataModifica` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idFormContImportRecapito`),
  UNIQUE KEY `idFormContImport_Recapito` (`idFormContImport`, `recapito`),
  KEY `idFormContImport` (`idFormContImport`),
  KEY `tipoRecapito` (`tipoRecapito`),
  KEY `idValutazione` (`idValutazione`),
  KEY `idOperatore` (`idOperatore`)
) ENGINE = MyISAM DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_log_connections`;

CREATE TABLE `t_log_connections` (
  `idLogConnection` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `dateConnection` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipConnection` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`idLogConnection`),
  KEY `idUser` (`idUser`),
  KEY `ipConnection` (`ipConnection`),
  CONSTRAINT `t_log_connections_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `t_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_log_searches`;

CREATE TABLE `t_log_searches` (
  `idInfoSearch` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `search` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `numberSearch` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idInfoSearch`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `created` (`created`),
  KEY `modified` (`modified`),
  KEY `idAssociation` (`idAssociation`),
  CONSTRAINT `t_log_searches_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_log_searches_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_log_searches_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_notes`;

CREATE TABLE `t_notes` (
  `idNote` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idSender` mediumint(8) unsigned DEFAULT NULL,
  `receptionDate` timestamp NULL DEFAULT NULL,
  `guid` varchar(17) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idNote`),
  KEY `idSender` (`idSender`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_notes_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_notes_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_notes_ibfk_3` FOREIGN KEY (`idSender`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_sessions`;

CREATE TABLE `t_sessions` (
  `idSession` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `verbalNumber` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateSession` date DEFAULT NULL,
  `text` text COLLATE utf8mb4_unicode_ci,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idSession`),
  UNIQUE KEY `verbalNumber_DateSession` (`verbalNumber`, `dateSession`),
  KEY `idAssociation` (`idAssociation`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_sessions_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_sessions_councilors`;

CREATE TABLE `t_sessions_councilors` (
  `idSessionCouncilor` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `idCouncilor` smallint(5) unsigned DEFAULT NULL,
  `idSession` mediumint(8) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idSessionCouncilor`),
  UNIQUE KEY `idCouncilor_IdSession` (`idCouncilor`, `idSession`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idSession` (`idSession`),
  CONSTRAINT `t_sessions_councilors_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_councilors_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_councilors_ibfk_3` FOREIGN KEY (`idCouncilor`) REFERENCES `t_councilors` (`idCouncilor`),
  CONSTRAINT `t_sessions_councilors_ibfk_4` FOREIGN KEY (`idSession`) REFERENCES `t_sessions` (`idSession`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_sessions_deliberations`;

CREATE TABLE `t_sessions_deliberations` (
  `idSessionDeliberation` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `idSession` mediumint(8) unsigned NOT NULL,
  `deliberationNumber` smallint(5) unsigned NOT NULL,
  `deliberationYear` year(4) NOT NULL,
  `deliberationObject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `startTime` time DEFAULT NULL,
  `endTime` time DEFAULT NULL,
  `deliberationPreface` text COLLATE utf8mb4_unicode_ci,
  `deliberationText` text COLLATE utf8mb4_unicode_ci,
  `idCreator` mediumint(8) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idSessionDeliberation`),
  KEY `idSession` (`idSession`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `deliberationNumber` (`deliberationNumber`),
  KEY `deliberationYear` (`deliberationYear`),
  KEY `created` (`created`),
  KEY `modified` (`modified`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_sessions_deliberations_ibfk_1` FOREIGN KEY (`idSession`) REFERENCES `t_sessions` (`idSession`),
  CONSTRAINT `t_sessions_deliberations_ibfk_2` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_deliberations_ibfk_3` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_sessions_deliberations_councilors`;

CREATE TABLE `t_sessions_deliberations_councilors` (
  `idSessionDeliberationCouncilor` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idSessionDeliberation` int(10) unsigned NOT NULL,
  `idCouncilor` smallint(5) unsigned NOT NULL,
  `sortField` smallint(5) unsigned DEFAULT NULL,
  `idCreator` mediumint(8) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idSessionDeliberationCouncilor`),
  KEY `idCouncilor` (`idCouncilor`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  CONSTRAINT `t_sessions_deliberations_councilors_ibfk_1` FOREIGN KEY (`idCouncilor`) REFERENCES `t_councilors` (`idCouncilor`),
  CONSTRAINT `t_sessions_deliberations_councilors_ibfk_2` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_sessions_deliberations_councilors_ibfk_3` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_sessions_deliberations_revisions`;

CREATE TABLE `t_sessions_deliberations_revisions` (
  `idSessionDeliberationRevision` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idSessionDeliberation` mediumint(8) unsigned NOT NULL,
  `typeDeliberationText` tinyint(1) unsigned DEFAULT NULL COMMENT '1 = Preface, 2 = Text',
  `deliberationText` text COLLATE utf8mb4_unicode_ci,
  `idCreator` mediumint(8) unsigned NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idSessionDeliberationRevision`),
  KEY `idSessionDeliberation` (`idSessionDeliberation`),
  KEY `idCreator` (`idCreator`),
  KEY `typeDeliberationText` (`typeDeliberationText`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_sessions_deliberations_revisions_ibfk_1` FOREIGN KEY (`idSessionDeliberation`) REFERENCES `t_sessions_deliberations` (`idSessionDeliberation`),
  CONSTRAINT `t_sessions_deliberations_revisions_ibfk_2` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_templates`;

CREATE TABLE `t_templates` (
  `idTemplate` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idTemplate`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_templates` (
    `idTemplate`,
    `template`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    '01default',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    '02ace',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_tips`;

CREATE TABLE `t_tips` (
  `idTip` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `titleTip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `tip` text COLLATE utf8mb4_unicode_ci,
  `scriptJS` text COLLATE utf8mb4_unicode_ci,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idTip`),
  KEY `titleTip` (`titleTip`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_tribute_record`;

CREATE TABLE `t_tribute_record` (
  `idTributeRecord` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `associationFiscalCode` varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `associationName` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `associationAddress` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `associationPostalCode` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `associationCity` varchar(35) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `associationProvince` char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `year` year(4) NOT NULL DEFAULT '0000',
  `dateLastSend` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idTributeRecord`),
  KEY `idAssociation` (`idAssociation`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_tribute_record_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_tribute_record_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_tribute_record_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_types_skills`;

CREATE TABLE `t_types_skills` (
  `idTypeSkill` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `typeSkill` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `idTypeSkillRole` tinyint(3) unsigned DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idTypeSkill`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idTypeSkillRole` (`idTypeSkillRole`),
  CONSTRAINT `t_types_skills_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_types_skills_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_types_skills_ibfk_3` FOREIGN KEY (`idTypeSkillRole`) REFERENCES `t_types_skills_roles` (`idTypeSkillRole`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_types_skills` (
    `idTypeSkill`,
    `typeSkill`,
    `idTypeSkillRole`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    'Presidente',
    NULL,
    0,
    1,
    '2017-12-07 17:16:30',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    'Consigliere',
    NULL,
    0,
    1,
    '2017-12-07 17:16:35',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_types_skills_roles`;

CREATE TABLE `t_types_skills_roles` (
  `idTypeSkillRole` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `tipesSkillRole` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortField` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idTypeSkillRole`),
  KEY `sortField` (`sortField`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_types_standard`;

CREATE TABLE `t_types_standard` (
  `idTypeStandard` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idTypeStandardCategory` tinyint(3) unsigned NOT NULL,
  `typeStandard` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idTypeStandard`),
  KEY `idTypeStandardCategory` (`idTypeStandardCategory`),
  KEY `typeStandard` (`typeStandard`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_types_standard_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_types_standard_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_types_standard_ibfk_3` FOREIGN KEY (`idTypeStandardCategory`) REFERENCES `t_types_standard_categories` (`idTypeStandardCategory`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_types_standard` (
    `idTypeStandard`,
    `idTypeStandardCategory`,
    `typeStandard`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    30,
    'Residenza',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    30,
    'Domicilio',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    3,
    30,
    'Lavoro',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    4,
    30,
    'Parente',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    5,
    30,
    'Riferimento Posta',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    6,
    30,
    'Senza dimora',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    7,
    70,
    'Email',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    8,
    70,
    'PEC',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    9,
    70,
    'Telefono',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    10,
    70,
    'Fax',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    11,
    70,
    'Sito web',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    12,
    70,
    'Facebook',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    13,
    70,
    'Telegram',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    14,
    31,
    'Sede legale',
    0,
    1,
    '2017-11-01 21:47:53',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    15,
    31,
    'Sede operativa',
    0,
    1,
    '2017-11-01 21:48:02',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    17,
    31,
    'Magazzino',
    0,
    1,
    '2017-11-01 21:48:35',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    18,
    60,
    'Fornitore',
    0,
    1,
    '2017-11-01 21:50:42',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    19,
    60,
    'Università',
    0,
    1,
    '2017-11-01 21:50:51',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    20,
    60,
    'Ordine regionale',
    0,
    1,
    '2017-11-01 21:51:53',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    21,
    60,
    'Comune',
    0,
    1,
    '2017-11-01 21:52:03',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    22,
    60,
    'ULSS',
    0,
    1,
    '2017-11-01 21:52:15',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    23,
    60,
    'Regione',
    0,
    1,
    '2017-11-01 21:53:08',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    24,
    60,
    'Associazione',
    0,
    1,
    '2017-11-01 21:53:28',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    25,
    110,
    'Home',
    1,
    1,
    '2017-11-28 22:15:06',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    26,
    110,
    'Registri anagrafici',
    2,
    1,
    '2017-11-28 22:15:21',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    27,
    110,
    'Registri protocollo',
    7,
    1,
    '2017-11-28 22:15:54',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    28,
    110,
    'Impostazioni generali',
    3,
    1,
    '2017-11-28 22:16:21',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    29,
    110,
    'Impostazioni utente',
    4,
    1,
    '2017-11-28 22:16:36',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    30,
    110,
    'Impostazioni tipi',
    6,
    1,
    '2017-11-28 22:16:46',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    31,
    110,
    'Attività',
    5,
    1,
    '2017-11-28 22:16:55',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    32,
    110,
    'Contabilità',
    5,
    1,
    '2017-11-28 22:16:55',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    33,
    110,
    'Utilità',
    5,
    1,
    '2017-11-28 22:16:55',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    34,
    110,
    'Report',
    5,
    1,
    '2017-11-28 22:16:55',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    35,
    110,
    'Atti amministrativi',
    0,
    2,
    '2017-12-06 22:30:49',
    2,
    '2017-12-06 21:41:00',
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_types_standard_categories`;

CREATE TABLE `t_types_standard_categories` (
  `idTypeStandardCategory` tinyint(3) unsigned NOT NULL,
  `typeStandardCategory` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `readOnly` char(0) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`idTypeStandardCategory`),
  KEY `sortField` (`sortField`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_types_standard_categories` (
    `idTypeStandardCategory`,
    `typeStandardCategory`,
    `readOnly`,
    `sortField`
  )
VALUES
  (10, 'TypeAccountingBook', '', 5),
  (20, 'TypeAtStructure', '', 10),
  (30, 'TypeAddress', '', 6),
  (31, 'TypeAddressCompany', '', 7),
  (50, 'TypeCancellationReason', '', 8),
  (60, 'TypeCompany', '', 1),
  (70, 'TypeContact', '', 11),
  (80, 'TypeEmployer', '', 4),
  (90, 'TypeEmploymentRelationship', '', 3),
  (110, 'TypePage', '', 9),
  (120, 'TypeSanction', '', 12),
  (130, 'TypeStudy', '', 13),
  (140, 'TypeStudyTitle', '', 14),
  (150, 'TypeValidation', '', 2);

DROP TABLE IF EXISTS `t_users`;

CREATE TABLE `t_users` (
  `idUser` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `idProtocolRegistry` int(10) unsigned NOT NULL,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `user` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `ldapUser` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fullName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `passwordMustChange` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0 = Not change - 1 = Must change - 2 = locked change',
  `passwordChangedDate` date DEFAULT NULL,
  `recoveryKey` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userPermission` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1 = Guest - 3 = Editor  - 5 = Super Editor - 7 = Admin - 9 = SuperAdmin',
  `activeFrom` timestamp NULL DEFAULT NULL,
  `activeTo` timestamp NULL DEFAULT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idTemplate` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `hourlyCost` float(6, 2) unsigned NOT NULL DEFAULT '0.00',
  `idTips` smallint(5) unsigned DEFAULT NULL,
  `comments` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `optionsFlags` int(10) unsigned DEFAULT '0',
  `rowsPerPage` tinyint(3) unsigned DEFAULT NULL,
  `cookieSession` int(10) unsigned DEFAULT NULL,
  `wrongAccess` tinyint(1) unsigned DEFAULT NULL,
  `dateLockedUser` timestamp NULL DEFAULT NULL,
  `idUserProtocol` smallint(5) unsigned NOT NULL DEFAULT '0',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE KEY `user` (`user`),
  KEY `idAssociation` (`idAssociation`),
  KEY `password` (`password`),
  KEY `idTemplate` (`idTemplate`),
  KEY `idTips` (`idTips`),
  KEY `idUserProtocol` (`idUserProtocol`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_users_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `t_users_ibfk_4` FOREIGN KEY (`idTemplate`) REFERENCES `t_templates` (`idTemplate`),
  CONSTRAINT `t_users_ibfk_5` FOREIGN KEY (`idTips`) REFERENCES `t_tips` (`idTip`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_emails`;

CREATE TABLE `t_users_emails` (
  `idUserEmail` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserEmail`),
  UNIQUE KEY `email` (`email`),
  KEY `idUser` (`idUser`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_users_emails_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_emails_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_emails_ibfk_4` FOREIGN KEY (`idUser`) REFERENCES `t_users` (`idUser`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_emails_verification`;

CREATE TABLE `t_users_emails_verification` (
  `idUserEmailVerification` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idUserEmail` smallint(5) unsigned DEFAULT NULL,
  `verificationCode` char(32) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` timestamp NULL DEFAULT NULL,
  `lastStatus` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dateLastStatus` timestamp NULL DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserEmailVerification`),
  KEY `idUserEmail` (`idUserEmail`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_groups`;

CREATE TABLE `t_users_groups` (
  `idUserGroup` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idAssociation` smallint(5) unsigned DEFAULT NULL,
  `userGroup` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserGroup`),
  KEY `userGroup` (`userGroup`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idAssociation` (`idAssociation`),
  CONSTRAINT `t_users_groups_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_ibfk_3` FOREIGN KEY (`idAssociation`) REFERENCES `t_associations` (`idAssociation`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_users_groups` (
    `idUserGroup`,
    `idAssociation`,
    `userGroup`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    NULL,
    'Admins',
    0,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    NULL,
    'Pubblico',
    0,
    1,
    '2017-11-15 15:22:53',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    3,
    6,
    'Amministrazione',
    1,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    4,
    6,
    'Consiglieri',
    2,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    5,
    6,
    'Formazione',
    1,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    6,
    6,
    'Segreteria',
    1,
    1,
    '2017-01-01 00:00:00',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_users_groups_pages`;

CREATE TABLE `t_users_groups_pages` (
  `idUserGroupPage` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idUserPage` smallint(5) unsigned NOT NULL,
  `idUserGroup` smallint(5) unsigned NOT NULL,
  `userRole` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 = Guest - 3 = Editor - 5 = Super Editor - 7 = Admin - 9 = SuperAdmin ',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserGroupPage`),
  KEY `idUserPage` (`idUserPage`),
  KEY `idUserGroup` (`idUserGroup`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_users_groups_pages_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_pages_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_pages_ibfk_3` FOREIGN KEY (`idUserGroup`) REFERENCES `t_users_groups` (`idUserGroup`),
  CONSTRAINT `t_users_groups_pages_ibfk_4` FOREIGN KEY (`idUserPage`) REFERENCES `t_users_pages` (`idUserPage`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_users_groups_pages` (
    `idUserGroupPage`,
    `idUserPage`,
    `idUserGroup`,
    `userRole`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    1,
    2,
    1,
    1,
    '2017-11-15 15:24:19',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    2,
    2,
    1,
    1,
    '2017-11-15 16:05:29',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    4,
    3,
    3,
    3,
    1,
    '2017-11-15 16:06:51',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    5,
    3,
    4,
    3,
    1,
    '2017-11-15 16:07:28',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    6,
    3,
    5,
    3,
    1,
    '2017-11-15 16:07:47',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    7,
    3,
    6,
    5,
    1,
    '2017-11-15 16:07:58',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    8,
    17,
    1,
    9,
    1,
    '2017-11-15 21:51:02',
    2,
    '2017-12-04 22:17:23',
    NULL,
    NULL
  ),
  (
    9,
    16,
    1,
    0,
    2,
    '2017-11-29 23:19:24',
    2,
    '2017-12-01 22:22:52',
    NULL,
    NULL
  ),
  (
    12,
    15,
    1,
    0,
    2,
    '2017-12-01 12:37:23',
    2,
    '2017-12-04 22:20:59',
    NULL,
    NULL
  ),
  (
    14,
    18,
    1,
    0,
    1,
    '2017-12-01 13:41:47',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    15,
    19,
    1,
    0,
    1,
    '2017-12-01 13:42:13',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    16,
    20,
    1,
    0,
    1,
    '2017-12-01 13:42:31',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    17,
    23,
    1,
    1,
    1,
    '2017-12-01 22:55:51',
    2,
    '2017-12-01 22:12:23',
    NULL,
    NULL
  ),
  (
    18,
    8,
    6,
    0,
    2,
    '2017-12-01 23:27:51',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    19,
    4,
    6,
    0,
    2,
    '2017-12-01 23:28:17',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    20,
    5,
    6,
    0,
    2,
    '2017-12-01 23:28:27',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    21,
    7,
    6,
    0,
    2,
    '2017-12-01 23:28:37',
    2,
    '2017-12-02 13:31:09',
    NULL,
    NULL
  ),
  (
    22,
    24,
    1,
    1,
    1,
    '2017-12-01 22:55:51',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    23,
    4,
    3,
    0,
    2,
    '2017-12-06 17:05:04',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    25,
    3,
    1,
    0,
    2,
    '2017-12-06 17:11:48',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    27,
    21,
    1,
    0,
    2,
    '2017-12-06 21:51:22',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    28,
    29,
    1,
    0,
    2,
    '2017-12-06 22:44:10',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    29,
    28,
    1,
    0,
    2,
    '2017-12-06 22:44:33',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    30,
    30,
    1,
    0,
    2,
    '2017-12-07 22:18:31',
    NULL,
    NULL,
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_users_groups_users`;

CREATE TABLE `t_users_groups_users` (
  `idUserGroupUser` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned NOT NULL,
  `idUserGroup` smallint(5) unsigned NOT NULL,
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserGroupUser`),
  KEY `idUser` (`idUser`),
  KEY `idUserGroup` (`idUserGroup`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  CONSTRAINT `t_users_groups_users_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_users_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_users_ibfk_3` FOREIGN KEY (`idUser`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_groups_users_ibfk_4` FOREIGN KEY (`idUserGroup`) REFERENCES `t_users_groups` (`idUserGroup`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_logins`;

CREATE TABLE `t_users_logins` (
  `idUserLogin` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `successLogin` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `idUser` mediumint(8) unsigned DEFAULT NULL,
  `userName` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipAddress` int(10) unsigned DEFAULT NULL,
  `userAgent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUserLogin`),
  KEY `idUser` (`idUser`),
  KEY `ipAddressFailedLogin` (`ipAddress`),
  KEY `created` (`created`),
  KEY `successLogin` (`successLogin`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_logins_remember`;

CREATE TABLE `t_users_logins_remember` (
  `idUserLoginRemember` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idUser` mediumint(8) unsigned DEFAULT NULL,
  `token` char(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `userAgent` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUserLoginRemember`),
  KEY `idUser` (`idUser`),
  KEY `token` (`token`),
  KEY `created` (`created`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `t_users_pages`;

CREATE TABLE `t_users_pages` (
  `idUserPage` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `idParentPage` smallint(5) unsigned DEFAULT NULL,
  `idTypePage` smallint(5) unsigned DEFAULT NULL,
  `page` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `accessKey` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `idStatus` enum('maintenance', 'active', 'hidden') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `namePage` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `urlPage` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actionsPage` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '[''index'',''search'',''edit'',''create'',''delete'',''changePassword'']',
  `shortDescription` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longDescription` text COLLATE utf8mb4_unicode_ci,
  `defaultFilter` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sortField` smallint(5) unsigned NOT NULL DEFAULT '0',
  `idCreator` mediumint(8) unsigned NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idModifier` mediumint(8) unsigned DEFAULT NULL,
  `modified` timestamp NULL DEFAULT NULL,
  `archived` timestamp NULL DEFAULT NULL,
  `deleted` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`idUserPage`),
  KEY `idUserPage` (`idUserPage`),
  KEY `idParentPage` (`idParentPage`),
  KEY `idTypePage` (`idTypePage`),
  KEY `sortField` (`sortField`),
  KEY `idCreator` (`idCreator`),
  KEY `idModifier` (`idModifier`),
  KEY `archived` (`archived`),
  KEY `deleted` (`deleted`),
  KEY `idStatus` (`idStatus`),
  CONSTRAINT `t_users_pages_ibfk_1` FOREIGN KEY (`idCreator`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_pages_ibfk_2` FOREIGN KEY (`idModifier`) REFERENCES `t_users` (`idUser`),
  CONSTRAINT `t_users_pages_ibfk_3` FOREIGN KEY (`idTypePage`) REFERENCES `t_types_standard` (`idTypeStandard`),
  CONSTRAINT `t_users_pages_ibfk_5` FOREIGN KEY (`idParentPage`) REFERENCES `t_users_pages` (`idUserPage`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT INTO
  `t_users_pages` (
    `idUserPage`,
    `idParentPage`,
    `idTypePage`,
    `page`,
    `accessKey`,
    `idStatus`,
    `namePage`,
    `urlPage`,
    `actionsPage`,
    `shortDescription`,
    `longDescription`,
    `defaultFilter`,
    `sortField`,
    `idCreator`,
    `created`,
    `idModifier`,
    `modified`,
    `archived`,
    `deleted`
  )
VALUES
  (
    1,
    NULL,
    25,
    'Home',
    'H',
    'active',
    'index',
    '/',
    '[\"index\"]',
    'DescriptionHomePage',
    '',
    '',
    1,
    2,
    '2017-11-15 15:18:42',
    2,
    '2017-12-06 18:34:37',
    NULL,
    NULL
  ),
  (
    2,
    NULL,
    25,
    'About',
    '',
    'active',
    'about',
    '/about',
    '[\"index\"]',
    'DescriptionAboutPage',
    '',
    '',
    2,
    1,
    '2017-11-15 15:28:09',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    3,
    NULL,
    25,
    'Dashboard',
    'B',
    'hidden',
    'dashboard',
    '/be/dashboard',
    '[\"index\",\"settings\"]',
    'DescriptionDashboardPage',
    '',
    '',
    3,
    2,
    '2017-11-15 15:31:09',
    2,
    '2017-12-07 08:49:12',
    NULL,
    NULL
  ),
  (
    4,
    8,
    26,
    'AssociatesRegistry',
    'I',
    'active',
    't_associates',
    '/be/t_associates/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionAssociatesPage',
    'Tramite questa sezione è possibile cercare, modificare o aggiungere nuovi iscritti alla banca dati. Si possono aggiungere e gestire i recapiti, indirizzi, le quote, i documenti, le email, e molto altro degli iscritti.',
    'A%',
    5,
    2,
    '2017-11-29 10:04:20',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    5,
    8,
    26,
    'AssociationsRegistry',
    'O',
    'active',
    't_associations',
    '/be/t_associations/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionAssociationsPage',
    'Tramite questa sezione è possibile cercare, modificare o aggiungere nuovi Ordini Regionali alla banca dati. Si possono aggiungere e gestire i recapiti, indirizzi, i documenti, le email, e molto altro degli altri Ordini.',
    '',
    6,
    2,
    '2017-11-29 11:04:08',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    6,
    8,
    26,
    'CompaniesRegistry',
    'A',
    'active',
    't_companies',
    '/be/t_companies/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionCompaniesPage',
    'Tramite questa sezione è possibile cercare, modificare o aggiungere nuove aziende alla banca dati. Si possono aggiungere e gestire i recapiti, indirizzi, i documenti, le email, e molto altro delle aziende fornitrici o in contatto con l\'Ordine.',
    'A%',
    7,
    2,
    '2017-11-29 11:19:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    7,
    8,
    27,
    'ProtocolRegistry',
    'P',
    'active',
    't_protocol',
    '/be/t_t_protocol/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionProtocolPage',
    'Tramite questa sezione è possibile cercare, modificare o aggiungere nuovi protocolli alla banca dati.',
    'A%',
    8,
    2,
    '2017-11-29 11:19:00',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    8,
    NULL,
    26,
    'Registries',
    '',
    'active',
    'registries',
    '',
    '[]',
    'DescriptionRegistriesPage',
    '',
    '',
    8,
    2,
    '2017-11-29 14:22:47',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    15,
    NULL,
    28,
    'Settings',
    '',
    'active',
    'settings',
    '',
    '[\"general\",\"savegeneral\",\"mysql\",\"savemysql\"]',
    'DescriptionSettingsPage',
    '',
    '',
    8,
    2,
    '2017-11-29 14:22:47',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    16,
    15,
    28,
    'General',
    'G',
    'active',
    'general',
    '/be/settings/general',
    '[\"general\",\"savegeneral\"]',
    'DescriptionGeneralPage',
    '',
    '',
    9,
    2,
    '2017-11-29 14:24:17',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    17,
    15,
    28,
    'Mysql',
    'M',
    'active',
    'mysql',
    '/be/settings/mysql',
    '[\"mysql\",\"savemysql\"]',
    'DescriptionMysqlPage',
    '',
    '',
    10,
    2,
    '2017-11-29 14:26:06',
    NULL,
    NULL,
    '2017-12-06 10:24:28',
    NULL
  ),
  (
    18,
    15,
    29,
    'Users',
    'U',
    'active',
    't_users',
    '/be/t_users/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionUsersPage',
    '',
    '',
    11,
    2,
    '2017-11-29 14:27:55',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    19,
    15,
    29,
    'Groups',
    'R',
    'active',
    't_users_groups',
    '/be/t_users_groups/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionGroupsPage',
    '',
    '',
    12,
    2,
    '2017-11-29 14:31:57',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    20,
    15,
    29,
    'Pages',
    'P',
    'active',
    't_users_pages',
    '/be/t_users_pages/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionPagesPage',
    '',
    '',
    13,
    2,
    '2017-11-29 14:35:03',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    21,
    15,
    30,
    'TypesStandard',
    'T',
    'active',
    't_types_standard',
    '/be/t_types_standard/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionTypesStandardPage',
    '',
    '',
    14,
    2,
    '2017-11-29 14:40:47',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    22,
    21,
    30,
    'TypeAccountingBook',
    '',
    'active',
    't_types_standard',
    '/be/t_types_standard/search?type=10',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionTypeAccountingBookPage',
    '',
    '',
    15,
    2,
    '2017-11-29 14:55:36',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    23,
    15,
    29,
    'GroupsPages',
    '',
    'hidden',
    't_users_groups_pages',
    '/be/t_users_groups_pages/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"new_page\",\"create_page\",\"edit_page\",\"save_page\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionGroupsPagesPage',
    '',
    '',
    12,
    2,
    '2017-11-29 14:31:57',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    24,
    15,
    29,
    'GroupsUsers',
    '',
    'hidden',
    't_users_groups_users',
    '/be/t_users_groups_users/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"new_user\",\"create_user\",\"edit_user\",\"save_user\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionGroupsUsersPage',
    '',
    '',
    12,
    2,
    '2017-11-29 14:31:57',
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    28,
    NULL,
    35,
    'AdministrativeActs',
    '',
    'active',
    'administrative_acts',
    '',
    '[]',
    'DescriptionAdministrativeActs',
    '',
    '',
    0,
    2,
    '2017-12-06 21:50:55',
    2,
    '2017-12-06 21:46:38',
    NULL,
    NULL
  ),
  (
    29,
    28,
    35,
    'Sessions',
    '',
    'active',
    't_sessions',
    '/be/t_sessions/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionSessionsPage',
    '',
    '',
    0,
    2,
    '2017-12-06 22:43:49',
    2,
    '2017-12-06 21:44:55',
    NULL,
    NULL
  ),
  (
    30,
    29,
    35,
    'SessionsCouncilors',
    '',
    'active',
    't_sessions_councilors',
    '/be/t_sessions_councilors/search',
    '[\"search\",\"new\",\"edit\",\"save\",\"create\",\"delete\",\"archive\",\"undelete\",\"unarchive\",\"destroy\"]',
    'DescriptionSessionsCouncilorsPage',
    '',
    '',
    0,
    2,
    '2017-12-07 22:18:21',
    2,
    '2017-12-07 21:38:09',
    NULL,
    NULL
  );

DROP TABLE IF EXISTS `t_users_statistics`;

CREATE TABLE `t_users_statistics` (
  `idUserStatistics` mediumint(8) unsigned NOT NULL,
  `idUsers` mediumint(8) unsigned NOT NULL,
  `postEmailNotifyEcc` int(11) NOT NULL,
  KEY `idUsers` (`idUsers`),
  CONSTRAINT `t_users_statistics_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `t_users` (`idUser`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;