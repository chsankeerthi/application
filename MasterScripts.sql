

CREATE DATABASE ovaledgedb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER 'ovaledge'@'localhost' IDENTIFIED BY '0valEdge!' ;
CREATE USER 'ovaledge'@'%' IDENTIFIED BY '0valEdge!' ;
GRANT ALL ON ovaledgedb.* TO 'ovaledge'@'localhost';
GRANT ALL ON ovaledgedb.* TO 'ovaledge'@'%';

USE ovaledgedb;


CREATE TABLE `a_dataset` (
  `datasetid` int NOT NULL,
  `datasetname` varchar(256),
  `description` mediumtext,
  `query` mediumtext,
  `outputdb` varchar(255),
  `businessglossaryid` int(11),
  `outputtable` varchar(256),
  `saved` tinyint(4) ,
  `status` varchar(50),
  `userid` varchar(50),
  `lastmoddate` timestamp NULL ,
  `createdate` timestamp NULL ,
  `subquery` tinyint(2) NOT NULL DEFAULT '0',
  `isbatch` tinyint(4) DEFAULT '1',
  `append` tinyint(2) NOT NULL DEFAULT '0',
  `jobtype` varchar(255),
  `sourceids` varchar(15),
  `destids` varchar(15),
  `projid` varchar(20),
  `connectioninfoid` int(11),
  `userselecteddb` varchar(1000),
  `sqltype` tinyint(4) DEFAULT '0',
  `tagrelease` tinyint(4) DEFAULT '0',
  `loadfileid` int(11),
  `analysismsg` longtext,
  `parentdatasetid` int(11),
  `pkdata` longtext,
  `packageid` varchar(50),
  `filedownloaded` tinyint(4),
  `result` text,
  `active` tinyint(4),
  `creatorid` int(11),
  `creatortype` varchar(50),
  impactobjectid int(11),
  impactobjecttype varchar(10),
  `auditdate` timestamp NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `sourcecodeid` int(11) DEFAULT NULL,
  `jobstepid` int(11) DEFAULT NULL,
  `outputready` tinyint(1) DEFAULT '0',
  `lineagestatus` varchar(100)  DEFAULT NULL COMMENT 'This column is to store lineagestatus of lineage (RDMS)',
  `owner` varchar(50)   DEFAULT NULL,
  `steward` varchar(50) DEFAULT NULL,
  isxml tinyint DEFAULT 0,
  `version` int(11) not null default 1,
  `lastlineagerundate` timestamp NULL DEFAULT NULL COMMENT 'This column is to store lastlineagerundate of lineage (RDMS) for archive table',
  `lastqueryrundate` timestamp NULL DEFAULT NULL COMMENT 'This column is to store lastqueryrundate of queryexcution for archive table',
   dqindex double default null COMMENT 'This is for the data quality index'
) ENGINE=InnoDB;


CREATE TABLE `a_datasetassociation` (
  `datasetassociationid` int(11) NOT NULL,
  `datasetid` int(11) DEFAULT NULL,
  `assobject` varchar(30) DEFAULT NULL,
  `assobjectid` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  reftype text NULL DEFAULT NULL,
  refcode varchar(255)  NULL DEFAULT NULL,
  `buildtype` varchar(16)  DEFAULT NULL,
  `version` int(11) not null default 1
) ENGINE=InnoDB;


CREATE TABLE `a_lineage` (
  `lineageid` int(11) NOT NULL,
  `sourceref` varchar(50)   DEFAULT NULL,
  `sourceid` int(11) DEFAULT NULL,
  `targetref` varchar(50)   DEFAULT NULL,
  `targetid` int(11) DEFAULT NULL,
  `lastmoddate`  datetime NULL,
  `lastmoduser`  varchar(64) NULL,
  `createdate`  datetime NULL,
  `version` int(11) not null default 1
) ENGINE=InnoDB ROW_FORMAT=COMPACT;


CREATE TABLE `a_lineagecolumn` (
  `lineagecolumnid` int(11) NOT NULL,
  `sourcecolumnid` int(11) NOT NULL,
  `sourcecolumntype` varchar(50)  DEFAULT NULL,
  `destinationcolumnid` int(11) NOT NULL,
  `destinationcolumntype` varchar(50) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `lastmoduser` varchar(255) NOT NULL,
  `lineageid` int(11) NOT NULL,
  `comment` text,
  `version` int(11) not null default 1,
  lineageextid int
) ENGINE=InnoDB;


CREATE TABLE `a_oecolumn` (
  `oecolumnid` int(11) NOT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `columndescription` varchar(256) DEFAULT NULL,
  `oecolumntype` varchar(256) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` double DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `nullcount` bigint(20) DEFAULT NULL,
  `distinctcount` bigint(20) DEFAULT NULL,
  `typestats` text,
  `topvalues` mediumtext default null COMMENT 'This is for archieve the top values of table column',
  `mask` tinyint(4) DEFAULT '0',
  `restricted` tinyint(4) DEFAULT '0',
  `columnposition` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  status int(2),
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  ispkorfk VARCHAR(50) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index',
  externalid varchar(256) DEFAULT null comment 'To save necessary remote ids when crawling, creating this for quickbase now'
) ENGINE=InnoDB;


CREATE TABLE `a_oeschema` (
  `oeschemaid` int(11) NOT NULL,
  `schemaname` varchar(255) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `lastprofileddate` timestamp NULL DEFAULT NULL,
  `crawled` tinyint(4) DEFAULT NULL,
  `usescore` int(11),
  `description` varchar(255),
  createdate timestamp NULL DEFAULT NULL,
  owner varchar(50),
  steward varchar(50),
  externalid varchar(256) DEFAULT null COMMENT 'To save necessary remote ids when crawling, creating this for quickbase now'
) ENGINE=InnoDB;


CREATE TABLE `a_oetable` (
  `oetableid` int(11) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `oeschemaid` int(11) DEFAULT NULL,
  `tablename` varchar(256) DEFAULT NULL,
  `tabledescription` varchar(255) DEFAULT NULL,
  `filename` varchar(400) DEFAULT NULL,
  `filetype` varchar(40) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `sampletable` varchar(100) DEFAULT NULL,
  `rowcount` bigint(20) DEFAULT NULL,
  `tablescore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `lastanalyzeddate` TIMESTAMP NULL DEFAULT NULL,
  `analyzedstatus` varchar(50) DEFAULT 'Not Analyzed',
  `blurstatus` tinyint(1) DEFAULT '0',
  `lastblurdate` date DEFAULT NULL,
  `location` varchar(900) DEFAULT NULL,
  `columnsecure` tinyint(4) DEFAULT '0',
  `partitioned` tinyint(4) DEFAULT '0',
  `rawind` tinyint(4) DEFAULT '1',
  `lastpopulateddate` timestamp NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `remotetags` TEXT DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  owner varchar(50),
  steward varchar(50),
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  createddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `px` double DEFAULT '0',
  `py` double DEFAULT '0',
  `x` double DEFAULT '0',
  `y` double DEFAULT '0',
  dqindex double default null COMMENT 'This is for the data quality index',
  externalid varchar(256) DEFAULT null COMMENT 'To save necessary remote ids when crawling, creating this for quickbase now'
) ENGINE=InnoDB;


CREATE TABLE `acl_class` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `class` (`class`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `acl_sid` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `principal` tinyint(1) NOT NULL,
  `sid` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_sid_idx_1` (`sid`,`principal`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `acl_object_identity` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `object_id_class` bigint(20) unsigned NOT NULL,
  `object_id_identity` BIGINT,
  `parent_object` bigint(20) unsigned DEFAULT NULL,
  `owner_sid` bigint(20) unsigned DEFAULT NULL,
  `entries_inheriting` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_object_identity_idx_1` (`object_id_class`,`object_id_identity`),
  KEY `parent_object` (`parent_object`),
  KEY `owner_sid` (`owner_sid`),
  CONSTRAINT `acl_object_identity_ibfk_1` FOREIGN KEY (`object_id_class`) REFERENCES `acl_class` (`id`),
  CONSTRAINT `acl_object_identity_ibfk_2` FOREIGN KEY (`parent_object`) REFERENCES `acl_object_identity` (`id`),
  CONSTRAINT `acl_object_identity_ibfk_3` FOREIGN KEY (`owner_sid`) REFERENCES `acl_sid` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `acl_entry` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `acl_object_identity` bigint(20) unsigned NOT NULL,
  `ace_order` int(10) unsigned NOT NULL,
  `sid` bigint(20) unsigned NOT NULL,
  `mask` int(11) NOT NULL,
  `granting` tinyint(1) NOT NULL,
  `audit_success` tinyint(1) NOT NULL,
  `audit_failure` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acl_entry_idx_1` (`acl_object_identity`,`ace_order`),
  KEY `sid` (`sid`),
  CONSTRAINT `acl_entry_ibfk_1` FOREIGN KEY (`acl_object_identity`) REFERENCES `acl_object_identity` (`id`),
  CONSTRAINT `acl_entry_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `acl_sid` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `action` (
  `actionid` int(10) NOT NULL AUTO_INCREMENT,
  `actionname` varchar(30) DEFAULT NULL,
  `actiondescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`actionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `advancejob` (
  `advancejobid` int(11) NOT NULL AUTO_INCREMENT,
  `ajname` varchar(100) DEFAULT NULL,
  `ajtype` varchar(100) DEFAULT NULL,
  `classname` varchar(100) DEFAULT NULL,
  `help` varchar(500) DEFAULT NULL,
  `attr1` varchar(500) DEFAULT NULL,
  `attr2` varchar(500) DEFAULT NULL,
  `attr3` varchar(500) DEFAULT NULL,
  `attr4` varchar(500) DEFAULT NULL,
  `attr5` varchar(500) DEFAULT NULL,
  attr1label varchar(200) DEFAULT 'Attr1',
  attr2label varchar(200) DEFAULT 'Attr2',
  attr3label varchar(200) DEFAULT 'Attr3',
  attr4label varchar(200) DEFAULT 'Attr4',
  attr5label varchar(200) DEFAULT 'Attr5',
  visible boolean default true,
  PRIMARY KEY (`advancejobid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `aiassistedtabletag` (
  `aiassistedtabletagid` int(11) NOT NULL AUTO_INCREMENT,
  `tagid` int(11) DEFAULT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `userinputid` int(11) DEFAULT NULL,
  `guessscore` double DEFAULT NULL,
  PRIMARY KEY (`aiassistedtabletagid`),
  KEY `idx_tableid` (`oetableid`),
  KEY `aiassist_idx1` (`tagid`,`userinputid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `aiassistedtag` (
  `aiassistedtagid` int(11) NOT NULL AUTO_INCREMENT,
  `tagid` int(11) DEFAULT NULL,
  `oecolumnid` int(11) DEFAULT NULL,
  `userinputid` int(11) DEFAULT NULL,
  `guessscore` double DEFAULT NULL,
   columntype varchar(255),
  PRIMARY KEY (`aiassistedtagid`),
  KEY `idx_oecolumnid` (`oecolumnid`),
  KEY `aiassist_idx` (`tagid`,`userinputid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `alert` (
  `alertid` int(11) NOT NULL AUTO_INCREMENT,
  `alertname` varchar(255) DEFAULT NULL,
  `datasetid` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `helptext` varchar(255) DEFAULT NULL,
  `createdby` varchar(50) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`alertid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `alertuser` (
  `alertuserid` int(11) NOT NULL AUTO_INCREMENT,
  `alertid` int(11) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`alertuserid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `application` (
  `applicationid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `path` varchar(100) DEFAULT NULL,
  code varchar(100) default null,
  issubtab boolean default false,
  active BOOLEAN DEFAULT FALSE,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  visible boolean default true,
  PRIMARY KEY (`applicationid`),
  UNIQUE KEY `ukey_app_path` (`path`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `audit` (
  `auditid` int(11) NOT NULL AUTO_INCREMENT,
  `operation` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  `target` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`auditid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `chart` (
  `CHARTID` int(11) NOT NULL AUTO_INCREMENT,
  `CHARTNAME` varchar(255) DEFAULT NULL,
  `COLNAMETYPEMAP` text,
  `OPTIONS` text,
  `GENRE` varchar(20) DEFAULT NULL,
  `DESCRIPTION` text,
  `datasetid` int(11) DEFAULT NULL,
  `CREATEDBY` varchar(50) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,	
  `OWNER` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp DEFAULT CURRENT_TIMESTAMP,
  `CHARTTYPE` varchar(100) DEFAULT 'chart',
  `DOMAINID` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `extreferenceid` varchar(255) DEFAULT NULL,
  `USESCORE` int(11) DEFAULT '0',
  `chartscore` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `parentchartid` int(11) DEFAULT NULL,
  `chartdata` text,
  createdate timestamp NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  steward varchar(50),
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index',
  version int(11) not null default 1 COMMENT 'This column is to define version of the chart record',
  PRIMARY KEY (`CHARTID`),
  KEY `idx_chart_bgid` (`businessglossaryid`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `chartchild` (
  `chartchildid` int(11) NOT NULL AUTO_INCREMENT,
  `chartid` int(11) NOT NULL,
  `childname` varchar(256) DEFAULT NULL,
  `childtype` varchar(50) DEFAULT NULL,
  DESCRIPTION mediumtext, 
  usescore int(11),
  displayeligible tinyint(4),
  columnlength double,
  minval varchar(500),
  maxval varchar(500), 
  nullcount bigint(20),
  distinctcount bigint(20),
  typestats mediumtext,
  topvalues mediumtext,
  mask tinyint(4),
  restricted tinyint(4),
  columnposition int(11),
  lastmetasyncdate timestamp NULL DEFAULT NULL,
  active tinyint(4),
  inaudit tinyint(4),
  businessglossaryid int(11) DEFAULT NULL,
  LASTMODDATE timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  columnscore int(11) default null,
  createdate timestamp NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `formula` text,
  dqindex double default null COMMENT 'This is for the data quality index',
  PRIMARY KEY (`chartchildid`),
  KEY `idx_chartchild_bgid` (`businessglossaryid`),
  KEY `idx_chart` (`chartid`),
  KEY `idx_child` (`childname`),
  KEY `idx_desc` (`DESCRIPTION`(500)),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `charttag` (
  `CHARTTAGID` int(11) NOT NULL AUTO_INCREMENT,
  `CHARTID` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`CHARTTAGID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=DYNAMIC;


CREATE TABLE `chartuserstats` (
  `chartuserstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `chartid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `chartuserscore` int(11) DEFAULT NULL,
  `numberlooked` int(11) DEFAULT NULL,
  `numbercommented` int(11) DEFAULT NULL,
  `numberusagestats` int(11) default 0,
  PRIMARY KEY (`chartuserstatsid`),
  UNIQUE `unique_index`(`chartid`, `userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=DYNAMIC;


CREATE TABLE `clickstream` (
  `page` varchar(30) DEFAULT NULL,
  `id` int(11) DEFAULT NULL,
  `userid` varchar(40) DEFAULT NULL,
  springsessionid varchar(200) default NULL,
  `clickdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `columnpattern` (
  `columnpatternid` int(11) NOT NULL AUTO_INCREMENT,
  `oecolumnid` int(11) DEFAULT NULL,
  `pattern` varchar(100) DEFAULT NULL,
  `count` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`columnpatternid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `columnrelation` (
  `columnrelationid` int(11) NOT NULL AUTO_INCREMENT,
  `leftcolumnid` int(11) DEFAULT NULL,
  `rightcolumnid` int(11) DEFAULT NULL,
  `leftmatchcount` bigint(20) DEFAULT NULL,
  `rightmatchcount` bigint(20) DEFAULT NULL,
  `uniquematchcount` bigint(20) DEFAULT NULL,
  `manuallyupdated` tinyint(4) DEFAULT NULL,
  `mediumadded` VARCHAR(30) DEFAULT null,
  `disabled` tinyint(4) DEFAULT NULL,
  `countcaltype` varchar(20) DEFAULT NULL,
  `buildtype` varchar(16) DEFAULT NULL,
  `algorithmtype` varchar(255) DEFAULT NULL,
  ltorrltype VARCHAR(10) DEFAULT NULL,
  crscore int(10) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastupdatedate timestamp NULL DEFAULT NULL,
  lastupdatedby VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`columnrelationid`),
  KEY `columnrelation_lftclmid` (`leftcolumnid`) USING BTREE,
  KEY `columnrelation_rgtclmid` (`rightcolumnid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `columntag` (
  `columntagid` int(11) NOT NULL AUTO_INCREMENT,
  `columnid` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`columntagid`),
  KEY `columnid_idx` (`columnid`),
  KEY `tagid_idx` (`TAGID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `comment` (
  `commentid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) NOT NULL,
  `comment` text,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `parentcommentid` int(11) DEFAULT NULL,
  `numberofreply` int(11) DEFAULT NULL,
  commenttype varchar(20),
  objecttype varchar(20),
  objectid int(11),
  createddate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`commentid`),
  KEY `comment_idx` (`commenttype`,`objecttype`,`objectid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `commentassociation` (
  `commentassociationid` int(11) NOT NULL AUTO_INCREMENT,
  `commentid` int(11) NOT NULL,
  `assobject` varchar(30) DEFAULT NULL,
  `assobjectid` int(11) DEFAULT NULL,
  PRIMARY KEY (`commentassociationid`),
  UNIQUE KEY `commentassociation_unq_1` (`commentid`,`assobject`,`assobjectid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `connectioninfo` (
  `connectioninfoid` int(11) NOT NULL AUTO_INCREMENT,
  `servertype` varchar(200) DEFAULT NULL,
  `ipaddress` varchar(200) DEFAULT NULL,
  `portnumber` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` longtext,
  `name` varchar(100) DEFAULT NULL,
  `connectionstring` longtext,
  `sid` varchar(100) DEFAULT NULL,
  `drivername` varchar(200) DEFAULT NULL,
  `userid` varchar(100) DEFAULT NULL,
  `hadoopdependent` tinyint(4) DEFAULT NULL,
  `datapersist` tinyint(4) DEFAULT NULL,
  `createdDate` timestamp NULL DEFAULT NULL,
  `lastSyncDate` timestamp NULL DEFAULT NULL,
  `conntype` int(11) DEFAULT NULL,
  webport varchar(10),
  enable boolean default true,
  divenable boolean default true,
  licensetype tinyint default 1,
  `connectionstringtype` int default 0 COMMENT 'This is for the type of connectionstring, whether auto-0 or manual-1',
  lastcrawldate timestamp NULL DEFAULT NULL,
  lastcrawlstatus VARCHAR(20) DEFAULT NULL,
  archive_enabled tinyint(1) not null default 0 COMMENT "enable/disable configuration to archive objects",
  archive_copies tinyint(1) not null default 0 comment "Stores the limit count for archive copies",
  istempconnection tinyint(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`connectioninfoid`),
  KEY `connectioninfoid_idx` (`connectioninfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `connectioninfoadnl` (
  `connectioninfoadnlid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) DEFAULT NULL,
  `ckey` varchar(50) DEFAULT NULL,
  `cvalue` text,
  PRIMARY KEY (`connectioninfoadnlid`),
  UNIQUE KEY `connectionkey` (`connectioninfoid`,`ckey`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `crawlersetting` (
  `crawlersettingid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) NOT NULL,
  `setorder` int(11) DEFAULT NULL,
  `threadcount` int(11) DEFAULT NULL,
  `dayofweek` int(11) DEFAULT NULL,
  `starttime` time DEFAULT NULL,
  `endtime` time DEFAULT NULL,
  `lastupdateuser` varchar(40) DEFAULT NULL,
  `lastupdatedate` timestamp NULL DEFAULT NULL,
  `rowcountcheck` tinyint(4) DEFAULT NULL,
  `rowcountlimit` int(11) DEFAULT NULL,
  `profiletype` int(11) DEFAULT NULL,
  `parms` varchar(1000) DEFAULT NULL,
  `samplesize` INT(11) default 10000,
  `querytimeout` INT(11) default 60,
  `datacount` INT(11) default 100,
  PRIMARY KEY (`crawlersettingid`),
  KEY `conn_idx` (`connectioninfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dashboard` (
  `DASHBOARDID` int(11) NOT NULL AUTO_INCREMENT,
  `WIDGET_GRID` text,
  `DASHBOARD_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DASHBOARDID`),
  KEY `DASHBOARDID` (`DASHBOARDID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataapp` (
  `DATAAPPID` int(11) NOT NULL AUTO_INCREMENT,
  `DATAAPPNAME` varchar(50) DEFAULT NULL,
  `OPTIONS` text NOT NULL,
  `CATEGORY` varchar(50) DEFAULT NULL,
  `CREATEDBY` varchar(50) DEFAULT NULL,
  `OWNER` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CREATEDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `REPORTID` int(11) DEFAULT NULL,
  PRIMARY KEY (`DATAAPPID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `dataappchart` (
  `dataappchartid` int(11) NOT NULL AUTO_INCREMENT,
  `dataappid` int(11) NOT NULL,
  `chartid` int(11) NOT NULL,
  `widgetgrid` text,
  PRIMARY KEY (`dataappchartid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `dataidentifier` (
  `dataidentifierid` int(11) NOT NULL AUTO_INCREMENT,
  `datatype` varchar(25) DEFAULT NULL,
  `datatypedesc` varchar(100) DEFAULT NULL,
  `regex` varchar(255) DEFAULT NULL,
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dataidentifierid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataset` (
  `datasetid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetname` varchar(256) DEFAULT NULL,
  `description` text,
  `query` text,
  `outputdb` varchar(255) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `outputtable` varchar(256) DEFAULT NULL,
  `saved` tinyint(4) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `subquery` tinyint(2) NOT NULL DEFAULT '0',
  `isbatch` tinyint(4) DEFAULT '1',
  `append` tinyint(2) NOT NULL DEFAULT '0',
  `jobtype` varchar(255) DEFAULT NULL,
  `sourceids` VARCHAR(15),
  `destids` VARCHAR(15),	
  `projid` varchar(20) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `userselecteddb` varchar(1000) DEFAULT NULL,
  `sqltype` tinyint(4) DEFAULT '0',
  `tagrelease` tinyint(4) DEFAULT '0',
  `loadfileid` int(11) DEFAULT NULL,
  `analysismsg` longtext,
  parentdatasetid int(11),
  pkdata longtext,
  packageid varchar(50),
  filedownloaded tinyint,
  active tinyint(4) DEFAULT NULL,
  result mediumtext,
  creatorid int(11) DEFAULT NULL,
  creatortype varchar(50) DEFAULT NULL,
  impactobjectid int(11) DEFAULT NULL,
  impactobjecttype varchar(10) DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `sourcecodeid`  int(11) NULL,
  jobstepid int(11) DEFAULT NULL,
  outputready boolean default false,
  `lineagestatus` varchar(100) DEFAULT NULL,
  owner VARCHAR (50),
  steward VARCHAR (50),
  isxml tinyint DEFAULT 0,
  `lastlineagerundate` timestamp NULL DEFAULT NULL COMMENT 'This column is to store lastlineagerundate of lineage (RDMS)',
  `lastqueryrundate` timestamp NULL DEFAULT NULL COMMENT 'This column is to store lastqueryrundate of queryexcution',
  usescore INT(11) DEFAULT NULL COMMENT 'this is to calculate usescore on modifying term/tag/business description etc',
  isexecuted tinyint default 0 COMMENT 'This column states the query is executed or not - if executed updated as 1 if it is saved then it is 0 ',
  `version` int(11) not null default 1,
  dqindex double default null COMMENT 'This is for the data quality index',
  PRIMARY KEY (`datasetid`),
  KEY `dataset_idx` (`saved`),
  KEY `dataset_idx1` (`userid`),
  KEY `idx_dataset_bgid` (`businessglossaryid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataset1` (
  `datasetid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetname` varchar(256) DEFAULT NULL,
  `description` text,
  `query` text,
  `modifiedquery` text,
  `outputdb` varchar(255) DEFAULT NULL,
  `outputtable` varchar(256) DEFAULT NULL,
  `saved` tinyint(4) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subquery` tinyint(2) NOT NULL DEFAULT '0',
  `isbatch` tinyint(4) DEFAULT '1',
  `append` tinyint(2) NOT NULL DEFAULT '0',
  `jobtype` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `projid` varchar(20) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `userselecteddb` varchar(50) DEFAULT NULL,
  `sqltype` tinyint(4) DEFAULT '0',
  `tagrelease` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`datasetid`),
  KEY `dataset_idx` (`saved`),
  KEY `dataset_idx1` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataset2` (
  `datasetid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetname` varchar(256) DEFAULT NULL,
  `description` text,
  `query` text,
  `modifiedquery` text,
  `outputdb` varchar(255) DEFAULT NULL,
  `outputtable` varchar(256) DEFAULT NULL,
  `saved` tinyint(4) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subquery` tinyint(2) NOT NULL DEFAULT '0',
  `isbatch` tinyint(4) DEFAULT '1',
  `append` tinyint(2) NOT NULL DEFAULT '0',
  `jobtype` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `projid` varchar(20) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `userselecteddb` varchar(50) DEFAULT NULL,
  `sqltype` tinyint(4) DEFAULT '0',
  `tagrelease` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`datasetid`),
  KEY `dataset_idx` (`saved`),
  KEY `dataset_idx1` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataset3` (
  `datasetid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetname` varchar(256) DEFAULT NULL,
  `description` text,
  `query` text,
  `modifiedquery` text,
  `outputdb` varchar(255) DEFAULT NULL,
  `outputtable` varchar(256) DEFAULT NULL,
  `saved` tinyint(4) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `subquery` tinyint(2) NOT NULL DEFAULT '0',
  `isbatch` tinyint(4) DEFAULT '1',
  `append` tinyint(2) NOT NULL DEFAULT '0',
  `jobtype` varchar(255) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `projid` varchar(20) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `userselecteddb` varchar(50) DEFAULT NULL,
  `sqltype` tinyint(4) DEFAULT '0',
  `tagrelease` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`datasetid`),
  KEY `dataset_idx` (`saved`),
  KEY `dataset_idx1` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `datasetassociation` (
  `datasetassociationid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetid` int(11) DEFAULT NULL,
  `assobject` varchar(30) DEFAULT NULL,
  `assobjectid` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  reftype text NULL DEFAULT NULL,
  refcode varchar(255)  NULL DEFAULT NULL,
  `buildtype` varchar(16) DEFAULT NULL,
  `version` int(11) not null default 1,
  PRIMARY KEY (`datasetassociationid`),
  KEY `dass_index` (`assobjectid`,`assobject`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;



CREATE TABLE `datasetcorrection` (
  `datasetcorrectionid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetid` int(11) NOT NULL,
  `corrected_query` longtext,
  `status` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`datasetcorrectionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `datasource` (
  `USERNAME` varchar(50) NOT NULL,
  `PWD` varchar(50) NOT NULL,
  `DATASOURCEID` int(11) NOT NULL AUTO_INCREMENT,
  `DRIVERCLASSNAME` varchar(50) NOT NULL,
  `DATASOURCENAME` varchar(50) NOT NULL,
  `URL` varchar(100) NOT NULL,
  PRIMARY KEY (`DATASOURCEID`),
  KEY `DATASOURCEID` (`DATASOURCEID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `datastorytag` (
  `STORYTAGID` int(11) NOT NULL AUTO_INCREMENT,
  `STORYID` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`STORYTAGID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `discovery` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME` varchar(255) DEFAULT NULL,
  `USERID` varchar(50) DEFAULT NULL,
  `STATUS` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transformsteps` text,
  `DATASETID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `docpackage` (
  `docpackageid` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `docpackageinfoid` int(20) DEFAULT NULL,
  `object` varchar(255) DEFAULT NULL,
  `objectpk` varchar(255) DEFAULT NULL,
  `objectpkid` int(11) DEFAULT NULL,
  `objectcolumn` varchar(255) DEFAULT NULL,
  `objectcolumnvalue` text,
  `isreference` tinyint(4) DEFAULT NULL,
  `referencetable` varchar(255) DEFAULT NULL,
  `referencecolumn` varchar(255) DEFAULT NULL,
  `referencevalue` text,
  `islink` tinyint(4) DEFAULT NULL,
  `link1` varchar(255) DEFAULT NULL,
  `linkreferencetable1` varchar(255) DEFAULT NULL,
  `linkreferencecolumn1` varchar(255) DEFAULT NULL,
  `linkreferencevalue1` text,
  `link2` varchar(255) DEFAULT NULL,
  `linkreferencetable2` varchar(255) DEFAULT NULL,
  `linkreferencecolumn2` varchar(255) DEFAULT NULL,
  `linkreferencevalue2` text,
  `link3` varchar(255) DEFAULT NULL,
  `linkreferencetable3` varchar(255) DEFAULT NULL,
  `linkreferencecolumn3` varchar(255) DEFAULT NULL,
  `linkreferencevalue3` text,
  `link4` varchar(255) DEFAULT NULL,
  `linkreferencetable4` varchar(255) DEFAULT NULL,
  `linkreferencecolumn4` varchar(255) DEFAULT NULL,
  `linkreferencevalue4` text,
  `link5` varchar(255) DEFAULT NULL,
  `linkreferencetable5` varchar(255) DEFAULT NULL,
  `linkreferencecolumn5` varchar(255) DEFAULT NULL,
  `linkreferencevalue5` text,
  `link6` varchar(255) DEFAULT NULL,
  `linkreferencetable6` varchar(255) DEFAULT NULL,
  `linkreferencecolumn6` varchar(255) DEFAULT NULL,
  `linkreferencevalue6` text,
  `link7` varchar(255) DEFAULT NULL,
  `linkreferencetable7` varchar(255) DEFAULT NULL,
  `linkreferencecolumn7` varchar(255) DEFAULT NULL,
  `linkreferencevalue7` text,
  `link8` varchar(255) DEFAULT NULL,
  `linkreferencetable8` varchar(255) DEFAULT NULL,
  `linkreferencecolumn8` varchar(255) DEFAULT NULL,
  `linkreferencevalue8` text,
  `link9` varchar(255) DEFAULT NULL,
  `linkreferencetable9` varchar(255) DEFAULT NULL,
  `linkreferencecolumn9` varchar(255) DEFAULT NULL,
  `linkreferencevalue9` text,
  `link10` varchar(255) DEFAULT NULL,
  `linkreferencetable10` varchar(255) DEFAULT NULL,
  `linkreferencecolumn10` varchar(255) DEFAULT NULL,
  `linkreferencevalue10` text,
  PRIMARY KEY (`docpackageid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `docpackageinfo` (
  `docpackageinfoid` int(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `expconnectionname` varchar(255) DEFAULT NULL,
  `expconnectionid` int(11) DEFAULT NULL,
  `expschemaname` varchar(255) DEFAULT NULL,
  `expschemaid` int(11) DEFAULT NULL,
  `impconnectionname` varchar(255) DEFAULT NULL,
  `impconnectionid` int(11) DEFAULT NULL,
  `impschemaname` varchar(255) DEFAULT NULL,
  `impschemaid` int(11) DEFAULT NULL,
  `expwiki` tinyint(4) DEFAULT NULL,
  `exptabletag` tinyint(4) DEFAULT NULL,
  `exptablerelation` tinyint(4) DEFAULT NULL,
  `expcolumnrelation` tinyint(4) DEFAULT NULL,
  `expjobstatus` varchar(255) DEFAULT NULL,
  `impwiki` tinyint(4) DEFAULT NULL,
  `imptabletag` tinyint(4) DEFAULT NULL,
  `imptablerelation` tinyint(4) DEFAULT NULL,
  `impcolumnrelation` tinyint(4) DEFAULT NULL,
  `impjobstatus` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`docpackageinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `domain` (
  `DOMAINID` int(11) NOT NULL AUTO_INCREMENT,
  `VALUE` text NOT NULL,
  `DESCRIPTION` text,
  `crawled` tinyint(4),
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
   `active` tinyint(4),
  `domaintype` varchar(100) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `extreferenceid` varchar(255) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  owner varchar(50),
  steward varchar(50),
  lastcrawldate timestamp NULL DEFAULT NULL,
  lastcrawlstatus VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`DOMAINID`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `exporttableinfo` (
  `exportableinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) DEFAULT NULL,
  `rdbname` varchar(100) DEFAULT NULL,
  `rtablename` varchar(100) DEFAULT NULL,
  `columnname` text,
  `hiveschema` varchar(50) DEFAULT NULL,
  `hivetable` varchar(100) DEFAULT NULL,
  `jobname` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`exportableinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `file` (
  `fileid` int(11) NOT NULL AUTO_INCREMENT,
  `filename` varchar(511) DEFAULT NULL,
  `location` varchar(511) DEFAULT NULL,
  `filefolderid` int(11) DEFAULT NULL,
  `filedescription` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL, -- FILE/FOLDER
  `filetype` varchar(10) DEFAULT NULL,  -- CSV, TSV, JSON ...
  `filelastmoddate` date  ,
  `filecreatedate` date ,
  `businessglossaryid` int(11) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `usescore` int(11) DEFAULT 0,
  `rating` float,
  `profilepercent` int,	
  `sizeinbytes` bigint(20) DEFAULT NULL,
  `highperfjobid` int(10),
  `aclcreated` tinyint,
  `active` tinyint(4) DEFAULT 0,
  `lastanalyzeddate` TIMESTAMP NULL DEFAULT NULL,
  `analyzedstatus` varchar(55) DEFAULT 'Not Profiled',
  `rowcount` int(11) DEFAULT NULL,
  `lastpopulateddate` timestamp  NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inaudit` tinyint(4) DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `storageclass` varchar(255),
  `storagetype` varchar(255),
   isprofile tinyint default 0,
   remotetags text,
   `columnsecure` tinyint(4),	
   metadata text,
   remotekeys text,
   owner varchar(50),
   steward varchar(50),
   lastmodby VARCHAR(50) DEFAULT NULL,
   createdby VARCHAR(50) DEFAULT NULL,
   lastupdatereference VARCHAR(30) DEFAULT NULL,
   `filescore` int(11) DEFAULT NULL,
   dqindex double default null COMMENT 'This is for the data quality index',
   parentfileid int(11) DEFAULT 0 COMMENT 'This column is used to save the value of parentfileid',
  PRIMARY KEY (`fileid`),
  KEY `idx_file_bgid` (`businessglossaryid`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000; 


CREATE TABLE `filefolder` (
  `filefolderid` int(11) NOT NULL AUTO_INCREMENT,
  `filefolder` varchar(200) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `inserted` bit(1) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `steward` varchar(50) DEFAULT NULL,
  `isinproject` bit(1) DEFAULT NULL,
  `crawled` bit(1) DEFAULT NULL,
  `nooffiles` int(11) DEFAULT NULL,
  `nooffolders` int(11) DEFAULT NULL,
  `parentfolderid` varchar(255) DEFAULT NULL,
  `totalspaceusedinmb` double(10,3),
  `lastcrawleddate` timestamp NULL DEFAULT NULL,
  `lastcrawledstatus` varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`filefolderid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `fileoperation` (
  `fileoperationid` int(11) NOT NULL AUTO_INCREMENT,
  `operationname` varchar(100) DEFAULT NULL,
  `operationtype` varchar(200) DEFAULT NULL,
  `sourcetype` varchar(200) DEFAULT NULL,
  `sourceloc` varchar(400) DEFAULT NULL,
  `desttype` varchar(200) DEFAULT NULL,
  `destloc` varchar(400) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fileoperationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `filestructure` (
  `filestructureid` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(255) DEFAULT NULL,
  `schemaname` varchar(255) DEFAULT NULL,
  `tablename` varchar(255) DEFAULT NULL,
  `creationdate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `filetype` varchar(50) DEFAULT NULL,
  `packagecount` int(11) DEFAULT NULL,
  `learndatalake` tinyint(1) DEFAULT NULL,
  `functioncount` int(11) DEFAULT NULL,
  `jobname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`filestructureid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `filestructurefcn` (
  `fcnid` int(11) NOT NULL AUTO_INCREMENT,
  `fcnname` varchar(50) DEFAULT NULL,
  `fcntype` varchar(50) DEFAULT NULL,
  `inputsize` int(11) DEFAULT NULL,
  `description` longtext,
  `regularexp` varchar(255) DEFAULT NULL,
  `columnname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fcnid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `filestructurepackage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filestructureid` int(11) DEFAULT NULL,
  `packageid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `filetableinfo` (
  `filetableinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11) DEFAULT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `import` tinyint(4) DEFAULT NULL,
  `append` tinyint(4) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `columnregex` varchar(100) DEFAULT NULL,
  `lastrundate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datasetid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  objecttype varchar(50) DEFAULT NULL,
  PRIMARY KEY (`filetableinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `filetag` (
  `filetagid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`filetagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `filetransformation` (
  `filetransformationid` int(11) NOT NULL AUTO_INCREMENT,
  `filetransformationname` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `filetype` varchar(50) DEFAULT NULL,
  `outputpath` varchar(255) DEFAULT NULL,
  `recreateoutputpath` tinyint(4) DEFAULT NULL,
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`filetransformationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `filetransformationstep` (
  `filetransformationstepid` int(11) NOT NULL AUTO_INCREMENT,
  `filetransformationid` int(11) DEFAULT NULL,
  `stepno` int(11) DEFAULT NULL,
  `transfunction` varchar(100) DEFAULT NULL,
  `transfunctionvar1` varchar(255) DEFAULT NULL,
  `transfunctionvar2` varchar(255) DEFAULT NULL,
  `transfunctionvar3` varchar(255) DEFAULT NULL,
  `transfunctionvar4` varchar(255) DEFAULT NULL,
  `transfunctionvar5` varchar(255) DEFAULT NULL,
  `transfunctionvar6` varchar(255) DEFAULT NULL,
  `creationdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`filetransformationstepid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `filetransfunctiondef` (
  `functionname` varchar(100) DEFAULT NULL,
  `functionhelp` text,
  `attr1` varchar(100) DEFAULT NULL,
  `attr2` varchar(100) DEFAULT NULL,
  `attr3` varchar(100) DEFAULT NULL,
  `attr4` varchar(100) DEFAULT NULL,
  `attr5` varchar(100) DEFAULT NULL,
  `attr6` varchar(100) DEFAULT NULL,
  `helpattr1` text,
  `helpattr2` text,
  `helpattr3` text,
  `helpattr4` text,
  `helpattr5` text,
  `helpattr6` text
) ENGINE=InnoDB;


CREATE TABLE `fileuserstats` (
  `fileuserstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `fileuserscore` int(11) DEFAULT NULL,
  `numberlooked` int(11) DEFAULT NULL,
  `numbercommented` int(11) DEFAULT NULL,
  PRIMARY KEY (`fileuserstatsid`),
  UNIQUE `unique_index`(`fileid`, `userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `folderstats` (
  `Folderstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `foldername` varchar(1000) DEFAULT NULL,
  `Totalrowcount` int(11) DEFAULT NULL,
  `FileTypeStats` text,
  `Tablecreateflag` tinyint(4) DEFAULT NULL,
  `filecount` int(11) DEFAULT NULL,
  `foldercount` int(11) DEFAULT NULL,
  PRIMARY KEY (`Folderstatsid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `ftpconnectioninfo` (
  `ftpconnectionid` int(11) NOT NULL AUTO_INCREMENT,
  `connectionname` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `ipaddress` varchar(255) DEFAULT NULL,
  `port` varchar(255) DEFAULT NULL,
  `operationtype` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ftpconnectionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `ftpimportinfo` (
  `ftpinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `ftpconnectionid` int(11) DEFAULT NULL,
  `ftppath` varchar(255) DEFAULT NULL,
  `destconnectioninfoid` int(11) DEFAULT NULL,
  `destpath` varchar(255) DEFAULT NULL,
  `jobname` varchar(255) DEFAULT NULL,
  `batchid` int(11) DEFAULT NULL,
  PRIMARY KEY (`ftpinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `function` (
  `DATATYPE` varchar(255) DEFAULT NULL,
  `FXDEFNITION` varchar(255) DEFAULT NULL,
  `FXNAME` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `graph` (
  `GRAPHID` int(11) NOT NULL AUTO_INCREMENT,
  `GRAPHNAME` varchar(50) NOT NULL,
  `GRAPHTYPE` varchar(50) NOT NULL,
  `QUERY` text,
  `STACK` varchar(50) NOT NULL,
  `BUSINESS_FUNCTION` varchar(50) DEFAULT 'Not Assigned',
  `ELEMENT` text,
  PRIMARY KEY (`GRAPHID`),
  KEY `GRAPHID` (`GRAPHID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hashtag` (
  `hashtagid` int(11) NOT NULL AUTO_INCREMENT,
  `hashtag` varchar(50) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`hashtagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hive_partition_mtdt` (
  `partitionid` int(100) NOT NULL AUTO_INCREMENT,
  `hivetableid` int(100) DEFAULT NULL,
  `partitionfield` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`partitionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hivecolumn1` (
  `hivecolumnid` int(11) NOT NULL AUTO_INCREMENT,
  `hivetableid` int(11) DEFAULT NULL,
  `schemaname` varchar(50) DEFAULT NULL,
  `tablename` varchar(256) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `hivecolumntype` varchar(100) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `columnrank` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` int(11) DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` int(11) DEFAULT NULL,
  `distinctcount` int(10) DEFAULT NULL,
  `typestats` text,
  `topvalues` text,
  `comments` varchar(200) DEFAULT NULL,
  `mask` tinyint(4) DEFAULT '0',
  `restricted` tinyint(4) DEFAULT '0',
  `columnposition` int(11) DEFAULT NULL,
  PRIMARY KEY (`hivecolumnid`),
  UNIQUE KEY `hivecolumn_db_tbl_col` (`schemaname`,`tablename`,`columnname`),
  UNIQUE KEY `hivecolumn_tblid_col` (`hivetableid`,`columnname`),
  KEY `hivecolumn_id_col` (`hivetableid`,`columnname`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hivecolumnpartition` (
  `hivecolumnpartitionid` int(11) NOT NULL AUTO_INCREMENT,
  `hivepartitionid` int(11) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `hivecolumntype` varchar(100) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `columnrank` int(11) DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` int(11) DEFAULT NULL,
  `distinctcount` int(11) DEFAULT NULL,
  `typestats` text,
  `topvalues` text,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hivecolumnpartitionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `hivecolumntimeline` (
  `hivecolumntimelineid` int(11) NOT NULL AUTO_INCREMENT,
  `hivetabletimelineid` int(11) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `hivecolumntype` varchar(100) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `columnrank` int(11) DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` int(11) DEFAULT NULL,
  `distinctcount` int(11) DEFAULT NULL,
  `typestats` text,
  `topvalues` text,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`hivecolumntimelineid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `hivepartition` (
  `hivepartitionid` int(11) NOT NULL AUTO_INCREMENT,
  `hivetableid` int(11) DEFAULT NULL,
  `partitionname` varchar(256) DEFAULT NULL,
  `location` varchar(4000) DEFAULT NULL,
  `analyzeddate` datetime DEFAULT NULL,
  `rowcount` int(11) DEFAULT NULL,
  `tablescore` int(11) DEFAULT NULL,
  `analyzed` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`hivepartitionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hiverelation` (
  `hiverelationid` int(11) NOT NULL AUTO_INCREMENT,
  `lefttableid` int(11) DEFAULT NULL,
  `righttableid` int(11) DEFAULT NULL,
  `leftpkfkscore` int(11) DEFAULT NULL,
  `rightpkfkscore` int(11) DEFAULT NULL,
  `similarityscore` int(11) DEFAULT NULL,
  PRIMARY KEY (`hiverelationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `hivetabletimeline` (
  `hivetabletimelineid` int(11) NOT NULL AUTO_INCREMENT,
  `hivetableid` int(11) NOT NULL,
  `analyzeddate` date DEFAULT NULL,
  `tablescore` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `partitionfield1` varchar(100) DEFAULT NULL,
  `partitionfield2` varchar(100) DEFAULT NULL,
  `sampletable` varchar(100) DEFAULT NULL,
  `rowcount` bigint(20) DEFAULT NULL,
  `tabledescription` varchar(200) DEFAULT NULL,
  `filename` varchar(400) DEFAULT NULL,
  `filetype` varchar(100) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `analyzedstatus` varchar(50) DEFAULT 'Not Analyzed',
  `blurstatus` tinyint(1) DEFAULT '0',
  `lastblurdate` date DEFAULT NULL,
  `location` varchar(200) DEFAULT NULL,
  `columnsecure` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`hivetabletimelineid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `impexcolumnmap` (
  `importcolumnmapid` int(11) NOT NULL AUTO_INCREMENT,
  `importinfoid` int(11) DEFAULT NULL,
  `filetableinfoid` int(11) DEFAULT NULL,
  `sourcecolumnname` varchar(256) DEFAULT NULL,
  `destcolumnname` varchar(256) DEFAULT NULL,
  `formula` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`importcolumnmapid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `impexpinfo` (
  `impexpinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetid` int(11) DEFAULT NULL,
  `sourcetableid` int(11) DEFAULT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `append` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `lastrundate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `tempdestschemaid` int(11) DEFAULT NULL,
  `tempdesttable` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`impexpinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `job` (
  `jobid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `jobstatus` varchar(255) NOT NULL,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` varchar(255) DEFAULT NULL,
  `jobflowid` int(10) DEFAULT NULL,
  updatedby varchar(50) DEFAULT NULL,
  PRIMARY KEY (`jobid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobflow` (
  `jobflowid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `status` varchar(255) DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `lastjobid` int(11) DEFAULT NULL,
  `projectid` int(10) DEFAULT NULL,
  `notifyonerror` tinyint(4) DEFAULT '0',
  `notifyonsuccess` tinyint(4) DEFAULT '0',
  updatedby varchar(50) DEFAULT NULL,
  notifyonpartialsuccess tinyint(4) DEFAULT NULL COMMENT 'This column represents to get notify on partial success',
  PRIMARY KEY (`jobflowid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobflow_expert` (
  `expertid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) DEFAULT NULL,
  `jobflowid` int(11) DEFAULT NULL,
  PRIMARY KEY (`expertid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobflowstep` (
  `jobflowstepid` int(11) NOT NULL AUTO_INCREMENT,
  `jobflowid` int(11) DEFAULT NULL,
  `xpos` varchar(255) DEFAULT NULL,
  `ypos` varchar(255) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `subtype` varchar(40) DEFAULT NULL,
  `externalref` varchar(100) DEFAULT NULL,
  `externalrefid` int(11) DEFAULT NULL,
  PRIMARY KEY (`jobflowstepid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobparm` (
  `jobparmid` int(11) NOT NULL AUTO_INCREMENT,
  `jobparmtype` varchar(50) DEFAULT NULL,
  `jobparmkey` varchar(50) DEFAULT NULL,
  `jobparmvalue` varchar(255) DEFAULT NULL,
  `jobparmdescription` varchar(255) DEFAULT NULL,
  `needinlite` tinyint(4) DEFAULT '0',
  `ispassword` tinyint(4) DEFAULT '0',
   visible boolean default true,
   configgroup VARCHAR(20),
   PRIMARY KEY (`jobparmid`),
   UNIQUE KEY `jobparm_unq_1` (`jobparmtype`,`jobparmkey`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobstep` (
  `jobstepid` int(11) NOT NULL AUTO_INCREMENT,
  `jobstepname` varchar(255) DEFAULT NULL,
  `jobsteporder` int(11) DEFAULT NULL,
  `multipredecessor` tinyint(1) DEFAULT '0',
  `predecessor` int(11) DEFAULT NULL,
  `multipredecessorid` int(11) DEFAULT NULL,
  `jobid` int(11) DEFAULT NULL,
  `jobtype` varchar(30) DEFAULT NULL,
  `internalreferencetype` varchar(30) DEFAULT NULL,
  `internalreferenceid` int(11) DEFAULT NULL,
  `extjobid` varchar(100) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `lastrundate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `userid` varchar(255) DEFAULT NULL,
  `jobflowstepid` int(11) DEFAULT NULL,
  `updatedby` varchar(50) DEFAULT NULL,
  `instanceid` varchar(100) default null,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`jobstepid`),
  KEY `intreferenceid` (`internalreferenceid`),
  KEY `jobstep_idx` (`jobtype`,`internalreferencetype`,`lastrundate`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobstepmultithread` (
  `jobstepmultithreadid` int(11) NOT NULL AUTO_INCREMENT,
  `jobstepid` int(11) NOT NULL,
  `threadnumber` int(11) DEFAULT NULL,
  `objecttype` int(11) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `lastupdatedate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`jobstepmultithreadid`),
  KEY `jobstp_idx` (`jobstepid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobstepthreadstatus` (
  `jobstepthreadstatusid` int(11) NOT NULL AUTO_INCREMENT,
  `jobstepid` int(11) NOT NULL,
  `threadnumber` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `lastupdatedate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`jobstepthreadstatusid`),
  UNIQUE KEY `jsts_jobstepid_thnumber` (`jobstepid`,`threadnumber`),
  KEY `jobstp_idx` (`jobstepid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobstepvar` (
  `jobstepvarid` int(11) NOT NULL AUTO_INCREMENT,
  `jobstepid` int(11) DEFAULT NULL,
  `vartype` varchar(100) DEFAULT NULL,
  `var` varchar(255) DEFAULT NULL,
  `vartext` mediumtext,
  `varint` int(11) DEFAULT NULL,
  `vardouble` double DEFAULT NULL,
  `varlong` mediumtext,
  PRIMARY KEY (`jobstepvarid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `jobvariable` (
  `jobvariableid` int(11) NOT NULL AUTO_INCREMENT,
  `jtype` varchar(50) DEFAULT NULL,
  `jkey` varchar(50) DEFAULT NULL,
  `jvalue` varchar(255) DEFAULT NULL,
  `jdescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`jobvariableid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `license` (
  `lickey` varchar(1024) DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `lineage` (
  `lineageid` int(11) NOT NULL AUTO_INCREMENT,
  `sourceref` varchar(50) DEFAULT NULL,
  `sourceid` int(11) DEFAULT NULL,
  `targetref` varchar(50) DEFAULT NULL,
  `targetid` int(11) DEFAULT NULL,
  `lastmoddate`  datetime NULL,
  `lastmoduser`  varchar(64) NULL,
  `createdate`  datetime NULL,
  PRIMARY KEY (`lineageid`),
  KEY `source_index` (`sourceid`,`sourceref`),
  KEY `target_index` (`targetid`,`targetref`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `lineagecolumn` (
  `lineagecolumnid` int(11) NOT NULL AUTO_INCREMENT,
  `sourcecolumnid` int(11) NOT NULL,
  `sourcecolumntype` varchar(50) NOT NULL,
  `destinationcolumnid` int(11) NOT NULL,
  `destinationcolumntype` varchar(50) NOT NULL,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastmoduser` varchar(255) NOT NULL,
  `lineageid` int(11) NOT NULL,
  `comment` text,
  lineageextid int,
  PRIMARY KEY (`lineagecolumnid`),
  KEY `target_index` (`destinationcolumnid`,`destinationcolumntype`),
  KEY `source_index` (`sourcecolumnid`,`sourcecolumntype`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE log (
  logid int(10) NOT NULL AUTO_INCREMENT,
  jobid varchar(100) DEFAULT NULL,
  logtext longtext,
  logdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  level int(11) default 20000,
  ipaddress varchar(50) DEFAULT NULL,
  servername varchar(150) DEFAULT NULL,
  httpsessionid varchar(200) DEFAULT NULL,
  userid varchar(50) DEFAULT NULL,
  version int default 1,
  PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `message` (
  `MESSAGEID` int(11) NOT NULL AUTO_INCREMENT,
  `HASHTAGORUSERID` varchar(50) DEFAULT NULL,
  `COMMENTID` varchar(50) DEFAULT NULL,
  `ISREAD` tinyint(1) DEFAULT '0',
  `NEEDANSWER` tinyint(1) DEFAULT '0',
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  markasdone tinyint(1) DEFAULT 0,
  PRIMARY KEY (`MESSAGEID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `multipredecessor` (
  `multipredecessorid` int(11) NOT NULL AUTO_INCREMENT,
  `jobstepid` int(11) DEFAULT NULL,
  `predecessor` int(11) DEFAULT NULL,
  PRIMARY KEY (`multipredecessorid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `objectendorsement` (
  `objectendorsementid` int(11) NOT NULL AUTO_INCREMENT,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `endorsementtype` varchar(20) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `message` text,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lineageflag` tinyint(4) DEFAULT '0',
  objectidref int(11),
  PRIMARY KEY (`objectendorsementid`),
  KEY `idx_obj` (`objecttype`,`objectid`,`userid`),
  KEY `idx_message` (`message`(500))
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oecolumn` (
  `oecolumnid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `columndescription` varchar(256) DEFAULT NULL,
  `oecolumntype` varchar(256) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` double DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `nullcount` bigint(20) DEFAULT NULL,
  `distinctcount` bigint(20) DEFAULT NULL,
  `typestats` text,
  `topvalues` mediumtext default null COMMENT 'This is for the top values of table column',
  `mask` tinyint(4) DEFAULT '0',
  `restricted` tinyint(4) DEFAULT '0',
  `columnposition` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  status int(2),
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  ispkorfk VARCHAR(50) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index',
  externalid varchar(256) DEFAULT null COMMENT 'To save necessary remote ids when crawling, creating this for quickbase now',
  PRIMARY KEY (`oecolumnid`),
  UNIQUE KEY `oecolumn_tblid_col` (`oetableid`,`columnname`),
  KEY `oecolumnid_idx` (`oecolumnid`),
  KEY `oetableid_idx` (`oetableid`),
  KEY `oecolumn_idx` (`columnname`,`columndescription`),
  KEY `idx_oecolumn_bgid` (`businessglossaryid`),
  FULLTEXT KEY `topvalues` (`topvalues`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oecolumntimeline` (
  `oecolumntimelineid` int(11) NOT NULL AUTO_INCREMENT,
  `oetabletimelineid` int(11) NOT NULL,
  `oecolumnid` int(11) NOT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `columndescription` varchar(256) DEFAULT NULL,
  `oecolumntype` varchar(256) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` double DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` int(11) DEFAULT NULL,
  `distinctcount` int(10) DEFAULT NULL,
  `typestats` text,
  `topvalues` text,
  `mask` tinyint(4) DEFAULT '0',
  `restricted` tinyint(4) DEFAULT '0',
  `columnposition` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `status` int(2),
  `lastmoddate` TIMESTAMP NULL DEFAULT NULL,
  `createdate` TIMESTAMP NULL DEFAULT NULL,
  `certifieddate` TIMESTAMP NULL DEFAULT NULL,
  `lastpopulateddate` TIMESTAMP NULL DEFAULT NULL,
  `lastmodby` VARCHAR(50) DEFAULT NULL,
  `certifiedby` VARCHAR(50) DEFAULT NULL,
  `createdby` VARCHAR(50) DEFAULT NULL,
  `certifiedtype` VARCHAR(20) DEFAULT NULL,
  `lastupdatereference` VARCHAR(30) DEFAULT NULL,
  PRIMARY KEY (`oecolumntimelineid`),
  KEY `oecolumntimelineid_idx` (`oecolumntimelineid`),
  KEY `oetabletimelineid_idx` (`oetabletimelineid`),
  KEY `oecolumnid_idx` (`oecolumnid`),
  KEY `oetableid_idx` (`oetableid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oeobject` (
  `oeobjectid` int(11) NOT NULL AUTO_INCREMENT,
  `objectname` varchar(255) NOT NULL,
  `content` text,
  `type` varchar(10) DEFAULT NULL,
  `oeschemaid` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`oeobjectid`),
  UNIQUE KEY `oeobject_nm` (`oeschemaid`,`objectname`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oeschema` (
  `oeschemaid` int(11) NOT NULL AUTO_INCREMENT,
  `schemaname` varchar(255) DEFAULT NULL,
  `connectioninfoid` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `active` tinyint(4) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `lastprofileddate` timestamp NULL DEFAULT NULL,
  `crawled` tinyint(4) DEFAULT NULL,
  `usescore` int(11),	
  description varchar(255),
  createdate timestamp NULL DEFAULT NULL,
  owner varchar(50),
  steward varchar(50),
  lastcrawldate timestamp NULL DEFAULT NULL,
  lastcrawlstatus VARCHAR(20) DEFAULT NULL,
  prevcrawldate TIMESTAMP NULL DEFAULT NULL COMMENT 'This column holds the crawl date prior to lastcrawldate',
  externalid varchar(256) DEFAULT null COMMENT 'To save necessary remote ids when crawling, creating this for quickbase now',
  PRIMARY KEY (`oeschemaid`),
  UNIQUE KEY `oeschema_db` (`schemaname`,`connectioninfoid`),
  KEY `connectioninfoid_idx` (`connectioninfoid`),
  KEY `oeschemaid_idx` (`oeschemaid`),
  KEY `idx_oeschema_bgid` (`businessglossaryid`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oetable` (
  `oetableid` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) DEFAULT NULL,
  `oeschemaid` int(11) DEFAULT NULL,
  `tablename` varchar(256) DEFAULT NULL,
  `tabledescription` varchar(255) DEFAULT NULL,
  `filename` varchar(400) DEFAULT NULL,
  `filetype` varchar(40) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `active` tinyint(4) DEFAULT '0',
  `sampletable` varchar(100) DEFAULT NULL,
  `rowcount` bigint(20) DEFAULT NULL,
  `tablescore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `lastanalyzeddate` timestamp NULL DEFAULT NULL,
  `analyzedstatus` varchar(50) DEFAULT 'Not Analyzed',
  `blurstatus` tinyint(1) DEFAULT '0',
  `lastblurdate` date DEFAULT NULL,
  `location` varchar(900) DEFAULT NULL,
  `columnsecure` tinyint(4) DEFAULT '0',
  `partitioned` tinyint(4) DEFAULT '0',
  `rawind` tinyint(4) DEFAULT '1',
  `lastpopulateddate` timestamp NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `remotetags` TEXT DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  owner varchar(50),
  steward varchar(50),
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  createddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `px` double DEFAULT '0',
  `py` double DEFAULT '0',
  `x` double DEFAULT '0',
  `y` double DEFAULT '0',
  dqindex double default null COMMENT 'This is for the data quality index',
  externalid varchar(256) DEFAULT null COMMENT 'To save necessary remote ids when crawling, creating this for quickbase now',
  PRIMARY KEY (`oetableid`),
  UNIQUE KEY `oetable_type_db_tbl` (`type`,`oeschemaid`,`tablename`),
  KEY `oetable_type_filet_filenm` (`type`,`filetype`,`filename`),
  KEY `oetableid_idx` (`oetableid`),
  KEY `oeschemaid_idx` (`oeschemaid`),
  KEY `oetable_idx` (`tablename`,`tabledescription`),
  KEY `idx_oetable_bgid` (`businessglossaryid`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oetablechanges` (
  `oetableid` int(11) NOT NULL DEFAULT '0',
  `rowcountchangedly` double DEFAULT NULL,
  `usescorechangedly` double DEFAULT NULL,
  `tablescorechangedly` double DEFAULT NULL,
  `rowcountchangewly` double DEFAULT NULL,
  `usescorechangewly` double DEFAULT NULL,
  `tablescorechangewly` double DEFAULT NULL,
  `rowcountchangemly` double DEFAULT NULL,
  `usescorechangemly` double DEFAULT NULL,
  `tablescorechangemly` double DEFAULT NULL,
  PRIMARY KEY (`oetableid`)
) ENGINE=InnoDB;


CREATE TABLE `oetabletimeline` (
  `oetabletimelineid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) NOT NULL,
  `rowcount` bigint(20) DEFAULT NULL,
  `tablescore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `lastanalyzeddate` VARCHAR(100) DEFAULT NULL,
  PRIMARY KEY (`oetabletimelineid`),
  KEY `oetabletimelineid_idx` (`oetabletimelineid`),
  KEY `oetableid_idx` (`oetableid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `operation` (
  `operationid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(40) DEFAULT NULL,
  `subtype` varchar(40) DEFAULT NULL,
  `var` text,
  `var1` varchar(100) DEFAULT NULL,
  `var2` varchar(100) DEFAULT NULL,
  `varint` int(100) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`operationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `partition_sample` (
  `PersonID` int(11) DEFAULT NULL,
  `LastName` varchar(255) DEFAULT NULL,
  `FirstName` varchar(255) DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `querytag` (
  `querytagid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetid` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`querytagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `queryuserstats` (
  `queryuserstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `datasetid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `queryuserscore` int(11) DEFAULT NULL,
  `numberlooked` int(11) DEFAULT NULL,
  `numbercommented` int(11) DEFAULT NULL,
  numberqueried int(11),
  PRIMARY KEY (`queryuserstatsid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `regextable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `functionid` int(11) DEFAULT NULL,
  `filestructureid` int(11) DEFAULT NULL,
  `columnname` varchar(50) DEFAULT NULL,
  `inputvalue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `remotetableinfo` (
  `remotetableinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) DEFAULT NULL,
  `dbname` varchar(100) DEFAULT NULL,
  `rtablename` varchar(100) DEFAULT NULL,
  `columnname` text,
  `name` varchar(100) DEFAULT NULL,
  `hiveschema` varchar(50) DEFAULT NULL,
  `hivetable` varchar(100) DEFAULT NULL,
  `partitionformat` varchar(100) DEFAULT NULL,
  `batchid` int(11) NOT NULL,
  `incrementedcolumn` varchar(100) DEFAULT NULL,
  `incrementedvalue` varchar(100) DEFAULT NULL,
  `jobname` varchar(50) DEFAULT NULL,
  `incrementalthread` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`remotetableinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `roles` (
  `ROLEID` int(11) NOT NULL AUTO_INCREMENT,
  `AUTHORITY` varchar(100) NOT NULL,
  `mrprocessingquota` bigint(20) DEFAULT NULL,
  `sqlprocessingquota` bigint(20) DEFAULT NULL,
  `indexingquota` bigint(20) DEFAULT NULL,
  defaultrole tinyint(4),
  defaultpermission int(10),
  licensetype tinyint default 1,
  PRIMARY KEY (`ROLEID`),
  KEY `authority_idx` (`AUTHORITY`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `s3connectioninfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accesskey` varchar(100) DEFAULT NULL,
  `secratekey` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `s3importinfo` (
  `s3infoid` int(11) NOT NULL AUTO_INCREMENT,
  `s3conid` int(11) DEFAULT NULL,
  `s3path` varchar(200) DEFAULT NULL,
  `hdfspath` varchar(200) DEFAULT NULL,
  `batchid` int(11) DEFAULT NULL,
  `jobname` varchar(200) DEFAULT NULL,
  `overwrite` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`s3infoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `sampletable` (
  `test01` int(11) DEFAULT NULL,
  `test02` varchar(100) DEFAULT NULL,
  `test04` varchar(100) DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `schedule` (
  `SCHEDULEID` int(11) NOT NULL AUTO_INCREMENT,
  `DESCRIPTION` text,
  `CRONENTRY` varchar(50) DEFAULT NULL,
  `USERID` varchar(50) DEFAULT NULL,
  `ACTIVE` tinyint(4) DEFAULT '0',
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `CLASSNAME` varchar(255) DEFAULT NULL,
  `jobflowid` int(11) DEFAULT NULL,
  CONTEXT int(11) default 0,
  `ENABLED` tinyint DEFAULT 1,
  PRIMARY KEY (`SCHEDULEID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `schematag` (
  `schematagid` int(11) NOT NULL AUTO_INCREMENT,
  `oeschemaid` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`schematagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `schemaxref` (
  `schemaxrefid` int(11) NOT NULL AUTO_INCREMENT,
  `hiveschemaid` int(11) DEFAULT NULL,
  `schemaname_hive` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`schemaxrefid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `shellprocessor` (
  `shellprocessorid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) DEFAULT NULL,
  `servertype` varchar(30) DEFAULT NULL,
  `shellname` varchar(100) DEFAULT NULL,
  `commands` text,
  `userid` varchar(100) DEFAULT NULL,
  `saved` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`shellprocessorid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE stg_tbl_catalog (
 id int(11) NOT NULL AUTO_INCREMENT,
 database_name varchar(100),
 schema_name varchar(100),
 table_name varchar(100),
 column_name varchar(100),
 title varchar(200),
 rowcount int(11),
 business_description text,
 processed_flag tinyint default 0,
 error_msg varchar(500) DEFAULT NULL, 
 lastpopulateddate date NULL,
 lastmetasyncdate date NULL,
 inaudit tinyint(4) DEFAULT NULL,
 lastmoddate timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
 createdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 batchno varchar(50) DEFAULT NULL,
 tcf1 varchar(255) DEFAULT NULL,
 tcf2 varchar(255) DEFAULT NULL,
 tcf3 varchar(255) DEFAULT NULL,
 tcf4 varchar(255) DEFAULT NULL,
 tcf5 varchar(255) DEFAULT NULL,
 tcf6 varchar(255) DEFAULT NULL,
 tcf7 varchar(255) DEFAULT NULL,
 tcf8 varchar(255) DEFAULT NULL,
 tcf9 varchar(255) DEFAULT NULL,
 tcf10 varchar(255) DEFAULT NULL,
 tcf11 varchar(255) DEFAULT NULL,
 tcf12 varchar(255) DEFAULT NULL,
 tcf13 varchar(255) DEFAULT NULL,
 tcf14 varchar(255) DEFAULT NULL,
 tcf15 varchar(255) DEFAULT NULL,
 tcf16 varchar(255) DEFAULT NULL,
 tcf17 varchar(255) DEFAULT NULL,
 tcf18 varchar(255) DEFAULT NULL,
 tcf19 varchar(255) DEFAULT NULL,
 tcf20 varchar(255) DEFAULT NULL,
 tcf21 varchar(255) DEFAULT NULL,
 tcf22 varchar(255) DEFAULT NULL,
 tcf23 varchar(255) DEFAULT NULL,
 tcf24 varchar(255) DEFAULT NULL,
 tcf25 varchar(255) DEFAULT NULL,
 tcf26 varchar(255) DEFAULT NULL,
 tcf27 varchar(255) DEFAULT NULL,
 tcf28 varchar(255) DEFAULT NULL,
 tcf29 varchar(255) DEFAULT NULL,
 tcf30 varchar(255) DEFAULT NULL,
 tcf31 varchar(255) DEFAULT NULL,
 tcf32 varchar(255) DEFAULT NULL,
 tcf33 varchar(255) DEFAULT NULL,
 tcf34 varchar(255) DEFAULT NULL,
 tcf35 varchar(255) DEFAULT NULL,
 tcf36 varchar(255) DEFAULT NULL,
 tcf37 varchar(255) DEFAULT NULL,
 tcf38 varchar(255) DEFAULT NULL,
 tcf39 varchar(255) DEFAULT NULL,
 tcf40 varchar(255) DEFAULT NULL,
 tcf41 varchar(255) DEFAULT NULL,
 tcf42 varchar(255) DEFAULT NULL,
 tcf43 varchar(255) DEFAULT NULL,
 tcf44 varchar(255) DEFAULT NULL,
 tcf45 varchar(255) DEFAULT NULL,
 tcf46 varchar(255) DEFAULT NULL,
 tcf47 varchar(255) DEFAULT NULL,
 tcf48 varchar(255) DEFAULT NULL,
 tcf49 varchar(255) DEFAULT NULL,
 tcf50 varchar(255) DEFAULT NULL,
 domain_name varchar(100) DEFAULT NULL,
 term varchar(100) DEFAULT NULL,
 PRIMARY KEY (id)
);


CREATE TABLE `storyline` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parentid` int(11) DEFAULT NULL,
  `domainid` int(11) DEFAULT NULL,
  `story` longtext,
  `storypage` longtext,
  `createdby` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `createddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `storyorder` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `name` (`name`,`story`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `structureguide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filestructureid` int(11) DEFAULT NULL,
  `hivetableid` int(11) DEFAULT NULL,
  `hiveschemaid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `stxpackage` (
  `packageid` int(11) NOT NULL AUTO_INCREMENT,
  `packagename` varchar(200) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`packageid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `subscriber` (
  `SUBSCRIBERID` int(11) NOT NULL AUTO_INCREMENT,
  `CHARTID` int(11) DEFAULT NULL,
  `USERID` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SUBSCRIBERID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `table_comment_expert` (
  `expertid` int(11) NOT NULL AUTO_INCREMENT,
  `tableid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `schemaid` int(11) DEFAULT NULL,
  `filefolderid` int(11) DEFAULT NULL,
  PRIMARY KEY (`expertid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tableendorsement` (
  `tableendorsementid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) DEFAULT NULL,
  `endorsementtype` varchar(20) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `message` text,
  `userid` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`tableendorsementid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tablemessage` (
  `MESSAGEID` int(11) NOT NULL AUTO_INCREMENT,
  `USERID` varchar(50) DEFAULT NULL,
  `COMMENTID` varchar(255) DEFAULT NULL,
  `ISREAD` tinyint(4) DEFAULT NULL,
  `LASTMODDATE` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`MESSAGEID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tablerelation` (
  `tablerelationid` int(11) NOT NULL AUTO_INCREMENT,
  `lefttableid` int(11) DEFAULT NULL,
  `righttableid` int(11) DEFAULT NULL,
  `leftpkfkscore` int(11) DEFAULT NULL,
  `rightpkfkscore` int(11) DEFAULT NULL,
  `similarityscore` int(11) DEFAULT NULL,
  `manuallyupdated` tinyint(4) DEFAULT NULL,
  `disabled` tinyint(4) DEFAULT NULL,
  `buildtype` varchar(16) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastupdatedate timestamp NULL DEFAULT NULL,
  lastupdatedby VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`tablerelationid`),
  KEY `tablerelation_lfttblid` (`lefttableid`) USING BTREE,
  KEY `tablerelation_rgttblid` (`righttableid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tabletag` (
  `TABLETAGID` int(11) NOT NULL AUTO_INCREMENT,
  `OETABLEID` int(11) DEFAULT NULL,
  `TAGID` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`TABLETAGID`),
  KEY `tableid_idx` (`OETABLEID`),
  KEY `tagid_idx` (`TAGID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tableuserstats` (
  `tableuserstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `tableuserscore` int(11) DEFAULT NULL,
  `numberlooked` int(11) DEFAULT NULL,
  `numberqueried` int(11) DEFAULT NULL,
  `numbercommented` int(11) DEFAULT NULL,
  PRIMARY KEY (`tableuserstatsid`),
  UNIQUE `unique_index`(`oetableid`, `userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tags` (
  `TAGID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TAGNAME` varchar(255) NOT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `tagtype` int(11) default 1,
  tagposition int(11) DEFAULT NULL,
  PRIMARY KEY (`TAGID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000 ROW_FORMAT=COMPACT;


CREATE TABLE `user` (
  `USERID` varchar(50) NOT NULL,
  `FNAME` varchar(50) NOT NULL,
  `LNAME` varchar(50) NOT NULL,
  `EMAIL` varchar(50) NOT NULL,
  `GENDER` varchar(50) null,
  `city_state` varchar(255),
  `zip` int (11),
  `PERSONAL_PHONE` varchar(50) NOT NULL,
  `PASSWORD` varchar(256) NOT NULL,
  `ADDRESS` longtext,
  `notifyviaemail` tinyint(1),
  `AUTHORITIES` varchar(50),
  `TITLE` varchar(50) NOT NULL,
  `status` varchar(16) DEFAULT NULL,
  `usertype` varchar(50) DEFAULT NULL,
  token varchar(255) DEFAULT NULL,
  licenseaccepted tinyint(1) default 0,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  outofoffice tinyint(4) default 0,
  managerid varchar(50) DEFAULT NULL,
  dgmanagerid varchar(50) DEFAULT NULL,
  dcmanagerid varchar(50) DEFAULT NULL,
  allowusermention TINYINT(4) DEFAULT 0,
  allowwatchlistalert TINYINT(4) DEFAULT 0,
  allowsystemalert TINYINT(4) DEFAULT 0,
  allowdqralert tinyint(4) COMMENT 'This allows to send email alerts for DQR',
  allowservicedeskalert tinyint(4) COMMENT'This allows to send email alerts for service desk',
  slackid VARCHAR(50) DEFAULT NULL,
  licensetype tinyint default 1,
   usersecret varchar(256),
  PRIMARY KEY (`USERID`),
  KEY `USERID` (`USERID`)
) ENGINE=InnoDB;


CREATE TABLE `user_role` (
  `USERID` varchar(50) NOT NULL,
  `ROLEID` int(11) NOT NULL,
  PRIMARY KEY (`USERID`,`ROLEID`),
  KEY `fk_RoleId` (`ROLEID`),
  createddate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  createdby VARCHAR(50) DEFAULT NULL,
  CONSTRAINT `fk_RoleId` FOREIGN KEY (`ROLEID`) REFERENCES `roles` (`ROLEID`) ON DELETE CASCADE,
  CONSTRAINT `fk_UserId` FOREIGN KEY (`USERID`) REFERENCES `user` (`USERID`) ON DELETE CASCADE
) ENGINE=InnoDB;


CREATE TABLE `userdashboard` (
  `USERDASHBOARDID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_USERID` varchar(50) NOT NULL DEFAULT '',
  `DASHBOARD_DASHBOARDID` int(11) DEFAULT NULL,
  `DEFAULTDASH` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`USERDASHBOARDID`),
  KEY `USERDASHBOARDID` (`USERDASHBOARDID`),
  KEY `USER_USERID` (`USER_USERID`),
  KEY `fk_DASHBOARD_DASHBOARDID` (`DASHBOARD_DASHBOARDID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `userfavorite` (
  `userfavoriteid` int(11) NOT NULL AUTO_INCREMENT,
  `favname` varchar(200) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `favobj` varchar(50) DEFAULT NULL,
  `link` varchar(500) DEFAULT NULL,
  `pinned` tinyint(4) DEFAULT NULL,
  `favdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  sortorder int(11) default 0 COMMENT 'This column represents the position of the Bookmarks',
  PRIMARY KEY (`userfavoriteid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `usersearchhistory` (
  `usersearchhistoryid` int(11) NOT NULL AUTO_INCREMENT,
  `userid` varchar(50) DEFAULT NULL,
  `searchobj` varchar(50) DEFAULT NULL,
  `mainid` int(11) DEFAULT NULL,
  `childid` int(11) DEFAULT NULL,
  `displayval` varchar(100) DEFAULT NULL,
  `lastsearchdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`usersearchhistoryid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `variableassociation` (
  `ID` int(100) NOT NULL AUTO_INCREMENT,
  `DATASETID` int(100) DEFAULT NULL,
  `VARIABLENAME` varchar(255) DEFAULT 'var',
  `ASSOCIATEDATASETID` int(255) DEFAULT '12',
  `ASSOCIATEFIELD` varchar(255) DEFAULT 'field',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `version` (
  `dbversion` int(11) NOT NULL,
  `appversion` int(11) DEFAULT NULL,
  `comments` varchar(200) DEFAULT NULL,
  `dbminorversion` float,
  `createdate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updatedate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;


CREATE TABLE `wiki` (
  `wikiid` int(10) NOT NULL AUTO_INCREMENT,
  `wikiobject` varchar(20) DEFAULT NULL,
  `wikiobjectid` int(10) DEFAULT NULL,
  `wikitext` text,
  `version` int(11) DEFAULT NULL,
  `techtext` text,
  `lastupdatetime` datetime DEFAULT NULL,
  `lastupdateuser` varchar(100) DEFAULT NULL,
  `techlastupdatetime` datetime DEFAULT NULL,
  `techlastupdateuser` varchar(100) DEFAULT NULL,
  `wikitextplain` text   COMMENT 'This column is to store plainText of Business Description',
  `techtextplain` text   COMMENT 'This column is to store plainText of Technical Description',
  PRIMARY KEY (`wikiid`),
  KEY `wiki_idx` (`wikiobjectid`,`wikiobject`,`wikitext`(100)),
  KEY `idx_tech` (`techtext`(500)),
  FULLTEXT KEY `wiki_index` (`wikitext`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table jobstepsubjob (
	jobstepsubjobid int NOT NULL AUTO_INCREMENT,
	jobstepid int NOT NULL,
	oeschemaid int(11),
	oetableid int(11),
	oecolumnid int(11),
	extsubjobid varchar(255), 
	threadnumber int,
	status varchar(100),
	vartype varchar(100),
	vartextsmall  varchar(255),
	vartextmedium mediumtext,
	varint  int,
	vardouble double,
	varlong long,
	extStatusMessage varchar(255),
	lastupdatedate timestamp NULL,
	PRIMARY KEY (`jobstepsubjobid`), 
	KEY jobstpsubjob_idx (jobstepid),
	KEY jobstptable_idx (oetableid),
	KEY subjob_idx (extsubjobid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `filecolumn` (
  `filecolumnid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11) NOT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `columntype` varchar(50) DEFAULT NULL,
  `columndescription` varchar(256) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` int(11) DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` bigint(20) DEFAULT NULL,
  `distinctcount` bigint(20) DEFAULT NULL,
  `typestats` text DEFAULT NULL,
  `topvalues` text DEFAULT NULL,
  `mask` tinyint(4) DEFAULT 0,
  `restricted` tinyint(4) DEFAULT 0,
  `columnposition` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp,
  `active` tinyint(4) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `firsthundred` text DEFAULT NULL,
  `patternstats` varchar(256),	
  createdate timestamp NULL DEFAULT NULL,
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index',
  PRIMARY KEY (`filecolumnid`),
  KEY `idx_filecolumn_bgid` (`businessglossaryid`),
  KEY `idx_active` (`active`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table custom_table_catalog(
	schemaname varchar(255),
	tablename varchar(255),
	columnname varchar(255),
	columntype varchar(255),
	columncomment varchar(255),
	connectioninfoid int
);


create table connectionhelper(
	servertype varchar(100),
	processingclass varchar(255),
	ipaddressneed tinyint(1), 
	portnumberneed tinyint(1),
	usernameneed tinyint(1),
	passwordneed tinyint(1),
	connectionstringneed tinyint(1),
	sidneed tinyint(1),
	drivernameneed tinyint(1),
	par1 varchar(255),
	par2 varchar(255),
	par3 varchar(255),
	par4 varchar(255),
	par5 varchar(255),
	par6 varchar(255),
	par7 varchar(255),
	par8 varchar(255),
	par9 varchar(255)
);

create table project (
	projectid int(11) NOT NULL AUTO_INCREMENT,
	projectname varchar(150),
	description text,
	sharecontent tinyint(1),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	defaultproj tinyint(1),
	PRIMARY KEY (projectid),
	UNIQUE KEY uq_projectname (projectname, createdby)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table projectuser (
	projectuserid int(11)  NOT NULL AUTO_INCREMENT,
	projectid int(11),
	userid varchar(50),
	defaultproj tinyint(1) DEFAULT false,
	confirmed tinyint(1),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	PRIMARY KEY (projectuserid),
	UNIQUE `unique_index`(`projectid`, `userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table projectcontent(
	projectcontentid int(11)  NOT NULL AUTO_INCREMENT,
	projectid int(11),
	assobject 	varchar(50),
	assobjectid int(11),
	notes MEDIUMTEXT DEFAULT NULL,
	version 	int(11),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	PRIMARY KEY (projectcontentid),
	KEY `idx_obj` (`assobject`,`assobjectid`),
  	KEY `idx_notes` (`notes`(500))
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table businessgroup(
	businessgroupid int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	PRIMARY KEY (businessgroupid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table businessglossaryrelation(
	businessglossaryrelationid int(11) NOT NULL AUTO_INCREMENT,
	businessgroupid int(11),
	businessglossaryid int(11),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	PRIMARY KEY (businessglossaryrelationid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


create table dataasset(
	dataassetid int(11) NOT NULL AUTO_INCREMENT,
	name varchar(255),
	definition text,
	owner varchar(255),
	steward varchar(255),
	parentdataassetid int(11),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	PRIMARY KEY (dataassetid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE  `multilang` (
	`language` varchar(50)  NOT NULL,
	`screenkey` varchar(256)  NOT NULL,
	`screenvalue` text  NOT NULL,
	`screendesc` text DEFAULT NULL,
	KEY `screenkey_idx` (`screenkey`),
	KEY `language_idx` (`language`),
	UNIQUE KEY `lang_screenvalue_idx` (`language`,`screenkey`)
);

CREATE TABLE `globaldomain` (
    `globaldomainid` INT(11) NOT NULL AUTO_INCREMENT,
    `domain` VARCHAR(100) NOT NULL,
    `description` TEXT,
    `domaintype` VARCHAR(50) NOT NULL,
    `reviewer` VARCHAR(50) NOT NULL,
    `steward` VARCHAR(50) NOT NULL,
    createdby varchar(50) DEFAULT NULL,
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updatedby varchar(50) DEFAULT NULL,
    sortorder int(11) default 0 COMMENT 'This column represents the position of the Global Domains',
    PRIMARY KEY (`globaldomainid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `objectowner` (
  `objectownerid` int(11) NOT NULL AUTO_INCREMENT,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `steward` varchar(50) DEFAULT NULL,
  `approver` varchar(50) DEFAULT NULL,
   createdby varchar(50) DEFAULT NULL,
   createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
   updatedby varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objectownerid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `a_objectowner` (
  `objectownerid` int NOT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `steward` varchar(50) DEFAULT NULL,
   approver varchar(50) DEFAULT NULL,
   createdby varchar(50) DEFAULT NULL,
   createdate timestamp NULL DEFAULT NULL,
   lastmoddate timestamp NULL DEFAULT NULL,
   updatedby varchar(50) DEFAULT NULL
) ENGINE=InnoDB;


CREATE TABLE `code` (
  	`codeid` INT(11) NOT NULL AUTO_INCREMENT,
  	`codetype` varchar(50) DEFAULT NULL,
  	`codename` VARCHAR(160) DEFAULT NULL,
  	`codedescription` text,
  	parentid int(11) default 0,
	disabled boolean default false,
	connectioninfoid int(11) NOT NULL,
	objecttype varchar(100) NOT NULL,
	createdby varchar(100) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(100) DEFAULT NULL,
  	PRIMARY KEY (`codeid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `ticket` (
  `ticketid` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `status` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `definition` text,
  `expirationdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  permtype varchar(20) DEFAULT NULL,
  nextapprover varchar(50) default null,
  comments text,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  businessdesc text,
  assobjectid int(11) DEFAULT NULL,
  assetname VARCHAR(255),
  urlcontext varchar(500),
  requestpriority varchar(50) not null,
  priority varchar(50) not null,
  potentialamount int(11) default null,
  cronentry varchar(50) default null,
  resolveddate timestamp NULL DEFAULT NULL COMMENT 'This is used to get resolved time of a ticket',
  PRIMARY KEY (`ticketid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `accessexpiration` (
  `accessexpirationid` int(11) NOT NULL AUTO_INCREMENT,
  `acl_object_identity` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  `oldmask` int(11) DEFAULT NULL,
  `expirationdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `associatedticketid` int(11) DEFAULT NULL,
  PRIMARY KEY (`accessexpirationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `dataassetgroup` (
    `dataassetgroupid` INT(11) NOT NULL AUTO_INCREMENT,
    `globaldomainid` INT(11) DEFAULT NULL,
    `approver` VARCHAR(50) DEFAULT NULL,
    `secondaryowner` varchar(50),
    `secondarysteward` varchar(50),	
    `owner` VARCHAR(50) NOT NULL,
    `steward` VARCHAR(50) NOT NULL,
    tagid INT(11) NOT NULL,
    description text,
    objectid INT(11),
    objecttype VARCHAR(50),
    createdby varchar(50) DEFAULT NULL,
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updatedby varchar(50) DEFAULT NULL,
    manageownership tinyint,
    managestewardship tinyint,
    managesecurity tinyint,
    PRIMARY KEY (`dataassetgroupid`),
    KEY `idx_obj` (`objectid`,`objecttype`),
    KEY `idx_dagtag` (`tagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `businessglossary` (
    `businessglossaryid` INT(11) NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
     `status` VARCHAR(50),
    `description` TEXT,
    `version` integer default 0,
	`definition` TEXT,
    `steward` VARCHAR(50) NOT NULL,
    `approvedby` VARCHAR(50) NOT NULL,
	`globaldomainid` INT(11) NOT NULL ,
   `mask` boolean DEFAULT false,
   `rstrct` boolean DEFAULT false,
   `usescore` int(11) DEFAULT 0,
   `rating` FLOAT, 	
    approvaldate timestamp NULL,
    copydesc boolean default false,
    copybizdesc boolean default false,
    createdby varchar(50) DEFAULT NULL,
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updatedby varchar(50) DEFAULT NULL,
    classification1 boolean DEFAULT false,
	classification2 boolean DEFAULT false,
	classification3 boolean DEFAULT false,
	classification4 boolean DEFAULT false,
	classification5 boolean DEFAULT false,
	classification6 boolean DEFAULT false,
	classification7 boolean DEFAULT false,
	classification8 boolean DEFAULT false,
	classification9 boolean DEFAULT false,
	classification10 boolean DEFAULT false,
	category1id INT(11) DEFAULT NULL,
	category2id INT(11) DEFAULT NULL,
	showclassification boolean DEFAULT false,
	sortorder int(11) default 0,
	reviewer varchar(50) not null,
	authsrcobject varchar(50) DEFAULT NULL,
	authsrcobjectid int(11) DEFAULT NULL,
    PRIMARY KEY (`businessglossaryid`),
    KEY `globaldomainid_idx` (`globaldomainid`),
  	CONSTRAINT `globaldomainid_fk` FOREIGN KEY (`globaldomainid`) REFERENCES `globaldomain` (`globaldomainid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `auxinfo` (
  `auxinfoid` int(11) NOT NULL AUTO_INCREMENT,
  `auxobject` varchar(50) DEFAULT NULL,
  `auxobjectid` int(11) DEFAULT NULL,
  `auxcode1` int(11) DEFAULT NULL,
  `auxcode2` int(11) DEFAULT NULL,
  `auxcode3` int(11) DEFAULT NULL,
  `auxcode4` int(11) DEFAULT NULL,
  `auxcode5` int(11) DEFAULT NULL,
  `auxcode6` int(11) DEFAULT NULL,
  `auxcode7` int(11) DEFAULT NULL,
  `auxcode8` int(11) DEFAULT NULL,
  `auxcode9` int(11) DEFAULT NULL,
  `auxint1` int(11) DEFAULT NULL,
  `auxint2` int(11) DEFAULT NULL,
  `auxint3` int(11) DEFAULT NULL,
  `auxint4` int(11) DEFAULT NULL,
  `auxlong1` bigint(20) DEFAULT NULL,
  `auxlong2` bigint(20) DEFAULT NULL,
  `auxlong3` bigint(20) DEFAULT NULL,
  `auxlong4` bigint(20) DEFAULT NULL,
  `auxval1` varchar(255) DEFAULT NULL,
  `auxval2` varchar(255) DEFAULT NULL,
  `auxval3` varchar(255) DEFAULT NULL,
  `auxval4` varchar(255) DEFAULT NULL,
  `auxval5` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`auxinfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `tableuserlifestats` (
  `tableuserlifestatsid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) NOT NULL, 
  `userid` varchar(256) DEFAULT NULL,
  `year` varchar(250) DEFAULT NULL,
  `wtd` varchar(1000) NOT NULL,
  `mtd` varchar(500) DEFAULT NULL,
  `ytd` varchar(50) DEFAULT NULL,
   createdby varchar(50) DEFAULT NULL,
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updatedby varchar(50) DEFAULT NULL,
    PRIMARY KEY (`tableuserlifestatsid`) 
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `oetablepartition` (
  `oetablepartitionid` int(11) NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) DEFAULT NULL,
  `oecolumnid1` int(11) DEFAULT NULL,
  `oecolumnid2` int(11) DEFAULT NULL,
  `oecolumnid3` int(11) DEFAULT NULL,
  `oecolumnid4` int(11) DEFAULT NULL,
  `partitionname` varchar(255) DEFAULT NULL,
  `analyzed` tinyint(1) DEFAULT NULL,
  `lastanalyzeddate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `rowcount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`oetablepartitionid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE QRTZ_JOB_DETAILS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
);

CREATE TABLE QRTZ_SIMPLE_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CRON_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_SIMPROP_TRIGGERS (          
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP) 
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_BLOB_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_CALENDARS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
);

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
);

CREATE TABLE QRTZ_FIRED_TRIGGERS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
);

CREATE TABLE QRTZ_SCHEDULER_STATE (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
);

CREATE TABLE QRTZ_LOCKS (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
);


CREATE TABLE `dataidentifierobject` (
  `dataidentifierobjectid` int(11) NOT NULL AUTO_INCREMENT,
  `dataidentifierid` int(11) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  PRIMARY KEY (`dataidentifierobjectid`),
  UNIQUE KEY `uq_object` (`dataidentifierid`,`objecttype`,`objectid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `backlink` (
  `backlinkid` int(11) NOT NULL AUTO_INCREMENT,
  `mainobject` varchar(50) DEFAULT NULL,
  `mainobjectid` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `associatedobject` varchar(50) DEFAULT NULL,
  `associatedobjectid` int(11) DEFAULT NULL,
  `url` varchar(500) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`backlinkid`),
  KEY `mainobject` (`mainobject`,`mainobjectid`),
  KEY `associatedobject` (`associatedobject`,`associatedobjectid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `images` (
  `imageid` int(11) NOT NULL AUTO_INCREMENT,
  `context` varchar(255) DEFAULT NULL,
  `imagename` varchar(255) DEFAULT NULL,
  `image` longblob,
  `version` int(10),
  `imageupload` tinyint(4) DEFAULT 0,
  PRIMARY KEY (`imageid`),
  UNIQUE KEY `uq_image` (`context`,`imagename`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE stg_glossary_catalog (
  id int(11) NOT NULL AUTO_INCREMENT,
  domain varchar(50) NOT NULL,
  name varchar(255) NOT NULL,
  description text,
  definition text,
  copydesc boolean default false,
  copybizdesc boolean default false,
  processed_flag tinyint(4) DEFAULT '0',
  error_msg  varchar(500) DEFAULT NULL,
  mask boolean DEFAULT false,
  rstrct boolean DEFAULT false,
  classification1 boolean DEFAULT false,
  classification2 boolean DEFAULT false,
  classification3 boolean DEFAULT false,
  classification4 boolean DEFAULT false,
  classification5 boolean DEFAULT false,
  classification6 boolean DEFAULT false,
  classification7 boolean DEFAULT false,
  classification8 boolean DEFAULT false,
  classification9 boolean DEFAULT false,
  classification10 boolean DEFAULT false,
  publish boolean DEFAULT false,
  showclassification boolean default false,
  category varchar(100) DEFAULT NULL,
  subcategory varchar(100) DEFAULT NULL,
  lastmoddate timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE columnrelationdataset (
    `datasetid` int(11) NOT NULL ,
    `columnrelationid` int(11) NOT NULL, 
    PRIMARY KEY (datasetid,columnrelationid)
);


CREATE TABLE tablerelationdataset (
    `datasetid` int(11) NOT NULL,
    `tablerelationid` int(11) NOT NULL, 
    PRIMARY KEY (datasetid,tablerelationid)
);


CREATE TABLE custom_objects (
  customobjectid int(11) NOT NULL AUTO_INCREMENT,
  objectid int(11) NOT NULL,
  objecttype varchar(50) NOT NULL,
  ccf1 int(11) DEFAULT NULL,
  ccf2 int(11) DEFAULT NULL,
  ccf3 int(11) DEFAULT NULL,
  ccf4 int(11) DEFAULT NULL,
  ccf5 int(11) DEFAULT NULL,
  ccf6 int(11) DEFAULT NULL,
  ccf7 int(11) DEFAULT NULL,
  ccf8 int(11) DEFAULT NULL,
  ccf9 int(11) DEFAULT NULL,
  ccf10 int(11) DEFAULT NULL,
  ccf11 int(11) DEFAULT NULL,
  ccf12 int(11) DEFAULT NULL,
  ccf13 int(11) DEFAULT NULL,
  ccf14 int(11) DEFAULT NULL,
  ccf15 int(11) DEFAULT NULL,
  tcf1 text DEFAULT null,
  tcf2 text DEFAULT null,
  tcf3 text DEFAULT null,
  tcf4 text DEFAULT null,
  tcf5 text DEFAULT null,
  tcf6 text DEFAULT null,
  tcf7 text DEFAULT null,
  tcf8 text DEFAULT null,
  tcf9 text DEFAULT null,
  tcf10 text DEFAULT null,
  tcf11 text DEFAULT null,
  tcf12 text DEFAULT null,
  tcf13 text DEFAULT null,
  tcf14 text DEFAULT null,
  tcf15 text DEFAULT null,
  tcf16 text DEFAULT null,
  tcf17 text DEFAULT null,
  tcf18 text DEFAULT null,
  tcf19 text DEFAULT null,
  tcf20 text DEFAULT null,
  tcf21 text DEFAULT null,
  tcf22 text DEFAULT null,
  tcf23 text DEFAULT null,
  tcf24 text DEFAULT null,
  tcf25 text DEFAULT null,
  tcf26 text DEFAULT null,
  tcf27 text DEFAULT null,
  tcf28 text DEFAULT null,
  tcf29 text DEFAULT null,
  tcf30 text DEFAULT null,
  tcf31 text DEFAULT null,
  tcf32 text DEFAULT null,
  tcf33 text DEFAULT null,
  tcf34 text DEFAULT null,
  tcf35 text DEFAULT null,
  tcf36 text DEFAULT null,
  tcf37 text DEFAULT null,
  tcf38 text DEFAULT null,
  tcf39 text DEFAULT null,
  tcf40 text DEFAULT null,
  tcf41 text DEFAULT null,
  tcf42 text DEFAULT null,
  tcf43 text DEFAULT null,
  tcf44 text DEFAULT null,
  tcf45 text DEFAULT null,
  tcf46 text DEFAULT null,
  tcf47 text DEFAULT null,
  tcf48 text DEFAULT null,
  tcf49 text DEFAULT null,
  tcf50 text DEFAULT null,
  ncf1 double(11,2) DEFAULT NULL,
  ncf2 double(11,2) DEFAULT NULL,
  ncf3 double(11,2) DEFAULT NULL,
  ncf4 double(11,2) DEFAULT NULL,
  ncf5 double(11,2) DEFAULT NULL,
  ncf6 double(11,2) DEFAULT NULL,
  ncf7 double(11,2) DEFAULT NULL,
  ncf8 double(11,2) DEFAULT NULL,
  ncf9 double(11,2) DEFAULT NULL,
  ncf10 double(11,2) DEFAULT NULL,
  ncf11 double(11,2) DEFAULT NULL,
  ncf12 double(11,2) DEFAULT NULL,
  ncf13 double(11,2) DEFAULT NULL,
  ncf14 double(11,2) DEFAULT NULL,
  ncf15 double(11,2) DEFAULT NULL,
  dcf1 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf2 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf3 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf4 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf5 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf6 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf7 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf8 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf9 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf10 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf11 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf12 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf13 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf14 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  dcf15 timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  connectioninfoid int(11) not null COMMENT 'this column is to store connectioninfoid for corresponding object',
  PRIMARY KEY (customobjectid),
  UNIQUE KEY uq_co_ot_oid (objecttype, objectid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE custom_object_def (
  customobjectdefid int(11) NOT NULL AUTO_INCREMENT,
  objecttype varchar(50) NOT NULL,
  connectioninfoid int(11) NOT NULL,
  ccf1 varchar(160) DEFAULT NULL,
  ccf1access int(11) default 0,
  ccf2 varchar(160) DEFAULT NULL,
  ccf2access int(11) default 0,
  ccf3 varchar(160) DEFAULT NULL,
  ccf3access int(11) default 0,
  ccf4 varchar(160) DEFAULT NULL,
  ccf4access int(11) default 0,
  ccf5 varchar(160) DEFAULT NULL,
  ccf5access int(11) default 0,
  ccf6 varchar(160) DEFAULT NULL,
  ccf6access int(11) default 0,
  ccf7 varchar(160) DEFAULT NULL,
  ccf7access int(11) default 0,
  ccf8 varchar(160) DEFAULT NULL,
  ccf8access int(11) default 0,
  ccf9 varchar(160) DEFAULT NULL,
  ccf9access int(11) default 0,
  ccf10 varchar(160) DEFAULT NULL,
  ccf10access int(11) default 0,
  ccf11 varchar(160) DEFAULT NULL,
  ccf11access int(11) default 0,
  ccf12 varchar(160) DEFAULT NULL,
  ccf12access int(11) default 0,
  ccf13 varchar(160) DEFAULT NULL,
  ccf13access int(11) default 0,
  ccf14 varchar(160) DEFAULT NULL,
  ccf14access int(11) default 0,
  ccf15 varchar(160) DEFAULT NULL,
  ccf15access int(11) default 0,
  tcf1 varchar(160) DEFAULT NULL,
  tcf1access int(11) default 0,
  tcf2 varchar(160) DEFAULT NULL,
  tcf2access int(11) default 0,
  tcf3 varchar(160) DEFAULT NULL,
  tcf3access int(11) default 0,
  tcf4 varchar(160) DEFAULT NULL,
  tcf4access int(11) default 0,
  tcf5 varchar(160) DEFAULT NULL,
  tcf5access int(11) default 0,
  tcf6 varchar(160) DEFAULT NULL,
  tcf6access int(11) default 0,
  tcf7 varchar(160) DEFAULT NULL,
  tcf7access int(11) default 0,
  tcf8 varchar(160) DEFAULT NULL,
  tcf8access int(11) default 0,
  tcf9 varchar(160) DEFAULT NULL,
  tcf9access int(11) default 0,
  tcf10 varchar(160) DEFAULT NULL,
  tcf10access int(11) default 0,
  tcf11 varchar(160) DEFAULT NULL,
  tcf11access int(11) default 0,
  tcf12 varchar(160) DEFAULT NULL,
  tcf12access int(11) default 0,
  tcf13 varchar(160) DEFAULT NULL,
  tcf13access int(11) default 0,
  tcf14 varchar(160) DEFAULT NULL,
  tcf14access int(11) default 0,
  tcf15 varchar(160) DEFAULT NULL,
  tcf15access int(11) default 0,
  tcf16 varchar(160) DEFAULT NULL,
  tcf16access int(11) default 0,
  tcf17 varchar(160) DEFAULT NULL,
  tcf17access int(11) default 0,
  tcf18 varchar(160) DEFAULT NULL,
  tcf18access int(11) default 0,
  tcf19 varchar(160) DEFAULT NULL,
  tcf19access int(11) default 0,
  tcf20 varchar(160) DEFAULT NULL,
  tcf20access int(11) default 0,
  tcf21 varchar(160) DEFAULT NULL,
  tcf21access int(11) default 0,
  tcf22 varchar(160) DEFAULT NULL,
  tcf22access int(11) default 0,
  tcf23 varchar(160) DEFAULT NULL,
  tcf23access int(11) default 0,
  tcf24 varchar(160) DEFAULT NULL,
  tcf24access int(11) default 0,
  tcf25 varchar(160) DEFAULT NULL,
  tcf25access int(11) default 0,
  tcf26 varchar(160) DEFAULT NULL,
  tcf26access int(11) default 0,
  tcf27 varchar(160) DEFAULT NULL,
  tcf27access int(11) default 0,
  tcf28 varchar(160) DEFAULT NULL,
  tcf28access int(11) default 0,
  tcf29 varchar(160) DEFAULT NULL,
  tcf29access int(11) default 0,
  tcf30 varchar(160) DEFAULT NULL,
  tcf30access int(11) default 0,
  tcf31 varchar(160) DEFAULT NULL,
  tcf31access int(11) default 0,
  tcf32 varchar(160) DEFAULT NULL,
  tcf32access int(11) default 0,
  tcf33 varchar(160) DEFAULT NULL,
  tcf33access int(11) default 0,
  tcf34 varchar(160) DEFAULT NULL,
  tcf34access int(11) default 0,
  tcf35 varchar(160) DEFAULT NULL,
  tcf35access int(11) default 0,
  tcf36 varchar(160) DEFAULT NULL,
  tcf36access int(11) default 0,
  tcf37 varchar(160) DEFAULT NULL,
  tcf37access int(11) default 0,
  tcf38 varchar(160) DEFAULT NULL,
  tcf38access int(11) default 0,
  tcf39 varchar(160) DEFAULT NULL,
  tcf39access int(11) default 0,
  tcf40 varchar(160) DEFAULT NULL,
  tcf40access int(11) default 0,
  tcf41 varchar(160) DEFAULT NULL,
  tcf41access int(11) default 0,
  tcf42 varchar(160) DEFAULT NULL,
  tcf42access int(11) default 0,
  tcf43 varchar(160) DEFAULT NULL,
  tcf43access int(11) default 0,
  tcf44 varchar(160) DEFAULT NULL,
  tcf44access int(11) default 0,
  tcf45 varchar(160) DEFAULT NULL,
  tcf45access int(11) default 0,
  tcf46 varchar(160) DEFAULT NULL,
  tcf46access int(11) default 0,
  tcf47 varchar(160) DEFAULT NULL,
  tcf47access int(11) default 0,
  tcf48 varchar(160) DEFAULT NULL,
  tcf48access int(11) default 0,
  tcf49 varchar(160) DEFAULT NULL,
  tcf49access int(11) default 0,
  tcf50 varchar(160) DEFAULT NULL,
  tcf50access int(11) default 0,
  ncf1 varchar(160) DEFAULT NULL,
  ncf1access int(11) default 0,
  ncf2 varchar(160) DEFAULT NULL,
  ncf2access int(11) default 0,
  ncf3 varchar(160) DEFAULT NULL,
  ncf3access int(11) default 0,
  ncf4 varchar(160) DEFAULT NULL,
  ncf4access int(11) default 0,
  ncf5 varchar(160) DEFAULT NULL,
  ncf5access int(11) default 0,
  ncf6 varchar(160) DEFAULT NULL,
  ncf6access int(11) default 0,
  ncf7 varchar(160) DEFAULT NULL,
  ncf7access int(11) default 0,
  ncf8 varchar(160) DEFAULT NULL,
  ncf8access int(11) default 0,
  ncf9 varchar(160) DEFAULT NULL,
  ncf9access int(11) default 0,
  ncf10 varchar(160) DEFAULT NULL,
  ncf10access int(11) default 0,
  ncf11 varchar(160) DEFAULT NULL,
  ncf11access int(11) default 0,
  ncf12 varchar(160) DEFAULT NULL,
  ncf12access int(11) default 0,
  ncf13 varchar(160) DEFAULT NULL,
  ncf13access int(11) default 0,
  ncf14 varchar(160) DEFAULT NULL,
  ncf14access int(11) default 0,
  ncf15 varchar(160) DEFAULT NULL,
  ncf15access int(11) default 0,
  dcf1 varchar(160) DEFAULT NULL,
  dcf1access int(11) default 0,
  dcf2 varchar(160) DEFAULT NULL,
  dcf2access int(11) default 0,
  dcf3 varchar(160) DEFAULT NULL,
  dcf3access int(11) default 0,
  dcf4 varchar(160) DEFAULT NULL,
  dcf4access int(11) default 0,
  dcf5 varchar(160) DEFAULT NULL,
  dcf5access int(11) default 0,
  dcf6 varchar(160) DEFAULT NULL,
  dcf6access int(11) default 0,
  dcf7 varchar(160) DEFAULT NULL,
  dcf7access int(11) default 0,
  dcf8 varchar(160) DEFAULT NULL,
  dcf8access int(11) default 0,
  dcf9 varchar(160) DEFAULT NULL,
  dcf9access int(11) default 0,
  dcf10 varchar(160) DEFAULT NULL,
  dcf10access int(11) default 0,
  dcf11 varchar(160) DEFAULT NULL,
  dcf11access int(11) default 0,
  dcf12 varchar(160) DEFAULT NULL,
  dcf12access int(11) default 0,
  dcf13 varchar(160) DEFAULT NULL,
  dcf13access int(11) default 0,
  dcf14 varchar(160) DEFAULT NULL,
  dcf14access int(11) default 0,
  dcf15 varchar(160) DEFAULT NULL,
  dcf15access int(11) default 0,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  PRIMARY KEY (customobjectdefid),
  UNIQUE KEY uq_cod_ciid_it (connectioninfoid, objecttype)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE a_wiki (
  wikiid int NOT NULL,
  wikiobject varchar(20) DEFAULT NULL,
  wikiobjectid int(10) DEFAULT NULL,
  wikitext text,
  version int(11) DEFAULT NULL,
  lastupdatetime datetime DEFAULT NULL,
  lastupdateuser varchar(100) DEFAULT NULL,
  type varchar(10) DEFAULT NULL,
  wikitextplain text  COMMENT 'This column is to store plainText of Business/Technical Description in archive',
  KEY wiki_idx (wikiobjectid, wikiobject, wikitext(100)),
  FULLTEXT KEY wiki_index (wikitext)
) ENGINE=InnoDB;

CREATE TABLE helpcenter_topic (
    topicid  int(11) NOT NULL AUTO_INCREMENT,
    description varchar(255) NOT NULL,
    content text,
	context varchar(100) NOT NULL,
   	active boolean default true,
	type varchar(200) NOT NULL,
    external_link varchar(255),
    createdby varchar(50) DEFAULT NULL,
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updatedby varchar(50) DEFAULT NULL,
    PRIMARY KEY (topicid),
    CONSTRAINT UQ_CONTEXT UNIQUE(context),
    INDEX(type)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE helpcenter_relation (
	topicid int(11) NOT NULL,
	childid int(11),
	relatedid int(11)
) ENGINE=InnoDB;

create TABLE  remoteuserpermissions(
  remoteuserpermissionid  int(11) NOT NULL AUTO_INCREMENT,
  userid varchar(256) NOT NULL, 
  objectid int(11),
  objecttype varchar(256) DEFAULT NULL,   
  permissions varchar(256) NULL,     
  lastmetasyncdate date NULL,  
  createdate date null,
  usertype varchar(255),
  PRIMARY KEY (remoteuserpermissionid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `filecolumntag` (
  `filecolumntagid` int(11) NOT NULL AUTO_INCREMENT,
  `filecolumnid` int(11) DEFAULT NULL,
  `tagid` int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`filecolumntagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `remoteusermapping` (
  `remoteusermappingid` int(11) NOT NULL AUTO_INCREMENT,
  `remoteuser` varchar(256) NOT NULL,
  `ovaledgeuser` varchar(256) DEFAULT NULL,
  connectioninfoid int,
  PRIMARY KEY (`remoteusermappingid`),
  UNIQUE KEY `user_permission` (`remoteuser`,`ovaledgeuser`,`connectioninfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE objecttag (
  objecttagid int(11) NOT NULL AUTO_INCREMENT,
  tagid int(11) NOT NULL,
  objectid int(11) NOT NULL,
  objecttype varchar(100) NOT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (objecttagid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE a_objecttag (
  objecttagid int NOT NULL,
  tagid int(11) NOT NULL,
  objectid int(11) NOT NULL,
  tagtype int(11) NOT NULL,
  objecttype varchar(100) NOT NULL,
  auditdate timestamp NULL DEFAULT NULL,
  audituser VARCHAR(50) NOT NULL,
  action varchar(50) DEFAULT NULL,
  objectname varchar(255) DEFAULT NULL,
  tagname varchar(255) DEFAULT NULL,
  parentid int(11) DEFAULT 0  COMMENT 'It has oecolumn,chartchild,filecolumn parentid '
) ENGINE=InnoDB;

CREATE TABLE glossary_relation (
	glossaryid int(11) NOT NULL,
	relatedid int(11) NOT NULL,
	type int default '1'
) ENGINE=InnoDB;

CREATE TABLE recommendedtag (
  recommendedtagid int(11) NOT NULL AUTO_INCREMENT,
  tagid int(11) DEFAULT NULL,
  objectid int(11) NOT NULL,
  objecttype varchar(50) NOT NULL,
  recommendedtagid1 int(11) DEFAULT NULL,
  recommendedtagid2 int(11) DEFAULT NULL,
  recommendedtagid3 int(11) DEFAULT NULL,
  tagidd int(11) DEFAULT NULL,
  PRIMARY KEY (recommendedtagid),
  INDEX (`tagid`, `objectid`,`objecttype`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `a_remoteuserpermissions` (
  `remoteuserpermissionid` int(11) NOT NULL,
  `userid` varchar(256) NOT NULL,
  `objectid` int(11),
  `objecttype` varchar(250)  DEFAULT NULL,
  `permissions` varchar(256) NULL,
  `lastmetasyncdate` date NULL,
  `createdate` date NULL,
  usertype varchar(255) ,
  UNIQUE KEY `user_permission` (`userid`,`objectid`,`objecttype`,`permissions`)
) ENGINE=InnoDB;

CREATE TABLE `recommendedtagfilter` (
  `recommendedtagfilterid` int(11) NOT NULL AUTO_INCREMENT,
  `databasefilter` varchar(255) DEFAULT NULL,
  `schemafilter` varchar(255) DEFAULT NULL,
  `objectname` varchar(255) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectdesc` varchar(255) DEFAULT NULL,
  `wiki` varchar(255) DEFAULT NULL,
  `tagfilter` varchar(255) DEFAULT NULL,
  `tagid` int(11) DEFAULT NULL,
  PRIMARY KEY (`recommendedtagfilterid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `tagrelationship` (
  `tagrelationshipid` int(11) NOT NULL AUTO_INCREMENT,
  `parenttagid` int(11) NOT NULL,
  `childtagid` int(11) NOT NULL,
  PRIMARY KEY (`tagrelationshipid`),
  UNIQUE KEY `parenttagid` (`parenttagid`,`childtagid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_tbl_connection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dbname` varchar(100) DEFAULT NULL,
  `hostip` varchar(100) DEFAULT NULL,
  `hostport` varchar(100) DEFAULT NULL,
  `dbusername` varchar(100) DEFAULT NULL,
  `dbpassword` varchar(250) DEFAULT NULL,
  `numthreads` varchar(100) DEFAULT NULL,
  `userowlimit` varchar(10) DEFAULT NULL,
  `maxrowsforprofiling` varchar(10) DEFAULT NULL,
  `dbprocessed` int(11) DEFAULT '0',
  `dbtype` varchar(100) DEFAULT NULL,
  `sid` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `folderdetail` (
  `folderdetailid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11)  ,
  `folderlevel` int(5) DEFAULT NULL,
  `noofsubfolders` int(7) DEFAULT NULL,
  `nooffiles` int(7) DEFAULT NULL,
  `filetypes` TEXT DEFAULT NULL,
  `storage` bigint(20),
  `files` mediumtext, 	
  `mindate` varchar(100) DEFAULT NULL,
  `maxdate` varchar(100) DEFAULT NULL,
  `name` varchar(2000) DEFAULT NULL,
  `extradetails` Text DEFAULT NULL, 
  PRIMARY KEY (`folderdetailid`),
 INDEX folderdetail_name_idx(fileid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `filetypes` (
        `filetypeid` int(11) NOT NULL AUTO_INCREMENT,
        `folderdetailid` int(11),
        `detailtype` varchar(50), 
        `detailKey` varchar(250),
        `count`   BIGINT(20), 
  PRIMARY KEY (`filetypeid`),
  INDEX filetypes_fd_idx(folderdetailid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table folderblueprint(
  `folderblueprintid` int(11) NOT NULL AUTO_INCREMENT,
  `fileid` int(11)  ,
  `blueprint` Text DEFAULT NULL, 
  PRIMARY KEY (`folderblueprintid`),
  INDEX folderblueprint_file_idx(fileid)	
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE objectuserstats (
  objectuserstatsid int(11) NOT NULL AUTO_INCREMENT,
  objectid int(11) DEFAULT NULL,
  objecttype varchar(256) NOT NULL,
  userid varchar(50) NOT NULL,
  userscore int(11) DEFAULT NULL,
  numberlooked int(11) DEFAULT NULL,
  numberqueried int(11) DEFAULT NULL,
  numbercommented int(11) DEFAULT NULL,
  PRIMARY KEY (objectuserstatsid),
  UNIQUE KEY unique_index (objectid, objecttype, userid),
  KEY idx_ous (objectid, objecttype)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE recommendedterm (
  recommendedtermid int(11) NOT NULL AUTO_INCREMENT,
  businessglossaryid int(11) DEFAULT NULL,
  objectid int(11) NOT NULL,
  objecttype varchar(50) NOT NULL,
  status int(11) DEFAULT 0,
  score double,
  fuzzyscore double,
  datascore double,
  patternscore double,
  upcount int(11) default 0,
  downcount int(11) default 0,
  PRIMARY KEY (recommendedtermid),
  UNIQUE KEY uq_bgoidotype (businessglossaryid, objectid, objecttype),
  KEY idx_rt_bgid (businessglossaryid),
  KEY idx_rt_oo (objectid, objecttype)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE recommendedterm_policy (
  policyid int(11) NOT NULL AUTO_INCREMENT,
  recommendedtermid int(11) NOT NULL,
  userid varchar(50) NOT NULL,
  thumbsup int(11) NOT NULL,
  PRIMARY KEY (policyid),
  UNIQUE KEY uq_rtuserid (recommendedtermid, userid),
  KEY idx_rtp_rtid (recommendedtermid),
  KEY idx_rtp_userid (userid),
  CONSTRAINT recommendedtermid_fk FOREIGN KEY (recommendedtermid) REFERENCES recommendedterm (recommendedtermid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `querycache` (
  `schemaid` int(11) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `query` text ,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `sch_usr_idx` (`schemaid`,`userid`)
) ENGINE=InnoDB;

CREATE TABLE objectauthor (
  objectauthorid int(11) NOT NULL AUTO_INCREMENT,
  objecttype varchar(50)  NOT NULL,
  objectid int(11) NOT NULL,
  userid varchar(50) NOT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  createddate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (objectauthorid),
  UNIQUE KEY uk_oauthor (objecttype, objectid, userid),
  KEY idx_oauthor (objectid, objecttype)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `remoterolepermissions` (
  `remoterolepermissionid` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` varchar(256) NOT NULL,
  `objectid` int(11) DEFAULT NULL,
  `objecttype` varchar(256) DEFAULT NULL,
  `permissions` varchar(256) DEFAULT NULL,
  `lastmetasyncdate` date DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  PRIMARY KEY (`remoterolepermissionid`),
  INDEX users_roles (roleid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `remoteurserroles` (
  `remoteuserroleid` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` varchar(256) NOT NULL,
  `userid` varchar(256) NOT NULL,
  `objectid` int(11) DEFAULT NULL,
  `objecttype` varchar(256) DEFAULT NULL,
  `lastmetasyncdate` date DEFAULT NULL,
  `createdate` date DEFAULT NULL,
  PRIMARY KEY (`remoteuserroleid`),
  INDEX users_roles (roleid,userid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_report_catalog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `database_name` varchar(100) DEFAULT NULL,
  `domain_name` varchar(100) DEFAULT NULL,
  `report_name` varchar(100) DEFAULT NULL,
  `report_field_name` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `content` text,
  `ccf1` varchar(200) DEFAULT NULL,
  `ccf2` varchar(200) DEFAULT NULL,
  `ccf3` varchar(200) DEFAULT NULL,
  `ccf4` varchar(200) DEFAULT NULL,
  `ccf5` varchar(200) DEFAULT NULL,
  `ccf6` varchar(200) DEFAULT NULL,
  `ccf7` varchar(200) DEFAULT NULL,
  `ccf8` varchar(200) DEFAULT NULL,
  `ccf9` varchar(200) DEFAULT NULL,
  `ccf10` varchar(200) DEFAULT NULL,
  `ccf11` varchar(200) DEFAULT NULL,
  `ccf12` varchar(200) DEFAULT NULL,
  `ccf13` varchar(200) DEFAULT NULL,
  `ccf14` varchar(200) DEFAULT NULL,
  `ccf15` varchar(200) DEFAULT NULL,
  `tcf1` varchar(200) DEFAULT NULL,
  `tcf2` varchar(200) DEFAULT NULL,
  `tcf3` varchar(200) DEFAULT NULL,
  `tcf4` varchar(200) DEFAULT NULL,
  `tcf5` varchar(200) DEFAULT NULL,
  `tcf6` varchar(200) DEFAULT NULL,
  `tcf7` varchar(200) DEFAULT NULL,
  `tcf8` varchar(200) DEFAULT NULL,
  `tcf9` varchar(200) DEFAULT NULL,
  `tcf10` varchar(200) DEFAULT NULL,
  `tcf11` varchar(200) DEFAULT NULL,
  `tcf12` varchar(200) DEFAULT NULL,
  `tcf13` varchar(200) DEFAULT NULL,
  `tcf14` varchar(200) DEFAULT NULL,
  `tcf15` varchar(200) DEFAULT NULL,
  `tcf16` varchar(200) DEFAULT NULL,
  `tcf17` varchar(200) DEFAULT NULL,
  `tcf18` varchar(200) DEFAULT NULL,
  `tcf19` varchar(200) DEFAULT NULL,
  `tcf20` varchar(200) DEFAULT NULL,
  `tcf21` varchar(200) DEFAULT NULL,
  `tcf22` varchar(200) DEFAULT NULL,
  `tcf23` varchar(200) DEFAULT NULL,
  `tcf24` varchar(200) DEFAULT NULL,
  `tcf25` varchar(200) DEFAULT NULL,
  `tcf26` varchar(200) DEFAULT NULL,
  `tcf27` varchar(200) DEFAULT NULL,
  `tcf28` varchar(200) DEFAULT NULL,
  `tcf29` varchar(200) DEFAULT NULL,
  `tcf30` varchar(200) DEFAULT NULL,
  `tcf31` varchar(200) DEFAULT NULL,
  `tcf32` varchar(200) DEFAULT NULL,
  `tcf33` varchar(200) DEFAULT NULL,
  `tcf34` varchar(200) DEFAULT NULL,
  `tcf35` varchar(200) DEFAULT NULL,
  `tcf36` varchar(200) DEFAULT NULL,
  `tcf37` varchar(200) DEFAULT NULL,
  `tcf38` varchar(200) DEFAULT NULL,
  `tcf39` varchar(200) DEFAULT NULL,
  `tcf40` varchar(200) DEFAULT NULL,
  `tcf41` varchar(200) DEFAULT NULL,
  `tcf42` varchar(200) DEFAULT NULL,
  `tcf43` varchar(200) DEFAULT NULL,
  `tcf44` varchar(200) DEFAULT NULL,
  `tcf45` varchar(200) DEFAULT NULL,
  `tcf46` varchar(200) DEFAULT NULL,
  `tcf47` varchar(200) DEFAULT NULL,
  `tcf48` varchar(200) DEFAULT NULL,
  `tcf49` varchar(200) DEFAULT NULL,
  `tcf50` varchar(200) DEFAULT NULL,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table oecolumntopvalues (
	oetableid int, 
	oecolumnid int,
	topvalue varchar(200),
	topcount long,
	oeschemaid int(11) DEFAULT NULL COMMENT 'This is for capturing schemaid to build relationships within the schema'
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_owner_steward_catalog` (
  `schemaname` varchar(100) DEFAULT NULL,
  `steward_fname` varchar(50) DEFAULT NULL,
  `steward_lname` varchar(50) DEFAULT NULL,
  `steward` varchar(100) DEFAULT NULL,
  dbname varchar(255) DEFAULT NULL,
  owner varchar(150) DEFAULT NULL,
  owneremail varchar(150) DEFAULT NULL,
  steward_full_name varchar(100) DEFAULT NULL,
  stewardemail varchar(150) DEFAULT NULL,
  tablename varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `a_objectterm` (
  `objecttermid` int NOT NULL,
  `objecttype` varchar(50) NOT NULL,
  `objectid` int(11) NOT NULL,
  `businessglossaryid` int(11) NOT NULL,
  auditdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  audituser varchar(50) DEFAULT NULL,
  action varchar(50) DEFAULT NULL,
  objectname varchar(255) DEFAULT NULL,
  termname varchar(255) not null,
  parentid int(11) DEFAULT 0 COMMENT 'It has oecolumn,chartchild,filecolumn parentid '
) ENGINE=InnoDB;

CREATE TABLE dataclassification (
  classificationid int(11) NOT NULL AUTO_INCREMENT,
  globaldomainid int(11) NOT NULL,
  classification1 varchar(100) DEFAULT NULL,
  classification2 varchar(100) DEFAULT NULL,
  classification3 varchar(100) DEFAULT NULL,
  classification4 varchar(100) DEFAULT NULL,
  classification5 varchar(100) DEFAULT NULL,
  classification6 varchar(100) DEFAULT NULL,
  classification7 varchar(100) DEFAULT NULL,
  classification8 varchar(100) DEFAULT NULL,
  classification9 varchar(100) DEFAULT NULL,
  classification10 varchar(100) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  defaultcf1 boolean DEFAULT false,
  defaultcf2 boolean DEFAULT false,
  defaultcf3 boolean DEFAULT false,
  defaultcf4 boolean DEFAULT false,
  defaultcf5 boolean DEFAULT false,
  defaultcf6 boolean DEFAULT false,
  defaultcf7 boolean DEFAULT false,
  defaultcf8 boolean DEFAULT false,
  defaultcf9 boolean DEFAULT false,
  defaultcf10 boolean DEFAULT false,
  copytl boolean DEFAULT true,
  copybd boolean DEFAULT false,
  masked boolean DEFAULT false,
  restricted boolean DEFAULT false,
  showclassification boolean DEFAULT false,
  PRIMARY KEY (classificationid),
  KEY dc_globaldomainid_idx (globaldomainid),
  CONSTRAINT dc_globaldomainid_fk FOREIGN KEY (globaldomainid) REFERENCES globaldomain (globaldomainid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE searchcriteria (
  searchid int(11) NOT NULL AUTO_INCREMENT,
  objectype varchar(50) NOT NULL,
  searchtype varchar(50) NOT NULL,
  criteria text,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  PRIMARY KEY (searchid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `folderpath` (
  `pathid` int(11) NOT NULL AUTO_INCREMENT,
  `path` text NOT NULL,
  `connectioninfoid` int(11) NOT NULL,
  `parentid` int(11) DEFAULT NULL,
  `foldername` varchar(500),
  PRIMARY KEY (`pathid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE dqrule (
  dqruleid int(11) NOT NULL AUTO_INCREMENT,
  rulelevel varchar(20) DEFAULT NULL,
  domainid int(11) DEFAULT NULL,
  name varchar(100) DEFAULT NULL,
  ruletype varchar(100) DEFAULT NULL,
  termid int(11) DEFAULT NULL,
  lowerrange varchar(255) COMMENT 'This is for the data quality range',
  upperrange varchar(255) COMMENT 'This is for the data quality range',
  rulecondition text,
  dqvalues text,
  steward varchar(50) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  updatedby varchar(50) DEFAULT NULL,
  updatedate timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  alert tinyint(4) DEFAULT NULL,
  createticket tinyint(4) DEFAULT NULL,
  datasetId int(11) DEFAULT NULL,
  status varchar(20) DEFAULT NULL,
  purpose text,
  usescore int(11) DEFAULT NULL,
  rating float DEFAULT NULL,
  version int(11) DEFAULT 1,
  jobflowid int(11) DEFAULT NULL,
  dimension varchar(50) default NULL COMMENT 'This is for the dimensioncode',
  priority int(11) default 3,
  businessimpact int(11) default 3,
  comments text,
  isautoterm boolean default false,
  lastruntime timestamp NULL DEFAULT NULL COMMENT 'This is used to get last run time of DQRule',
  statuscd int(11) default 0 COMMENT 'This is used to get statuscode of DQRule',
  PRIMARY KEY (dqruleid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE dqruleobject (
  dqruleobjectid int(11) NOT NULL AUTO_INCREMENT,
  dqruleid int(11) DEFAULT NULL,
  assobjecttype varchar(50) DEFAULT NULL,
  assobjectid int(11) DEFAULT NULL,
  mainobjecttype varchar(50) DEFAULT NULL,
  mainobjectid int(11) DEFAULT NULL,
  lastresultvalue double DEFAULT NULL,
  lastresultvaluetext text default null,
  lastruntime timestamp NULL DEFAULT NULL,
  statuscd int(11) default 0,
  statsdatasetid int(11) DEFAULT 0,
  tvaluesdatasetid  int(11) NULL DEFAULT 0,
  failedcount  bigint(20) NULL DEFAULT NULL,
  lastresultrowcount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultrowcount',
  lastresultsuccesscount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultsuccesscount',
  lastresultfailcount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultfailcount',
  lastresultsuccesspercent double DEFAULT NULL DEFAULT NULL COMMENT 'This is for the lastresulttsuccesspercent',
  lastresultfailpercent double DEFAULT NULL DEFAULT NULL COMMENT 'This is for the lastresulttfailpercent',
  lowerrange bigint(20) DEFAULT NULL,
  upperrange bigint(20) DEFAULT NULL,		  
  dqprinciple varchar(200) DEFAULT NULL,
  runid int(11) DEFAULT NULL COMMENT 'Based on this runid, we will dispaly the status of a rule',
  ticketid int(11) DEFAULT NULL COMMENT 'This ticketid is used to show the list of lists',
  lastrunobjects text,
  failedvalues text,
  lastrunfiles text,
  totalcount  bigint(20) NULL DEFAULT NULL,
  passedcount  bigint(20) NULL DEFAULT NULL,
  uniquepercent float,
  exectime long default null COMMENT 'This is used to store execution time in millisecs of an AssociatedObject for the DQRuleObject',
  PRIMARY KEY (dqruleobjectid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE watchlist_profile_entries (
  oeschemaid int(11) DEFAULT NULL,
  oetableid int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE userwatchlist (
  userwatchlistid int(11) NOT NULL AUTO_INCREMENT,
  userid varchar(100) DEFAULT NULL,
  objecttype varchar(25) DEFAULT NULL,
  objectid int(11) DEFAULT NULL,
  dateadded timestamp NULL DEFAULT NULL,
  lastnotifieddate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (userwatchlistid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE useroption (
  userid varchar(100) DEFAULT NULL,
  notifymetachange tinyint(4) DEFAULT NULL,
  notifydatachange tinyint(4) DEFAULT NULL,
  percentdatachange int(5) DEFAULT NULL,
  activetab VARCHAR(30) default null,
  notifymetadatachanges tinyint(4) DEFAULT NULL COMMENT 'This is to notify metadata(BD, TD, Tags, and Terms) changes'
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `governdataquery` (
  `gdqid` int(11) NOT NULL AUTO_INCREMENT,
  `gdqname` varchar(255) NOT NULL,
  globaldomainid int(11) NOT NULL,
  `steward` varchar(50) DEFAULT NULL,
  `createdby` varchar(50) DEFAULT NULL,
  `createddate` timestamp NULL DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`gdqid`),
  UNIQUE KEY `gdqname` (`gdqname`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table oereportext (
	oereportextid int(11) NOT NULL AUTO_INCREMENT,
	chartid int(11), 
	connectioninfoid int(11),
	detailsql longtext NOT NULL,
	filtersql longtext NOT NULL,
	chartsql longtext NOT NULL,
	chartsqltype varchar(20),
	chartoptions text,
	`defaultstartdate` timestamp NULL DEFAULT NULL,
	`defaultenddate`  timestamp NULL DEFAULT NULL,
	charttype varchar(100) DEFAULT null,
	PRIMARY KEY (oereportextid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `extchartcode` (
	`extchartcodeid` int(11) NOT NULL AUTO_INCREMENT,
	`chartid` int(11) DEFAULT NULL,
	`extsystem` varchar(50) DEFAULT NULL,
	`extsystemmajorversion` varchar(10) DEFAULT NULL,
	`extsystemminorversion` varchar(10) DEFAULT NULL,
	`chartcode` longtext,
	`binarychartcode` mediumblob,
	`chartcodeformat` varchar(10) DEFAULT NULL,
	`crc` varchar(50) DEFAULT NULL,
	`createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`lastrundate` timestamp NULL DEFAULT NULL,
	PRIMARY KEY (`extchartcodeid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE chartcolumntag (
  CHARTCOLUMNTAGID int(11) NOT NULL AUTO_INCREMENT,
  CHARTCOLUMNID int(11) DEFAULT NULL,
  TAGID int(11) DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  PRIMARY KEY (CHARTCOLUMNTAGID)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `lineageext` (
  `lineageextid` int(11) NOT NULL AUTO_INCREMENT,
  `lineageid` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `datasetid` int(11) NOT NULL DEFAULT '0',
  `transformtype` varchar(50) DEFAULT NULL,
  `filetableid` int(11) NOT NULL DEFAULT '0',
  `impexpinfoid` int(11) NOT NULL DEFAULT '0',
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoduser` varchar(50) NOT NULL,
  `version`  int(11) NULL,
  `buildtype`  varchar(16) NULL,
  PRIMARY KEY (`lineageextid`),
  KEY `idx_lineageid` (`lineageid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `lineagecolumnext` (
  `lineagecolumnextid` int(11) NOT NULL AUTO_INCREMENT,
  `lineagecolumnid` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `datasetid` int(11) NOT NULL DEFAULT '0',
  `transformtype` varchar(50) DEFAULT NULL,
  `transformcode` text,
  `filetableid` int(11) NOT NULL DEFAULT '0',
  `impexpinfoid` int(11) NOT NULL DEFAULT '0',
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoduser` varchar(50) NOT NULL,
  `version`  int(11) NULL,
  `buildtype`  varchar(16) NULL,
  PRIMARY KEY (`lineagecolumnextid`),
  KEY `idx_lineagecolumnid` (`lineagecolumnid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE a_dqruleobject (
  dqruleobjectid int(11) NOT NULL,
  dqruleid int(11) DEFAULT NULL,
  assobjecttype varchar(50) DEFAULT NULL,
  assobjectid int(11) DEFAULT NULL,
  mainobjecttype varchar(50) DEFAULT NULL,
  mainobjectid int(11) DEFAULT NULL,
  lastresultvalue double DEFAULT NULL,
  lastresultvaluetext text default null,				  					   
  lastruntime timestamp NULL DEFAULT NULL,
  statuscd int(11) default 0,
  statsdatasetid int(11) DEFAULT 0,
  tvaluesdatasetid int(11) NULL DEFAULT 0,
  failedcount bigint(20) NULL DEFAULT NULL,  
  lastresultrowcount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultrowcount',
  lastresultsuccesscount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultsuccesscount',
  lastresultfailcount bigint(20) DEFAULT NULL COMMENT 'This is for the lastresultfailcount',
  lastresultsuccesspercent double DEFAULT NULL DEFAULT NULL COMMENT 'This is for the lastresulttsuccesspercent',
  lastresultfailpercent double DEFAULT NULL DEFAULT NULL COMMENT 'This is for the lastresulttfailpercent',
  lowerrange bigint(20) DEFAULT NULL,
  upperrange bigint(20) DEFAULT NULL,
  dqprinciple varchar(200) DEFAULT NULL,
  runid int(11) DEFAULT NULL COMMENT 'Based on this runid, we will dispaly the status of a rule',
  ticketid int(11) DEFAULT NULL COMMENT 'This ticketid is used to show the list of lists',
  lastrunobjects text,
  failedvalues text,
  lastrunfiles text,
  totalcount bigint(20) DEFAULT NULL,
  passedcount bigint(20) DEFAULT NULL,					   							
  uniquepercent float,
  exectime long default null COMMENT 'This is used to store execution time in millisecs of an AssociatedObject for the DQRuleObject'
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE gdqcompliant (
  gdqcompliantid int(11) NOT NULL AUTO_INCREMENT,
  gdqid int(11) DEFAULT NULL,
  ref1 varchar(255) DEFAULT NULL,
  ref2 varchar(255) DEFAULT NULL,
  ref3 varchar(255) DEFAULT NULL,
  ref4 varchar(255) DEFAULT NULL,
  ref5 varchar(255) DEFAULT NULL,
  ref6 varchar(255) DEFAULT NULL,
  ref7 varchar(255) DEFAULT NULL,
  ref8 varchar(255) DEFAULT NULL,
  ref9 varchar(255) DEFAULT NULL,
  ref10 varchar(255) DEFAULT NULL,
  ref11 varchar(255) DEFAULT NULL,
  ref12 varchar(255) DEFAULT NULL,
  ref13 varchar(255) DEFAULT NULL,
  ref14 varchar(255) DEFAULT NULL,
  ref15 varchar(255) DEFAULT NULL,
  ref16 varchar(255) DEFAULT NULL,
  ref17 varchar(255) DEFAULT NULL,
  ref18 varchar(255) DEFAULT NULL,
  ref19 varchar(255) DEFAULT NULL,
  ref20 varchar(255) DEFAULT NULL,
  ref21 varchar(255) DEFAULT NULL,
  ref22 varchar(255) DEFAULT NULL,
  ref23 varchar(255) DEFAULT NULL,
  ref24 varchar(255) DEFAULT NULL,
  ref25 varchar(255) DEFAULT NULL,
  ref26 varchar(255) DEFAULT NULL,
  ref27 varchar(255) DEFAULT NULL,
  ref28 varchar(255) DEFAULT NULL,
  ref29 varchar(255) DEFAULT NULL,
  ref30 varchar(255) DEFAULT NULL,
  ref31 varchar(255) DEFAULT NULL,
  ref32 varchar(255) DEFAULT NULL,
  ref33 varchar(255) DEFAULT NULL,
  ref34 varchar(255) DEFAULT NULL,
  ref35 varchar(255) DEFAULT NULL,
  ref36 varchar(255) DEFAULT NULL,
  ref37 varchar(255) DEFAULT NULL,
  ref38 varchar(255) DEFAULT NULL,
  ref39 varchar(255) DEFAULT NULL,
  ref40 varchar(255) DEFAULT NULL,
  ref41 varchar(255) DEFAULT NULL,
  ref42 varchar(255) DEFAULT NULL,
  ref43 varchar(255) DEFAULT NULL,
  ref44 varchar(255) DEFAULT NULL,
  ref45 varchar(255) DEFAULT NULL,
  ref46 varchar(255) DEFAULT NULL,
  ref47 varchar(255) DEFAULT NULL,
  ref48 varchar(255) DEFAULT NULL,
  ref49 varchar(255) DEFAULT NULL,
  ref50 varchar(255) DEFAULT NULL,
  PRIMARY KEY (gdqcompliantid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE gdqconfig (
  gdqconfigid int(11) NOT NULL AUTO_INCREMENT,
  gdqid int(11) DEFAULT NULL,
  termid1 int(11) DEFAULT NULL,
  termid2 int(11) DEFAULT NULL,
  termid3 int(11) DEFAULT NULL,
  termid4 int(11) DEFAULT NULL,
  operator varchar(255) DEFAULT NULL,
  PRIMARY KEY (gdqconfigid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE gdqresult (
  gdqresultid int(11) NOT NULL AUTO_INCREMENT,
  gdqcompliantid int(11) NOT NULL,
  gdqconfigid int(11) NOT NULL,
  entriesfound int(11) NOT NULL,
  result LONGTEXT NOT NULL,
  executedate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  oetableid int(11) DEFAULT '0',
  oecolumnid1 int(11) DEFAULT '0',
  oecolumnid2 int(11) DEFAULT '0',
  oecolumnid3 int(11) DEFAULT '0',
  oecolumnid4 int(11) DEFAULT '0',
  runlevel int(11) DEFAULT '0',
  PRIMARY KEY (gdqresultid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE gdqresultbatch (
  gdqresultbatchid int(11) NOT NULL AUTO_INCREMENT,
  gdqcompliantid int(11) NOT NULL,
  entriesfound int(11) DEFAULT 0,
  rundate timestamp NOT NULL,
  runlevel int(11) not null,
  PRIMARY KEY (gdqresultbatchid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table stg_oereportext (
	id int(11) NOT NULL AUTO_INCREMENT,
	chartname varchar(255) NOT NULL,
	connectionid INT(11) DefAULT NULL,
	reportgroup VARCHAR(255) DefAULT NULL,
	businessdescription LONGTEXT,
	detailsql longtext NOT NULL,
	filtersql longtext NOT NULL,
	chartsql longtext NOT NULL,
	processed_flag boolean default false,
  	error_msg varchar(500) DEFAULT NULL,
  	reporttype VARCHAR(100),
	PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table usersession (
	usersessionid int(11) NOT NULL AUTO_INCREMENT,
	userid varchar(50) NOT NULL,
	httpsessionid varchar(200) NOT NULL,
	referrer varchar(200) DEFAULT NULL,
	ipaddress varchar(50) NOT NULL,
	browser varchar(50) NOT NULL,
	browserlanguage varchar(50) NOT NULL,
  	starttime timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  	endtime timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  	duration bigint DEFAULT 0,
  	sessiontimeout boolean DEFAULT false,
  	authenticated boolean DEFAULT false,
  	springauthsessionid varchar(200) DEFAULT NULL,
	PRIMARY KEY (usersessionid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `a_lineagecolumnext` (
  `lineagecolumnextid` int(11) NOT NULL DEFAULT '0',
  `lineagecolumnid` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `datasetid` int(11) NOT NULL DEFAULT '0',
  `transformtype` varchar(50) DEFAULT NULL,
  `transformcode` text,
  `filetableid` int(11) NOT NULL DEFAULT '0',
  `impexpinfoid` int(11) NOT NULL DEFAULT '0',
  `createdate` timestamp NULL DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `lastmoduser` varchar(50) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `buildtype` varchar(16) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `a_lineageext` (
  `lineageextid` int(11) NOT NULL DEFAULT '0',
  `lineageid` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `datasetid` int(11) NOT NULL DEFAULT '0',
  `transformtype` varchar(50) DEFAULT NULL,
  `filetableid` int(11) NOT NULL DEFAULT '0',
  `impexpinfoid` int(11) NOT NULL DEFAULT '0',
  `createdate` timestamp NULL DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `lastmoduser` varchar(50) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `buildtype` varchar(16) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `impactanalysis` (
  `impactanalysisid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `createdby` varchar(50) DEFAULT NULL,
  `updatedby` varchar(50) DEFAULT NULL,
  `lastmoddate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `impactednumber` int(11) DEFAULT NULL,
  `description` text,
  `businessglossaryid` int(11) DEFAULT NULL,
  PRIMARY KEY (`impactanalysisid`),
  UNIQUE KEY `uq_analysisname` (`name`,`createdby`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `affectedobjects` (
  `affectedobjectid` int(11) NOT NULL AUTO_INCREMENT,
  `impactanalysisid` int(11) DEFAULT NULL,
  `impacttype` varchar(50) NOT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `jobstatus` varchar(50) DEFAULT NULL,
  `isselected` tinyint(2) DEFAULT NULL,
  `lastupdatedate` timestamp NULL DEFAULT NULL,
  `jobrundate` timestamp NULL DEFAULT NULL,
  isreference tinyint(4) DEFAULT NULL,
  impactlevel int(11),
  PRIMARY KEY (`affectedobjectid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;


CREATE TABLE `impactedobjects` (
  `impactedobjectid` int(11) NOT NULL AUTO_INCREMENT,
  `impactanalysisid` int(11) NOT NULL,
  `affectedobjectid` int(11) DEFAULT NULL,
  `connectionname` varchar(100) DEFAULT NULL,
  `objectname` varchar(256) DEFAULT NULL,
  `fieldname` varchar(256) DEFAULT NULL,
  `datasetid` int(11) DEFAULT NULL,
  `datasetname` varchar(256) DEFAULT NULL,
  `code` longtext,
  `transformtype` varchar(50) DEFAULT NULL,
  `reviewedstatus` varchar(50) DEFAULT NULL,
  `reviewedby` varchar(10000) DEFAULT NULL,
  `revieweddate` timestamp NULL DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `fieldid` int(11) DEFAULT NULL,
  `inproject` tinyint(2) DEFAULT NULL,
  `sourcesystem` mediumtext DEFAULT NULL,
  `sourcefieldname` varchar(256) DEFAULT NULL,
  `sourcefieldid` int(11) DEFAULT NULL,
  `sourceobjectid` int(11) DEFAULT NULL,
  `sourceobjectname` varchar(256) DEFAULT NULL,
   sourceobjecttype varchar(50) DEFAULT NULL,
  `impacttype` varchar(50) DEFAULT NULL,
  `trcode` text,
  `sourcesystemid` int(11) DEFAULT NULL,
  `sourceconnectionname` varchar(255) DEFAULT NULL,
  `system` mediumtext DEFAULT NULL,
  `systemid` int(11) DEFAULT NULL,
  `objectactive` tinyint(4) DEFAULT '1',
  `fieldactive` tinyint(4) DEFAULT '1',
  `datasetconnectionname` varchar(100) DEFAULT NULL,
  `datasetjobtype` varchar(255) DEFAULT NULL,
  impactlevel int,
  `datasetsystemname` mediumtext DEFAULT NULL,
  PRIMARY KEY (`impactedobjectid`),
  KEY `impobj_index` (`impactanalysisid`,`affectedobjectid`,`objectid`,`objecttype`,`impacttype`,`datasetid`),
  KEY `impobj_index1` (`impactanalysisid`,`affectedobjectid`,`objectid`,`objecttype`,`impacttype`,`fieldid`,`datasetid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table `packagedata` ( 
	`datasetid` int, 
	`pkdata` longtext,
	foldername varchar(50) DEFAULT NULL,
	projectname varchar(50) DEFAULT NULL,
	pkgname varchar(50) DEFAULT NULL
) ENGINE=InnoDB;
	
CREATE TABLE category (
  	categoryid INT(11) NOT NULL AUTO_INCREMENT,
  	name varchar(100) NOT NULL,
  	description varchar(250) default NULL,
  	parentid int(11) default 0,
	objecttype varchar(50) default NULL,
	contextid INT(11) NOT NULL,
  	disabled boolean default false,
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updatedby varchar(50) DEFAULT NULL,
	reviewer varchar(50) default null,
    steward varchar(50) default null,
  	PRIMARY KEY (categoryid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `SPRING_SESSION` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

CREATE TABLE `SPRING_SESSION_ATTRIBUTES` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` mediumblob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `SPRING_SESSION_ATTRIBUTES_FK` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `SPRING_SESSION` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

CREATE TABLE `down_consumers` (
  `downconsumerid` int(11) NOT NULL AUTO_INCREMENT,
  `topusercount` tinyint(4) DEFAULT NULL,
  `istopusers` tinyint(4) DEFAULT NULL,
  `issteward` tinyint(4) DEFAULT NULL,
  `isowner` tinyint(4) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `message` text,
  `createdby` varchar(255) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`downconsumerid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE crawleroptions (
    crawleroptionsid int(11) NOT NULL AUTO_INCREMENT,
    connectioninfoid int(11) NOT NULL,
	tableviewncols BOOLEAN,
	relationship BOOLEAN,
	usersnroles BOOLEAN,
	procnfunc BOOLEAN,
	reports BOOLEAN,
	reportcolumns BOOLEAN,
	include_tables_regex varchar(255),
	exclude_tables_regex varchar(255),
	include_columns_regex varchar(255),
	exclude_columns_regex varchar(255),
	include_procedure_and_function_regex varchar(255),
	exclude_procedure_and_function_regex varchar(255),
	include_reports_regex VARCHAR(255) DEFAULT NULL,
    exclude_reports_regex VARCHAR(255) DEFAULT NULL,
    querypermissionmode BOOLEAN default false,
    additionalcrawl tinyint default 0,
    profiletablesandcols tinyint(1) default 0,
	profileviewsandcols tinyint(1) default 0,
	include_profile_tables_views_regex varchar(255) default null,
	exclude_profile_tables_views_regex varchar(255) default null,
	include_profile_columns_regex varchar(255) default null,
	exclude_profile_columns_regex varchar(255) default null,
	includefilefolderregex varchar(255) DEFAULT NULL COMMENT 'This is for the include filefolderregex value',
	excludefilefolderregex varchar(255) DEFAULT NULL COMMENT 'This is for the exclude filefolderregex value',
	filefolders tinyint(1) DEFAULT '1' COMMENT 'this is for the filefolders checkbox value',
	deltacrawl tinyint(1) DEFAULT NULL COMMENT 'This is for the delta crawl',
    PRIMARY KEY (`crawleroptionsid`),
    UNIQUE KEY `connectioninfoid` (`connectioninfoid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oeschema` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`connectionname` longtext,
 	`schemaname` varchar(255) DEFAULT NULL,
	title varchar(256),
	`businessdescription` mediumtext default null,
	techdescription mediumtext,
	`tagname` varchar(255) DEFAULT NULL,
	term VARCHAR(255) DEFAULT NULL,
	`domain` varchar(100) DEFAULT NULL,
	`createdate` timestamp NULL DEFAULT NULL,
	`processed_flag` tinyint(4) DEFAULT '0',
	`error_msg` varchar(500) DEFAULT NULL,
	batchno VARCHAR(50) DEFAULT NULL,
	`ccf1` text DEFAULT NULL,
  	`ccf2` text DEFAULT NULL,
  	`ccf3` text DEFAULT NULL,
  	`ccf4` text DEFAULT NULL,
  	`ccf5` text DEFAULT NULL,
  	`ccf6` text DEFAULT NULL,
	`ccf7` text DEFAULT NULL,
	`ccf8` text DEFAULT NULL,
  	`ccf9` text DEFAULT NULL,
	`ccf10` text DEFAULT NULL,
	`ccf11` text DEFAULT NULL,
	`ccf12` text DEFAULT NULL,
  	`ccf13` text DEFAULT NULL,
  	`ccf14` text DEFAULT NULL,
  	`ccf15` text DEFAULT NULL,
  	`tcf1` text DEFAULT NULL,
  	`tcf2` text DEFAULT NULL,
  	`tcf3` text DEFAULT NULL,
  	`tcf4` text DEFAULT NULL,
  	`tcf5` text DEFAULT NULL,
  	`tcf6` text DEFAULT NULL,
  	`tcf7` text DEFAULT NULL,
  	`tcf8` text DEFAULT NULL,
  	`tcf9` text DEFAULT NULL,
  	`tcf10` text DEFAULT NULL,
  	`tcf11` text DEFAULT NULL,
  	`tcf12` text DEFAULT NULL,
  	`tcf13` text DEFAULT NULL,
  	`tcf14` text DEFAULT NULL,
  	`tcf15` text DEFAULT NULL,
  	`tcf16` text DEFAULT NULL,
  	`tcf17` text DEFAULT NULL,
  	`tcf18` text DEFAULT NULL,
  	`tcf19` text DEFAULT NULL,
  	`tcf20` text DEFAULT NULL,
  	`tcf21` text DEFAULT NULL,
  	`tcf22` text DEFAULT NULL,
  	`tcf23` text DEFAULT NULL,
  	`tcf24` text DEFAULT NULL,
  	`tcf25` text DEFAULT NULL,
  	`tcf26` text DEFAULT NULL,
  	`tcf27` text DEFAULT NULL,
  	`tcf28` text DEFAULT NULL,
  	`tcf29` text DEFAULT NULL,
  	`tcf30` text DEFAULT NULL,
  	`tcf31` text DEFAULT NULL,
  	`tcf32` text DEFAULT NULL,
  	`tcf33` text DEFAULT NULL,
  	`tcf34` text DEFAULT NULL,
  	`tcf35` text DEFAULT NULL,
  	`tcf36` text DEFAULT NULL,
  	`tcf37` text DEFAULT NULL,
  	`tcf38` text DEFAULT NULL,
  	`tcf39` text DEFAULT NULL,
  	`tcf40` text DEFAULT NULL,
  	`tcf41` text DEFAULT NULL,
  	`tcf42` text DEFAULT NULL,
  	`tcf43` text DEFAULT NULL,
  	`tcf44` text DEFAULT NULL,
  	`tcf45` text DEFAULT NULL,
  	`tcf46` text DEFAULT NULL,
  	`tcf47` text DEFAULT NULL,
  	`tcf48` text DEFAULT NULL,
  	`tcf49` text DEFAULT NULL,
  	`tcf50` text DEFAULT NULL,
  	`ncf1` double DEFAULT NULL,
  	`ncf2` double DEFAULT NULL,
  	`ncf3` double DEFAULT NULL,
  	`ncf4` double DEFAULT NULL,
  	`ncf5` double DEFAULT NULL,
  	`ncf6` double DEFAULT NULL,
  	`ncf7` double DEFAULT NULL,
  	`ncf8` double DEFAULT NULL,
  	`ncf9` double DEFAULT NULL,
  	`ncf10` double DEFAULT NULL,
  	`ncf11` double DEFAULT NULL,
  	`ncf12` double DEFAULT NULL,
  	`ncf13` double DEFAULT NULL,
  	`ncf14` double DEFAULT NULL,
  	`ncf15` double DEFAULT NULL,
  	`dcf1` varchar(160) DEFAULT NULL,
  	`dcf2` varchar(160) DEFAULT NULL,
  	`dcf3` varchar(160) DEFAULT NULL,
  	`dcf4` varchar(160) DEFAULT NULL,
  	`dcf5` varchar(160) DEFAULT NULL,
  	`dcf6` varchar(160) DEFAULT NULL,
  	`dcf7` varchar(160) DEFAULT NULL,
  	`dcf8` varchar(160) DEFAULT NULL,
  	`dcf9` varchar(160) DEFAULT NULL,
  	`dcf10` varchar(160) DEFAULT NULL,
  	`dcf11` varchar(160) DEFAULT NULL,
  	`dcf12` varchar(160) DEFAULT NULL,
  	`dcf13` varchar(160) DEFAULT NULL,
  	`dcf14` varchar(160) DEFAULT NULL,
  	`dcf15` varchar(160) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oetable` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`connectionname` longtext,
	`schemaname` varchar(255) DEFAULT NULL,
	`tablename` varchar(256) DEFAULT NULL,
  	title varchar(256),
	`businessdescription` mediumtext default null,
	`techinaldescription` longtext,
	tagname varchar(255) DEFAULT NULL,
	term varchar(255) DEFAULT NULL,
	`domain` varchar(100) DEFAULT NULL,
	`ccf1` text,
  	`ccf2` text,
  	`ccf3` text,
  	`ccf4` text,
  	`ccf5` text,
  	`ccf6` text,
 	`ccf7` text,
 	`ccf8` text,
  	`ccf9` text,
	`ccf10` text,
	`ccf11` text,
 	`ccf12` text,
  	`ccf13` text,
  	`ccf14` text,
  	`ccf15` text,
  	`tcf1` text,
  	`tcf2` text,
  	`tcf3` text,
  	`tcf4` text,
  	`tcf5` text,
  	`tcf6` text,
  	`tcf7` text,
  	`tcf8` text,
  	`tcf9` text,
  	`tcf10` text,
  	`tcf11` text,
  	`tcf12` text,
  	`tcf13` text,
  	`tcf14` text,
  	`tcf15` text,
  	`tcf16` text,
  	`tcf17` text,
  	`tcf18` text,
  	`tcf19` text,
  	`tcf20` text,
  	`tcf21` text,
  	`tcf22` text,
  	`tcf23` text,
  	`tcf24` text,
  	`tcf25` text,
  	`tcf26` text,
  	`tcf27` text,
  	`tcf28` text,
  	`tcf29` text,
  	`tcf30` text,
  	`tcf31` text,
  	`tcf32` text,
  	`tcf33` text,
  	`tcf34` text,
  	`tcf35` text,
  	`tcf36` text,
  	`tcf37` text,
  	`tcf38` text,
  	`tcf39` text,
  	`tcf40` text,
  	`tcf41` text,
  	`tcf42` text,
  	`tcf43` text,
  	`tcf44` text,
  	`tcf45` text,
  	`tcf46` text,
  	`tcf47` text,
  	`tcf48` text,
  	`tcf49` text,
  	`tcf50` text,
  	`ncf1` double DEFAULT NULL,
  	`ncf2` double DEFAULT NULL,
  	`ncf3` double DEFAULT NULL,
  	`ncf4` double DEFAULT NULL,
  	`ncf5` double DEFAULT NULL,
  	`ncf6` double DEFAULT NULL,
  	`ncf7` double DEFAULT NULL,
  	`ncf8` double DEFAULT NULL,
  	`ncf9` double DEFAULT NULL,
  	`ncf10` double DEFAULT NULL,
  	`ncf11` double DEFAULT NULL,
  	`ncf12` double DEFAULT NULL,
  	`ncf13` double DEFAULT NULL,
  	`ncf14` double DEFAULT NULL,
  	`ncf15` double DEFAULT NULL,
  	`dcf1` varchar(160) DEFAULT NULL,
  	`dcf2` varchar(160) DEFAULT NULL,
  	`dcf3` varchar(160) DEFAULT NULL,
  	`dcf4` varchar(160) DEFAULT NULL,
  	`dcf5` varchar(160) DEFAULT NULL,
  	`dcf6` varchar(160) DEFAULT NULL,
  	`dcf7` varchar(160) DEFAULT NULL,
  	`dcf8` varchar(160) DEFAULT NULL,
  	`dcf9` varchar(160) DEFAULT NULL,
  	`dcf10` varchar(160) DEFAULT NULL,
 	`dcf11` varchar(160) DEFAULT NULL,
  	`dcf12` varchar(160) DEFAULT NULL,
  	`dcf13` varchar(160) DEFAULT NULL,
  	`dcf14` varchar(160) DEFAULT NULL,
  	`dcf15` varchar(160) DEFAULT NULL,
  	`createdate` timestamp NULL DEFAULT NULL,
  	`processed_flag` tinyint(4) DEFAULT '0',
  	`error_msg` varchar(500) DEFAULT NULL,
  	batchno VARCHAR(50) DEFAULT NULL,
   	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oecolumn` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`connectionname` longtext,
	`schemaname` varchar(255) DEFAULT NULL,
	`tablename` varchar(256) DEFAULT NULL,
	`columnname` varchar(256) DEFAULT NULL,
	columntype varchar(100),
	title varchar(256),
	`techdescription` mediumtext,
	`businessdescription` mediumtext default null,
	tagname varchar(255) DEFAULT NULL,
	term varchar(255) DEFAULT NULL,
	`domain` varchar(100) DEFAULT NULL,
	`mask` tinyint(1) DEFAULT '0',
	restricted tinyint(1),
	`columnlength` double DEFAULT NULL,
	`ccf1` text,
	`ccf2` text,
	`ccf3` text,
	`ccf4` text,
	`ccf5` text,
	`ccf6` text,
	`ccf7` text,
	`ccf8` text,
	`ccf9` text,
	`ccf10` text,
	`ccf11` text,
	`ccf12` text,
	`ccf13` text,
	`ccf14` text,
	`ccf15` text,
	`tcf1` text,
	`tcf2` text,
	`tcf3` text,
	`tcf4` text,
	`tcf5` text,
	`tcf6` text,
	`tcf7` text,
	`tcf8` text,
	`tcf9` text,
	`tcf10` text,
	`tcf11` text,
	`tcf12` text,
	`tcf13` text,
	`tcf14` text,
	`tcf15` text,
	`tcf16` text,
	`tcf17` text,
	`tcf18` text,
	`tcf19` text,
	`tcf20` text,
	`tcf21` text,
	`tcf22` text,
	`tcf23` text,
	`tcf24` text,
	`tcf25` text,
	`tcf26` text,
	`tcf27` text,
	`tcf28` text,
	`tcf29` text,
	`tcf30` text,
	`tcf31` text,
	`tcf32` text,
	`tcf33` text,
	`tcf34` text,
	`tcf35` text,
	`tcf36` text,
	`tcf37` text,
	`tcf38` text,
	`tcf39` text,
	`tcf40` text,
	`tcf41` text,
	`tcf42` text,
	`tcf43` text,
	`tcf44` text,
	`tcf45` text,
	`tcf46` text,
	`tcf47` text,
	`tcf48` text,
	`tcf49` text,
	`tcf50` text,
	`ncf1` double DEFAULT NULL,
	`ncf2` double DEFAULT NULL,
	`ncf3` double DEFAULT NULL,
	`ncf4` double DEFAULT NULL,
	`ncf5` double DEFAULT NULL,
	`ncf6` double DEFAULT NULL,
	`ncf7` double DEFAULT NULL,
	`ncf8` double DEFAULT NULL,
	`ncf9` double DEFAULT NULL,
	`ncf10` double DEFAULT NULL,
	`ncf11` double DEFAULT NULL,
	`ncf12` double DEFAULT NULL,
	`ncf13` double DEFAULT NULL,
	`ncf14` double DEFAULT NULL,
	`ncf15` double DEFAULT NULL,
	`dcf1` varchar(160) DEFAULT NULL,
  	`dcf2` varchar(160) DEFAULT NULL,
  	`dcf3` varchar(160) DEFAULT NULL,
  	`dcf4` varchar(160) DEFAULT NULL,
  	`dcf5` varchar(160) DEFAULT NULL,
  	`dcf6` varchar(160) DEFAULT NULL,
  	`dcf7` varchar(160) DEFAULT NULL,
  	`dcf8` varchar(160) DEFAULT NULL,
  	`dcf9` varchar(160) DEFAULT NULL,
  	`dcf10` varchar(160) DEFAULT NULL,
  	`dcf11` varchar(160) DEFAULT NULL,
  	`dcf12` varchar(160) DEFAULT NULL,
  	`dcf13` varchar(160) DEFAULT NULL,
  	`dcf14` varchar(160) DEFAULT NULL,
  	`dcf15` varchar(160) DEFAULT NULL,
	`createdate` timestamp NULL DEFAULT NULL,
	`processed_flag` tinyint(4) DEFAULT '0',
	`error_msg` varchar(500) DEFAULT NULL,
	batchno VARCHAR(50) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oefile` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`connectionname` longtext,
	`filefolder` varchar(200) DEFAULT NULL,
	`filename` varchar(511) DEFAULT NULL,
	`location` varchar(511) DEFAULT NULL,
	`filetype` varchar(10) DEFAULT NULL,
	tagname varchar(255) DEFAULT NULL,
	term varchar(255) DEFAULT NULL,
	`domain` varchar(100) DEFAULT NULL,
	remotetags MEDIUMTEXT DEFAULT NULL,
	title varchar(256),
	`businessdescription` mediumtext default null,
	`ccf1` text,
	`ccf2` text,
	`ccf3` text,
	`ccf4` text,
	`ccf5` text,
	`ccf6` text,
	`ccf7` text,
	`ccf8` text,
	`ccf9` text,
	`ccf10` text,
	`ccf11` text,
	`ccf12` text,
	`ccf13` text,
	`ccf14` text,
	`ccf15` text,
	`tcf1` text,
	`tcf2` text,
	`tcf3` text,
	`tcf4` text,
	`tcf5` text,
	`tcf6` text,
	`tcf7` text,
	`tcf8` text,
	`tcf9` text,
	`tcf10` text,
	`tcf11` text,
	`tcf12` text,
	`tcf13` text,
	`tcf14` text,
	`tcf15` text,
	`tcf16` text,
	`tcf17` text,
	`tcf18` text,
	`tcf19` text,
	`tcf20` text,
	`tcf21` text,
	`tcf22` text,
	`tcf23` text,
	`tcf24` text,
	`tcf25` text,
	`tcf26` text,
	`tcf27` text,
	`tcf28` text,
	`tcf29` text,
	`tcf30` text,
	`tcf31` text,
	`tcf32` text,
	`tcf33` text,
	`tcf34` text,
	`tcf35` text,
	`tcf36` text,
	`tcf37` text,
	`tcf38` text,
	`tcf39` text,
	`tcf40` text,
	`tcf41` text,
	`tcf42` text,
	`tcf43` text,
	`tcf44` text,
	`tcf45` text,
	`tcf46` text,
	`tcf47` text,
	`tcf48` text,
	`tcf49` text,
	`tcf50` text,
	`ncf1` double DEFAULT NULL,
	`ncf2` double DEFAULT NULL,
	`ncf3` double DEFAULT NULL,
	`ncf4` double DEFAULT NULL,
	`ncf5` double DEFAULT NULL,
	`ncf6` double DEFAULT NULL,
	`ncf7` double DEFAULT NULL,
	`ncf8` double DEFAULT NULL,
	`ncf9` double DEFAULT NULL,
	`ncf10` double DEFAULT NULL,
	`ncf11` double DEFAULT NULL,
	`ncf12` double DEFAULT NULL,
	`ncf13` double DEFAULT NULL,
	`ncf14` double DEFAULT NULL,
	`ncf15` double DEFAULT NULL,
	 `dcf1` varchar(160) DEFAULT NULL,
  	`dcf2` varchar(160) DEFAULT NULL,
  	`dcf3` varchar(160) DEFAULT NULL,
  	`dcf4` varchar(160) DEFAULT NULL,
  	`dcf5` varchar(160) DEFAULT NULL,
  	`dcf6` varchar(160) DEFAULT NULL,
  	`dcf7` varchar(160) DEFAULT NULL,
  	`dcf8` varchar(160) DEFAULT NULL,
  	`dcf9` varchar(160) DEFAULT NULL,
  	`dcf10` varchar(160) DEFAULT NULL,
 	`dcf11` varchar(160) DEFAULT NULL,
 	`dcf12` varchar(160) DEFAULT NULL,
  	`dcf13` varchar(160) DEFAULT NULL,
  	`dcf14` varchar(160) DEFAULT NULL,
  	`dcf15` varchar(160) DEFAULT NULL,
	`createdate` timestamp NULL DEFAULT NULL,
	`processed_flag` tinyint(4) DEFAULT '0',
	`error_msg` varchar(500) DEFAULT NULL,
	batchno VARCHAR(50) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oefilecolumn` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`connectionname` longtext,
	`filefolder` varchar(200) DEFAULT NULL,
	`filename` varchar(511) DEFAULT NULL,
	`location` varchar(511) DEFAULT NULL,
	`filetype` varchar(10) DEFAULT NULL,
	`columnname` varchar(256) DEFAULT NULL,
	`columntype` varchar(50) DEFAULT NULL,
	title varchar(256),
	`businessdescription` mediumtext default null,
	tagname varchar(255) DEFAULT NULL,
	term varchar(255) DEFAULT NULL,
	`domain` varchar(100) DEFAULT NULL,
	`mask` tinyint(1) DEFAULT '0',
	restricted tinyint(1),
	`ccf1` text,
	`ccf2` text,
	`ccf3` text,
	`ccf4` text,
	`ccf5` text,
	`ccf6` text,
	`ccf7` text,
	`ccf8` text,
	`ccf9` text,
	`ccf10` text,
	`ccf11` text,
	`ccf12` text,
	`ccf13` text,
	`ccf14` text,
	`ccf15` text,
	`tcf1` text,
	`tcf2` text,
	`tcf3` text,
	`tcf4` text,
	`tcf5` text,
	`tcf6` text,
	`tcf7` text,
	`tcf8` text,
	`tcf9` text,
	`tcf10` text,
	`tcf11` text,
	`tcf12` text,
	`tcf13` text,
	`tcf14` text,
	`tcf15` text,
	`tcf16` text,
	`tcf17` text,
	`tcf18` text,
	`tcf19` text,
	`tcf20` text,
	`tcf21` text,
	`tcf22` text,
	`tcf23` text,
	`tcf24` text,
	`tcf25` text,
	`tcf26` text,
	`tcf27` text,
	`tcf28` text,
	`tcf29` text,
	`tcf30` text,
	`tcf31` text,
	`tcf32` text,
	`tcf33` text,
	`tcf34` text,
	`tcf35` text,
	`tcf36` text,
	`tcf37` text,
	`tcf38` text,
	`tcf39` text,
	`tcf40` text,
	`tcf41` text,
	`tcf42` text,
	`tcf43` text,
	`tcf44` text,
	`tcf45` text,
	`tcf46` text,
	`tcf47` text,
	`tcf48` text,
	`tcf49` text,
	`tcf50` text,
	`ncf1` double DEFAULT NULL,
	`ncf2` double DEFAULT NULL,
	`ncf3` double DEFAULT NULL,
	`ncf4` double DEFAULT NULL,
	`ncf5` double DEFAULT NULL,
	`ncf6` double DEFAULT NULL,
	`ncf7` double DEFAULT NULL,
	`ncf8` double DEFAULT NULL,
	`ncf9` double DEFAULT NULL,
	`ncf10` double DEFAULT NULL,
	`ncf11` double DEFAULT NULL,
	`ncf12` double DEFAULT NULL,
	`ncf13` double DEFAULT NULL,
	`ncf14` double DEFAULT NULL,
	`ncf15` double DEFAULT NULL,
	`dcf1` varchar(160) DEFAULT NULL,
  	`dcf2` varchar(160) DEFAULT NULL,
  	`dcf3` varchar(160) DEFAULT NULL,
  	`dcf4` varchar(160) DEFAULT NULL,
  	`dcf5` varchar(160) DEFAULT NULL,
  	`dcf6` varchar(160) DEFAULT NULL,
  	`dcf7` varchar(160) DEFAULT NULL,
  	`dcf8` varchar(160) DEFAULT NULL,
  	`dcf9` varchar(160) DEFAULT NULL,
  	`dcf10` varchar(160) DEFAULT NULL,
  	`dcf11` varchar(160) DEFAULT NULL,
  	`dcf12` varchar(160) DEFAULT NULL,
  	`dcf13` varchar(160) DEFAULT NULL,
  	`dcf14` varchar(160) DEFAULT NULL,
  	`dcf15` varchar(160) DEFAULT NULL,
	`createdate` timestamp NULL DEFAULT NULL,
	`processed_flag` tinyint(4) DEFAULT '0',
	`error_msg` varchar(500) DEFAULT NULL,
	batchno VARCHAR(50) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oechart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionname` longtext,
  reportgroupname mediumtext,
  reportname varchar(255) DEFAULT NULL,
  reporttype varchar(100) DEFAULT NULL,
  `colnametypemap` mediumtext,
  title varchar(256),
  `businessdescription` mediumtext default null,
  technicaldescription mediumtext default null,
  tagname varchar(255) DEFAULT NULL,
  term varchar(255) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `ccf1` text,
  `ccf2` text,
  `ccf3` text,
  `ccf4` text,
  `ccf5` text,
  `ccf6` text,
  `ccf7` text,
  `ccf8` text,
  `ccf9` text,
  `ccf10` text,
  `ccf11` text,
  `ccf12` text,
  `ccf13` text,
  `ccf14` text,
  `ccf15` text,
  `tcf1` text,
  `tcf2` text,
  `tcf3` text,
  `tcf4` text,
  `tcf5` text,
  `tcf6` text,
  `tcf7` text,
  `tcf8` text,
  `tcf9` text,
  `tcf10` text,
  `tcf11` text,
  `tcf12` text,
  `tcf13` text,
  `tcf14` text,
  `tcf15` text,
  `tcf16` text,
  `tcf17` text,
  `tcf18` text,
  `tcf19` text,
  `tcf20` text,
  `tcf21` text,
  `tcf22` text,
  `tcf23` text,
  `tcf24` text,
  `tcf25` text,
  `tcf26` text,
  `tcf27` text,
  `tcf28` text,
  `tcf29` text,
  `tcf30` text,
  `tcf31` text,
  `tcf32` text,
  `tcf33` text,
  `tcf34` text,
  `tcf35` text,
  `tcf36` text,
  `tcf37` text,
  `tcf38` text,
  `tcf39` text,
  `tcf40` text,
  `tcf41` text,
  `tcf42` text,
  `tcf43` text,
  `tcf44` text,
  `tcf45` text,
  `tcf46` text,
  `tcf47` text,
  `tcf48` text,
  `tcf49` text,
  `tcf50` text,
  `ncf1` double DEFAULT NULL,
  `ncf2` double DEFAULT NULL,
  `ncf3` double DEFAULT NULL,
  `ncf4` double DEFAULT NULL,
  `ncf5` double DEFAULT NULL,
  `ncf6` double DEFAULT NULL,
  `ncf7` double DEFAULT NULL,
  `ncf8` double DEFAULT NULL,
  `ncf9` double DEFAULT NULL,
  `ncf10` double DEFAULT NULL,
  `ncf11` double DEFAULT NULL,
  `ncf12` double DEFAULT NULL,
  `ncf13` double DEFAULT NULL,
  `ncf14` double DEFAULT NULL,
  `ncf15` double DEFAULT NULL,
  `dcf1` varchar(160) DEFAULT NULL,
  `dcf2` varchar(160) DEFAULT NULL,
  `dcf3` varchar(160) DEFAULT NULL,
  `dcf4` varchar(160) DEFAULT NULL,
  `dcf5` varchar(160) DEFAULT NULL,
  `dcf6` varchar(160) DEFAULT NULL,
  `dcf7` varchar(160) DEFAULT NULL,
  `dcf8` varchar(160) DEFAULT NULL,
  `dcf9` varchar(160) DEFAULT NULL,
  `dcf10` varchar(160) DEFAULT NULL,
  `dcf11` varchar(160) DEFAULT NULL,
  `dcf12` varchar(160) DEFAULT NULL,
  `dcf13` varchar(160) DEFAULT NULL,
  `dcf14` varchar(160) DEFAULT NULL,
  `dcf15` varchar(160) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  batchno VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_oechartchild` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionname` longtext,
  reportgroupname mediumtext DEFAULT NULL,
  reportname varchar(255),
  reporttype varchar(100) DEFAULT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `columntype` varchar(50) DEFAULT NULL,
  title varchar(256),
  techdescription mediumtext DEFAULT NULL,
  `businessdescription` mediumtext default null,
  tagname varchar(255) DEFAULT NULL,
  term varchar(255) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `mask` tinyint(4) DEFAULT NULL,
  `restricted` tinyint(4) DEFAULT NULL,
  `ccf1` text,
  `ccf2` text,
  `ccf3` text,
  `ccf4` text,
  `ccf5` text,
  `ccf6` text,
  `ccf7` text,
  `ccf8` text,
  `ccf9` text,
  `ccf10` text,
  `ccf11` text,
  `ccf12` text,
  `ccf13` text,
  `ccf14` text,
  `ccf15` text,
  `tcf1` text,
  `tcf2` text,
  `tcf3` text,
  `tcf4` text,
  `tcf5` text,
  `tcf6` text,
  `tcf7` text,
  `tcf8` text,
  `tcf9` text,
  `tcf10` text,
  `tcf11` text,
  `tcf12` text,
  `tcf13` text,
  `tcf14` text,
  `tcf15` text,
  `tcf16` text,
  `tcf17` text,
  `tcf18` text,
  `tcf19` text,
  `tcf20` text,
  `tcf21` text,
  `tcf22` text,
  `tcf23` text,
  `tcf24` text,
  `tcf25` text,
  `tcf26` text,
  `tcf27` text,
  `tcf28` text,
  `tcf29` text,
  `tcf30` text,
  `tcf31` text,
  `tcf32` text,
  `tcf33` text,
  `tcf34` text,
  `tcf35` text,
  `tcf36` text,
  `tcf37` text,
  `tcf38` text,
  `tcf39` text,
  `tcf40` text,
  `tcf41` text,
  `tcf42` text,
  `tcf43` text,
  `tcf44` text,
  `tcf45` text,
  `tcf46` text,
  `tcf47` text,
  `tcf48` text,
  `tcf49` text,
  `tcf50` text,
  `ncf1` double DEFAULT NULL,
  `ncf2` double DEFAULT NULL,
  `ncf3` double DEFAULT NULL,
  `ncf4` double DEFAULT NULL,
  `ncf5` double DEFAULT NULL,
  `ncf6` double DEFAULT NULL,
  `ncf7` double DEFAULT NULL,
  `ncf8` double DEFAULT NULL,
  `ncf9` double DEFAULT NULL,
  `ncf10` double DEFAULT NULL,
  `ncf11` double DEFAULT NULL,
  `ncf12` double DEFAULT NULL,
  `ncf13` double DEFAULT NULL,
  `ncf14` double DEFAULT NULL,
  `ncf15` double DEFAULT NULL,
  `dcf1` varchar(160) DEFAULT NULL,
  `dcf2` varchar(160) DEFAULT NULL,
  `dcf3` varchar(160) DEFAULT NULL,
  `dcf4` varchar(160) DEFAULT NULL,
  `dcf5` varchar(160) DEFAULT NULL,
  `dcf6` varchar(160) DEFAULT NULL,
  `dcf7` varchar(160) DEFAULT NULL,
  `dcf8` varchar(160) DEFAULT NULL,
  `dcf9` varchar(160) DEFAULT NULL,
  `dcf10` varchar(160) DEFAULT NULL,
  `dcf11` varchar(160) DEFAULT NULL,
  `dcf12` varchar(160) DEFAULT NULL,
  `dcf13` varchar(160) DEFAULT NULL,
  `dcf14` varchar(160) DEFAULT NULL,
  `dcf15` varchar(160) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  batchno VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_glossary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(50) NOT NULL,
  term mediumtext DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `description` mediumtext,
  `definition` mediumtext,
  tagname varchar(255) DEFAULT NULL,
  copydescription tinyint(1),
  `copybizdesc` tinyint(1) DEFAULT '0',
  `mask` tinyint(1) DEFAULT '0',
  restricted tinyint(1),
  `classification1` tinyint(1) DEFAULT '0',
  `classification2` tinyint(1) DEFAULT '0',
  `classification3` tinyint(1) DEFAULT '0',
  `classification4` tinyint(1) DEFAULT '0',
  `classification5` tinyint(1) DEFAULT '0',
  `classification6` tinyint(1) DEFAULT '0',
  `classification7` tinyint(1) DEFAULT '0',
  `classification8` tinyint(1) DEFAULT '0',
  `classification9` tinyint(1) DEFAULT '0',
  `classification10` tinyint(1) DEFAULT '0',
  `category1` varchar(100) DEFAULT NULL,
  `category2` varchar(100) DEFAULT NULL,
  `ccf1` text,
  `ccf2` text,
  `ccf3` text,
  `ccf4` text,
  `ccf5` text,
  `ccf6` text,
  `ccf7` text,
  `ccf8` text,
  `ccf9` text,
  `ccf10` text,
  `ccf11` text,
  `ccf12` text,
  `ccf13` text,
  `ccf14` text,
  `ccf15` text,
  `tcf1` text,
  `tcf2` text,
  `tcf3` text,
  `tcf4` text,
  `tcf5` text,
  `tcf6` text,
  `tcf7` text,
  `tcf8` text,
  `tcf9` text,
  `tcf10` text,
  `tcf11` text,
  `tcf12` text,
  `tcf13` text,
  `tcf14` text,
  `tcf15` text,
  `tcf16` text,
  `tcf17` text,
  `tcf18` text,
  `tcf19` text,
  `tcf20` text,
  `tcf21` text,
  `tcf22` text,
  `tcf23` text,
  `tcf24` text,
  `tcf25` text,
  `tcf26` text,
  `tcf27` text,
  `tcf28` text,
  `tcf29` text,
  `tcf30` text,
  `tcf31` text,
  `tcf32` text,
  `tcf33` text,
  `tcf34` text,
  `tcf35` text,
  `tcf36` text,
  `tcf37` text,
  `tcf38` text,
  `tcf39` text,
  `tcf40` text,
  `tcf41` text,
  `tcf42` text,
  `tcf43` text,
  `tcf44` text,
  `tcf45` text,
  `tcf46` text,
  `tcf47` text,
  `tcf48` text,
  `tcf49` text,
  `tcf50` text,
  `ncf1` double DEFAULT NULL,
  `ncf2` double DEFAULT NULL,
  `ncf3` double DEFAULT NULL,
  `ncf4` double DEFAULT NULL,
  `ncf5` double DEFAULT NULL,
  `ncf6` double DEFAULT NULL,
  `ncf7` double DEFAULT NULL,
  `ncf8` double DEFAULT NULL,
  `ncf9` double DEFAULT NULL,
  `ncf10` double DEFAULT NULL,
  `ncf11` double DEFAULT NULL,
  `ncf12` double DEFAULT NULL,
  `ncf13` double DEFAULT NULL,
  `ncf14` double DEFAULT NULL,
  `ncf15` double DEFAULT NULL,
  `dcf1` varchar(160) DEFAULT NULL,
  `dcf2` varchar(160) DEFAULT NULL,
  `dcf3` varchar(160) DEFAULT NULL,
  `dcf4` varchar(160) DEFAULT NULL,
  `dcf5` varchar(160) DEFAULT NULL,
  `dcf6` varchar(160) DEFAULT NULL,
  `dcf7` varchar(160) DEFAULT NULL,
  `dcf8` varchar(160) DEFAULT NULL,
  `dcf9` varchar(160) DEFAULT NULL,
  `dcf10` varchar(160) DEFAULT NULL,
  `dcf11` varchar(160) DEFAULT NULL,
  `dcf12` varchar(160) DEFAULT NULL,
  `dcf13` varchar(160) DEFAULT NULL,
  `dcf14` varchar(160) DEFAULT NULL,
  `dcf15` varchar(160) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `processed_flag` tinyint(1) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  batchno VARCHAR(50) DEFAULT NULL,
  showclassification tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tagname` varchar(255) NOT NULL,
  tagtype varchar(50) NOT NULL,
  `businessdescription` mediumtext default null,
  `createdate` timestamp NULL DEFAULT NULL,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
   batchno VARCHAR(50) DEFAULT NULL,
  `ccf1` text,
  `ccf2` text,
  `ccf3` text,
  `ccf4` text,
  `ccf5` text,
  `ccf6` text,
  `ccf7` text,
  `ccf8` text,
  `ccf9` text,
  `ccf10` text,
  `ccf11` text,
  `ccf12` text,
  `ccf13` text,
  `ccf14` text,
  `ccf15` text,
  `tcf1` text,
  `tcf2` text,
  `tcf3` text,
  `tcf4` text,
  `tcf5` text,
  `tcf6` text,
  `tcf7` text,
  `tcf8` text,
  `tcf9` text,
  `tcf10` text,
  `tcf11` text,
  `tcf12` text,
  `tcf13` text,
  `tcf14` text,
  `tcf15` text,
  `tcf16` text,
  `tcf17` text,
  `tcf18` text,
  `tcf19` text,
  `tcf20` text,
  `tcf21` text,
  `tcf22` text,
  `tcf23` text,
  `tcf24` text,
  `tcf25` text,
  `tcf26` text,
  `tcf27` text,
  `tcf28` text,
  `tcf29` text,
  `tcf30` text,
  `tcf31` text,
  `tcf32` text,
  `tcf33` text,
  `tcf34` text,
  `tcf35` text,
  `tcf36` text,
  `tcf37` text,
  `tcf38` text,
  `tcf39` text,
  `tcf40` text,
  `tcf41` text,
  `tcf42` text,
  `tcf43` text,
  `tcf44` text,
  `tcf45` text,
  `tcf46` text,
  `tcf47` text,
  `tcf48` text,
  `tcf49` text,
  `tcf50` text,
  `ncf1` double DEFAULT NULL,
  `ncf2` double DEFAULT NULL,
  `ncf3` double DEFAULT NULL,
  `ncf4` double DEFAULT NULL,
  `ncf5` double DEFAULT NULL,
  `ncf6` double DEFAULT NULL,
  `ncf7` double DEFAULT NULL,
  `ncf8` double DEFAULT NULL,
  `ncf9` double DEFAULT NULL,
  `ncf10` double DEFAULT NULL,
  `ncf11` double DEFAULT NULL,
  `ncf12` double DEFAULT NULL,
  `ncf13` double DEFAULT NULL,
  `ncf14` double DEFAULT NULL,
  `ncf15` double DEFAULT NULL,
  `dcf1` varchar(160) DEFAULT NULL,
  `dcf2` varchar(160) DEFAULT NULL,
  `dcf3` varchar(160) DEFAULT NULL,
  `dcf4` varchar(160) DEFAULT NULL,
  `dcf5` varchar(160) DEFAULT NULL,
  `dcf6` varchar(160) DEFAULT NULL,
  `dcf7` varchar(160) DEFAULT NULL,
  `dcf8` varchar(160) DEFAULT NULL,
  `dcf9` varchar(160) DEFAULT NULL,
  `dcf10` varchar(160) DEFAULT NULL,
  `dcf11` varchar(160) DEFAULT NULL,
  `dcf12` varchar(160) DEFAULT NULL,
  `dcf13` varchar(160) DEFAULT NULL,
  `dcf14` varchar(160) DEFAULT NULL,
  `dcf15` varchar(160) DEFAULT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `a_security` (
  `objectid` int(11) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `authority` varchar(100) NOT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  `mask` tinyint(4) DEFAULT 0,
  `userid` varchar(50) NOT NULL,
  auditdate timestamp NULL DEFAULT NULL,
  audituser VARCHAR(50) NOT NULL,
  action VARCHAR(100)DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `navigator_audits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auditdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `service` varchar(25) DEFAULT NULL,
  `username` varchar(300) DEFAULT NULL,
  `ipaddress` varchar(128) DEFAULT NULL,
  `command` varchar(100) DEFAULT NULL,
  `resource` varchar(1000) DEFAULT NULL,
  `allowed` varchar(10) DEFAULT NULL,
  `dest` varchar(1000) DEFAULT NULL,
  `delegation_token_id` varchar(250) DEFAULT NULL,
  `permissions` varchar(250) DEFAULT NULL,
  `src` varchar(1000) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` varchar(50) DEFAULT NULL,
  `oeschemaid` int(11) DEFAULT NULL,
  `oetableid` int(11) DEFAULT NULL,
  `schemaname` varchar(255) DEFAULT NULL,
  `tablename` varchar(255) DEFAULT NULL,
  `operation_text` varchar(255) DEFAULT NULL,
  `resource_path` varchar(255) DEFAULT NULL,
  `query_id` varchar(255) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `privilege` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `qualifier` varchar(255) DEFAULT NULL,
  `family` varchar(255) DEFAULT NULL,
  `impersonator` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `fileloadtemp` (
	`fileid` int(11) NOT NULL AUTO_INCREMENT,
	`filename` varchar(255) DEFAULT NULL,
	`location` varchar(511) DEFAULT NULL,`filedescription` varchar(255) DEFAULT NULL,
	`type` varchar(50) DEFAULT NULL,
	`filetype` varchar(50) DEFAULT NULL,
	`filecreatedate` timestamp NULL DEFAULT NULL,
	`userid` varchar(50) DEFAULT NULL,
	PRIMARY KEY (`fileid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE generator (
  	generatorid INT(11) NOT NULL AUTO_INCREMENT,
  	param1 varchar(100),
  	param2 varchar(100),
	param3 varchar(100),
  	param4 varchar(100),
	param5 varchar(100),
  	PRIMARY KEY (generatorid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `static_temp_tables` (
  `statictemptablesid` int(11) NOT NULL AUTO_INCREMENT,
  `tablename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statictemptablesid`),
  UNIQUE KEY `tablename` (`tablename`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE globalworkflow (
  globalworkflowid int(11) NOT NULL AUTO_INCREMENT,
  workflowtype varchar(50) NOT NULL,
  assobject INT(11) DEFAULT 0,
  userid varchar(50) DEFAULT NULL,
  floworder INT(11) NOT NULL ,
  type varchar(50) default null,
  createby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updateby varchar(50) DEFAULT NULL,
  allapprove TINYINT(1) DEFAULT 0,
  isracienabled TINYINT(1) DEFAULT 0,
  PRIMARY KEY (globalworkflowid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE ticketworkflow (
  ticketworkflowid INT(11) NOT NULL AUTO_INCREMENT,
  ticketid INT(11) DEFAULT NULL,
  workflowtype varchar(50) NOT NULL,
  assobject INT(11) DEFAULT 0,
  userid varchar(50) DEFAULT NULL,
  approver varchar(50) DEFAULT NULL,
  floworder INT(11) NOT NULL,
  isapproved boolean default false,
  comments mediumtext,
  createby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updateby varchar(50) DEFAULT NULL,
  businessglossaryid int(11) default null,
  allapprove TINYINT(1) DEFAULT 0,
  isracienabled TINYINT(1) DEFAULT 0,
  PRIMARY KEY (ticketworkflowid )
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE editorimages (
	imageid int(11) NOT NULL AUTO_INCREMENT,
	image longblob,
	imagename varchar(255) DEFAULT NULL,
	objectid int(11) DEFAULT NULL,
	objecttype varchar(20) DEFAULT NULL,
	version int(11) DEFAULT NULL,
	lastupdateuser varchar(100) DEFAULT NULL,
	lastupdatetime datetime DEFAULT NULL,
	active tinyint(4) DEFAULT NULL,
	PRIMARY KEY (imageid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE ticketaccess(
  ticketaccessid INT(11) NOT NULL AUTO_INCREMENT,
  ticketid INT(11) NOT NULL,
  assobject INT(11) DEFAULT 0,
  userid varchar(50) DEFAULT NULL,
  inqueue boolean default true,
  workflowtype VARCHAR(50) NOT NULL,
  PRIMARY KEY (ticketaccessid),
  KEY `ticketid` (`ticketid`),
  CONSTRAINT `ticketaccess_ibfk_1` FOREIGN KEY (`ticketid`) REFERENCES `ticket` (`ticketid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `qliklog` (
	`logid` int(11) NOT NULL AUTO_INCREMENT,
	`chartid` int(11) DEFAULT NULL,
	`domainid` int(11) DEFAULT NULL,
	`genre` varchar(50) DEFAULT NULL,
	`logdata` longtext,
	`logformat` varchar(10) DEFAULT NULL,
	`createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updatedate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`logid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecuretable` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `oetableid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oetableid_idx` (`oetableid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `table_user_idx` (`oetableid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecurechart` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `chartid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chartid_idx` (`chartid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `chart_user_idx` (`chartid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecuredomain` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `domainid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `domainid_idx` (`domainid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `domain_user_idx` (`domainid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecureschema` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `oeschemaid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oeschemaid_idx` (`oeschemaid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `schema_user_idx` (`oeschemaid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecuredag` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `dagid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dagid_idx` (`dagid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `dag_user_idx` (`dagid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecureglobaldomain` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `globaldomainid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `globaldomainid_idx` (`globaldomainid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `globaldomain_user_idx` (`globaldomainid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `oesecurefilefolder` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `filefolderid` int(11) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `filefolderid_idx` (`filefolderid`),
  KEY `userid_idx` (`userid`),
  KEY `mask_idx` (`mask`),
  KEY `filefolder_user_idx` (`filefolderid`,`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table bods_xml ( 
	datasetid int, 
	dataflow_xml_data longtext
) ENGINE=InnoDB;

CREATE TABLE `a_userrole`(
	`role` VARCHAR(50) DEFAULT NULL,
	`userid` VARCHAR(50) DEFAULT NULL,
	createdby VARCHAR(50) DEFAULT NULL,
	createdate TIMESTAMP NULL DEFAULT NULL,
	`auditdate` timestamp NULL DEFAULT NULL,
	`audituser` VARCHAR(50) NOT NULL,
	`action` VARCHAR(50) NOT NULL
) ENGINE=INNODB;

CREATE TABLE `a_objectauthor`(
	`objectauthorid` int NOT NULL,
	`objecttype` VARCHAR(50) NOT NULL,
	`objectid` INT(11) NOT NULL,
	userid VARCHAR(50) DEFAULT NULL,
	lastmodifieduser VARCHAR(50) NOT NULL,
	lastmodifieddate timestamp NULL DEFAULT NULL
) ENGINE=INNODB;

CREATE TABLE `a_dataassetgroup`(
	`dataassetgroupid` int NOT NULL,
	`globaldomainid` INT(11) DEFAULT NULL,
	`approver` VARCHAR(50) DEFAULT NULL,
	`secondaryowner` VARCHAR(50),
	`secondarysteward` VARCHAR(50),
	`owner` VARCHAR(50) NOT NULL,
	`steward` VARCHAR(50) NOT NULL,
	tagid INT(11) NOT NULL,
	description text,
	objectid INT(11),
	objecttype VARCHAR(50),
	createdby VARCHAR(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT NULL,
	lastmoddate timestamp NULL DEFAULT NULL,
	updatedby VARCHAR(50) DEFAULT NULL,
	manageownership TINYINT,
	managestewardship TINYINT,
	managesecurity TINYINT,
	audituser VARCHAR(50) DEFAULT NULL,
	auditdate timestamp NULL DEFAULT NULL
) ENGINE=INNODB;

CREATE TABLE governpolicy (
	governpolicyid int(11) NOT NULL AUTO_INCREMENT,
	domainid int(11) NOT NULL,
	governpolicyname VARCHAR(100) NOT NULL,
	type VARCHAR(30),
	`status` VARCHAR(30),
	appliedobject VARCHAR(20),
	triggertype VARCHAR(30),
	createddate timestamp NULL DEFAULT NULL,
	createdby VARCHAR(50),
	lastmoddate timestamp NULL DEFAULT NULL,
	lastmodby VARCHAR(50),
	param text,
	description text,
	PRIMARY KEY (`governpolicyid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE governpolicyrule (
	governpolicyruleid int(11) NOT NULL AUTO_INCREMENT,
	governpolicyid int(11) NOT NULL,
	rulesequence int NOT NULL,
	ruletype VARCHAR(100),
	rulename VARCHAR(50),
	description VARCHAR(250),
	parmint1 INT(11),
	parmint2 INT(11),
	parmint3 INT(11),
	parmint4 INT(11),
	parmint5 INT(11),
	parmdate1 timestamp NULL DEFAULT NULL,
	parmdate2 timestamp NULL DEFAULT NULL,
	parmdate3 timestamp NULL DEFAULT NULL,
	parmdate4 timestamp NULL DEFAULT NULL,
	parmdate5 timestamp NULL DEFAULT NULL,
	parm1 VARCHAR(100),
	parm2 VARCHAR(100),
	parm3 VARCHAR(100),
	parm4 VARCHAR(100),
	parm5 VARCHAR(100),
	createdby VARCHAR(50),
	createddate timestamp NULL DEFAULT NULL,
	lastmoddate timestamp NULL DEFAULT NULL,
	lastmodby VARCHAR(50),
	CONSTRAINT governpolicyrule_pk PRIMARY KEY (governpolicyruleid),
	CONSTRAINT governpolicyrule_fk FOREIGN KEY (governpolicyid) REFERENCES governpolicy(governpolicyid) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `schema_impact` (
  `objectid` int(11) NOT NULL ,
  `objecttype` varchar(50)  NOT NULL,
  `objectparentid` int(11) DEFAULT NULL,
  `objectparentconnectionid` int(11)  NOT NULL,
  `sourcetableid` int(11) NOT NULL,
  `sourceschemaid` int(11) DEFAULT NULL,
  `sourceconnectionid` int(11) NOT NULL,
  `searchtype` varchar(50)  NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `crawlernotification` (
  `notificationid` int(11) NOT NULL AUTO_INCREMENT,
  `connectionid` int(11) NOT NULL,
  `notifymetachange` tinyint(4) DEFAULT NULL,
  `dataowner` tinyint(1) DEFAULT NULL,
  `datasteward` tinyint(1) DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`notificationid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE contexturl (
  contexturlid INT(11) NOT NULL AUTO_INCREMENT,
  contexturlname varchar(50) NOT NULL,
  connectioninfoid INT(11) NOT NULL,
  createby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updateby varchar(50) DEFAULT NULL,
  PRIMARY KEY (contexturlid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE a_project(
	projectid int NOT NULL,
    projectname varchar(150)  DEFAULT NULL,	
    description text,
	sharecontent TINYINT(1),
	createdby VARCHAR(50)DEFAULT NULL,
	createdate timestamp NULL DEFAULT NULL,
	lastmoddate timestamp NULL DEFAULT NULL,
	updatedby varchar(50) DEFAULT NULL,
	defaultproj TINYINT(1),
	auditdate timestamp NULL DEFAULT NULL,
	audituser VARCHAR(50)NOT NULL
)ENGINE = INNODB;

CREATE TABLE a_projectcontent(
	projectcontentid int NOT NULL,
	projectid INT(11),
	assobject VARCHAR(50),
	assobjectid INT(11),
	notes longtext,
	version INT(11),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT NULL,
	lastmoddate timestamp NULL DEFAULT NULL,
	updatedby varchar(50) DEFAULT NULL,
	auditdate timestamp NULL DEFAULT NULL,
	audituser VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE a_projectuser(
	projectuserid int NOT NULL,
	projectid INT(11),
    userid varchar(50) DEFAULT NULL,	
    defaultproj tinyint DEFAULT 0,
	confirmed TINYINT(1),
	createdby varchar(50) DEFAULT NULL,
	createdate timestamp NULL DEFAULT NULL,
	lastmoddate timestamp NULL DEFAULT NULL,
    updatedby varchar(50)  DEFAULT NULL,	
    auditdate timestamp NULL DEFAULT NULL,
	audituser VARCHAR(50) NOT NULL
)ENGINE = INNODB;

CREATE TABLE `a_user`(
	`userid` varchar(50) NOT NULL,
	`fname` VARCHAR(50),
	`lname` VARCHAR(50),
	`email` VARCHAR(50),
	`gender` VARCHAR(50)DEFAULT NULL,
	`city_state` VARCHAR(255)DEFAULT NULL,
	`zip` INT(11)DEFAULT NULL,
	`personal_phone` VARCHAR(50),
	`password` VARCHAR(256),
	`address` LONGTEXT DEFAULT NULL,
	`notifyviaemail` TINYINT(1)DEFAULT NULL,
	`authorities` VARCHAR(50)DEFAULT NULL,
	`title` VARCHAR(50)DEFAULT NULL,
	`status` VARCHAR(50)DEFAULT NULL,
	`usertype` VARCHAR(50)DEFAULT NULL,
	`token` VARCHAR(255)DEFAULT NULL,
	`licenseaccepted` TINYINT(1)DEFAULT NULL,
	`createdate` TIMESTAMP NULL,
	`lastmoddate` TIMESTAMP NULL DEFAULT NULL,
	`outofoffice` TINYINT(4)DEFAULT NULL,
	`allowusermention` TINYINT(4)DEFAULT NULL,
	`allowwatchlistalert` TINYINT(4)DEFAULT NULL,
	`allowsystemalert` TINYINT(4)DEFAULT NULL,
	allowdqralert tinyint(4) COMMENT 'This allows to send email alerts for DQR',
	allowservicedeskalert tinyint(4) COMMENT'This allows to send email alerts for service desk',
	`slackid` VARCHAR(50)DEFAULT NULL,
	`managerid` VARCHAR(50)DEFAULT NULL,
	`dgmanagerid` VARCHAR(50)DEFAULT NULL,
	`dcmanagerid` VARCHAR(50)DEFAULT NULL,
	`audituser` VARCHAR(50)NOT NULL,
	`auditdate` timestamp NULL DEFAULT NULL
)ENGINE = INNODB;

CREATE TABLE datasetresults (
  jobstepid INT(11) NOT NULL,
  results longblob,
  datasetid INT(11) NOT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (jobstepid)
) ENGINE=InnoDB;

CREATE TABLE `sourcecode` (
`sourcecodeid`  int(11) NOT NULL AUTO_INCREMENT COMMENT 'Source code table is used for storing xml or other files and data which is related to lineage building information' ,
`connectioninfoid`  int(11) NOT NULL ,
`objecttype`  varchar(64) NOT NULL ,
`objectid`  int(11) NOT NULL ,
`type`  varchar(16) NOT NULL ,
`code`  longtext NOT NULL ,
`lastupdatedate`  datetime NULL ,
`createddate`  datetime NOT NULL ,
`createdby`  varchar(64) NOT NULL ,
`lineagebuilt` tinyint DEFAULT 0,
`sourcecodename` varchar(256) DEFAULT NULL,
`lineagestatus` varchar(100) DEFAULT NULL,
`status` varchar(100) DEFAULT NULL,
`errormessage` text NULL,
`lastlineagerundate` datetime DEFAULT NULL COMMENT 'This column is to store lastlineagerundate of lineage (ETL and Reports)',
 version int(11) not null default 1 COMMENT "version of source code",
 islineagefit tinyint(1) not null default 1 COMMENT "Is sourcecode eligible for lineage build process",
PRIMARY KEY (`sourcecodeid`),
FULLTEXT KEY `ft_code_sc` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `lineageconfig` (
`lineageconfigid`  int(11) NOT NULL AUTO_INCREMENT,
`connectioninfoid`  int(11) NOT NULL ,
`oeschemaid`  int(11) NOT NULL ,
PRIMARY KEY (`lineageconfigid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE patternrelation (
  	patternrelationid INT(11) NOT NULL AUTO_INCREMENT,
  	sourceid INT(11),
  	targetid INT(11),
	disabled INT(11),
  	objecttype varchar(100),
  	PRIMARY KEY (patternrelationid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `stg_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionname` varchar(100) DEFAULT NULL,
  `schemaname` varchar(255) DEFAULT NULL,
  `datasetname` varchar(256) DEFAULT NULL,
  `title` mediumtext,
  `query` mediumtext,
  `businessdescription` mediumtext,
  `jobtype` varchar(255) DEFAULT NULL,
  `sqltype` varchar(50) DEFAULT NULL,
  `creatortype` varchar(50) DEFAULT NULL,
  `creatorid` int(11) DEFAULT NULL,
  `tagname` varchar(255) DEFAULT NULL,
  `term` varchar(255) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(500) DEFAULT NULL,
  `batchno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `querylogsetting` (
  `querylogsettingid` int(11) NOT NULL AUTO_INCREMENT,
  `connectioninfoid` int(11) DEFAULT NULL,
  `lineageselectedschemas` varchar(2000) DEFAULT NULL,
  `includequerytypes` varchar(500) DEFAULT NULL,
  `lookbackperiod` int(11) DEFAULT NULL,
  `excludeusers` varchar(255) DEFAULT NULL,
  `query` varchar(1000) DEFAULT NULL,
  `lastrundate` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`querylogsettingid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE oeetl (
  oeetlid  bigint NOT NULL AUTO_INCREMENT,
  oeetlname  varchar(512) NOT NULL,
  connectioninfoid  bigint NOT NULL,
  lastmoddate  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  createdate  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  crawled  tinyint(1) NOT NULL,
  active  tinyint(1) NOT NULL,
  description  varchar(512) NULL,
  owner  varchar(64) NULL,
  steward  varchar(64) NULL,
  PRIMARY KEY (oeetlid)
);

CREATE TABLE `a_chart` (
  `CHARTID` int NOT NULL,
  `CHARTNAME` varchar(255) DEFAULT NULL,
  `COLNAMETYPEMAP` text,
  `OPTIONS` text,
  `GENRE` varchar(20) DEFAULT NULL,
  `DESCRIPTION` text,
  `datasetid` int(11) DEFAULT NULL,
  `CREATEDBY` varchar(50) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,	
  `OWNER` varchar(50) DEFAULT NULL,
  `LASTMODDATE` timestamp NULL DEFAULT NULL,
  `CHARTTYPE` varchar(100) DEFAULT 'chart',
  `DOMAINID` int(11) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `extreferenceid` varchar(255) DEFAULT NULL,
  `USESCORE` int(11) DEFAULT '0',
  `chartscore` int(11) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  `parentchartid` int(11) DEFAULT NULL,
  `chartdata` text,
  createdate timestamp NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NULL DEFAULT NULL,
  steward varchar(50),
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index',
  version int(11) not null default 1 COMMENT 'This column is to define version of the chart record'
) ENGINE=InnoDB;

CREATE TABLE `a_chartchild` (
  `chartchildid` int NOT NULL,
  `chartid` int(11) NOT NULL,
  `childname` varchar(256) DEFAULT NULL,
  `childtype` varchar(50) DEFAULT NULL,
  DESCRIPTION mediumtext, 
  usescore int(11),
  displayeligible tinyint(4),
  columnlength double,
  minval varchar(500),
  maxval varchar(500), 
  nullcount bigint(20),
  distinctcount bigint(20),
  typestats mediumtext,
  topvalues mediumtext,
  mask tinyint(4),
  restricted tinyint(4),
  columnposition int(11),
  lastmetasyncdate timestamp NULL DEFAULT NULL,
  active tinyint(4),
  inaudit tinyint(4),
  businessglossaryid int(11) DEFAULT NULL,
  LASTMODDATE timestamp NULL DEFAULT NULL,
  columnscore int(11) default null,
  createdate timestamp NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  `formula` text,
  dqindex double default null COMMENT 'This is for the data quality index'
) ENGINE=InnoDB; 

CREATE TABLE `a_file` (
  `fileid` int NOT NULL,
  `filename` varchar(511) DEFAULT NULL,
  `location` varchar(511) DEFAULT NULL,
  `filefolderid` int(11) DEFAULT NULL,
  `filedescription` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `filetype` varchar(10) DEFAULT NULL,
  `filelastmoddate` date  ,
  `filecreatedate` date ,
  `businessglossaryid` int(11) DEFAULT NULL,
  `userid` varchar(255) DEFAULT NULL,
  `usescore` int(11) DEFAULT 0,
  `rating` float,
  `profilepercent` int,	
  `sizeinbytes` bigint(20) DEFAULT NULL,
  `highperfjobid` int(10),
  `aclcreated` tinyint,
  `active` tinyint(4) DEFAULT 0,
  `lastanalyzeddate` TIMESTAMP NULL DEFAULT NULL,
  `analyzedstatus` varchar(55) DEFAULT 'Not Analyzed',
  `rowcount` int(11) DEFAULT NULL,
  `lastpopulateddate` TIMESTAMP NULL DEFAULT NULL,
  `lastmetasyncdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inaudit` tinyint(4) DEFAULT NULL,
  `lastmoddate` timestamp NULL DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL,
  `storageclass` varchar(255),
  `storagetype` varchar(255),
   isprofile tinyint default 0,
   remotetags text,
   `columnsecure` tinyint(4),	
   metadata text,
   remotekeys text,
   owner varchar(50),
   steward varchar(50),
   lastmodby VARCHAR(50) DEFAULT NULL,
   createdby VARCHAR(50) DEFAULT NULL,
   lastupdatereference VARCHAR(30) DEFAULT NULL,
   `filescore` int(11) DEFAULT NULL,
   dqindex double default null COMMENT 'This is for the data quality index'
) ENGINE=InnoDB;

CREATE TABLE `a_filecolumn` (
  `filecolumnid` int NOT NULL,
  `fileid` int(11) NOT NULL,
  `columnname` varchar(256) DEFAULT NULL,
  `columntype` varchar(50) DEFAULT NULL,
  `columndescription` varchar(256) DEFAULT NULL,
  `beavercolumntype` varchar(100) DEFAULT NULL,
  `columnscore` int(11) DEFAULT NULL,
  `usescore` int(11) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `displayeligible` tinyint(4) DEFAULT NULL,
  `columnlength` int(11) DEFAULT NULL,
  `minval` varchar(500) DEFAULT NULL,
  `maxval` varchar(500) DEFAULT NULL,
  `nullcount` bigint(20) DEFAULT NULL,
  `distinctcount` bigint(20) DEFAULT NULL,
  `typestats` text DEFAULT NULL,
  `topvalues` text DEFAULT NULL,
  `mask` tinyint(4) DEFAULT 0,
  `restricted` tinyint(4) DEFAULT 0,
  `columnposition` int(11) DEFAULT NULL,
  `lastmetasyncdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` tinyint(4) DEFAULT NULL,
  `inaudit` tinyint(4) DEFAULT NULL,
  `firsthundred` text DEFAULT NULL,
  `patternstats` varchar(256),	
  createdate timestamp NULL DEFAULT NULL,
  lastmoddate TIMESTAMP NULL DEFAULT NULL,
  lastpopulateddate TIMESTAMP NULL DEFAULT NULL,
  lastmodby VARCHAR(50) DEFAULT NULL,
  createdby VARCHAR(50) DEFAULT NULL,
  lastupdatereference VARCHAR(30) DEFAULT NULL,
  dqindex double default null COMMENT 'This is for the data quality index'
) ENGINE=InnoDB;

create table stg_sourcecode(
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `connectionname` varchar(100) DEFAULT NULL,
 `reportgroupname` varchar(255) DEFAULT NULL,
 `reportname` varchar(256) DEFAULT NULL,
 `sourcecode`  longtext DEFAULT NULL,
 `sourcecodetype`  varchar(16) DEFAULT NULL,
 `createdate` timestamp NULL DEFAULT NULL,
 `processed_flag` tinyint(4) DEFAULT '0',
 `error_msg` varchar(500) DEFAULT NULL,
 `batchno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
)ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE searchaudit(
	searchauditid INT(11)NOT NULL AUTO_INCREMENT,
	searchterm VARCHAR(1000),
	userid VARCHAR(50)DEFAULT NULL,
	searchdate TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	assobject VARCHAR(255)DEFAULT NULL,
	assobjectid INT(11),
	PRIMARY KEY(searchauditid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE remotepermission (
  remotepermissionid INT(11) NOT NULL AUTO_INCREMENT,
  connectioninfoid INT(11) NOT NULL,
  remoteuser varchar(50) DEFAULT NULL,
  remoterole varchar(50) DEFAULT NULL,
  oeuser varchar(50) DEFAULT NULL,
  objecttype varchar(50) DEFAULT NULL,
  objectid  int(11) DEFAULT NULL,
  rmtpermission mediumtext,
  lastmetasyncdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate  timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmodby varchar(50) DEFAULT NULL,
  PRIMARY KEY (remotepermissionid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE remoteuserpwdcache (
	remoteuserpwdcacheid INT(11)NOT NULL AUTO_INCREMENT,
	userid VARCHAR(50)DEFAULT NULL,
	remoteuserid VARCHAR(50)DEFAULT NULL,
	connectioninfoid INT(11),
	PASSWORD VARCHAR(256)DEFAULT NULL,
	PRIMARY KEY(remoteuserpwdcacheid)
) ENGINE=INNODB AUTO_INCREMENT=1000;

CREATE TABLE lineagecleanup  (
  lineagecleanupid INT(11) NOT NULL AUTO_INCREMENT, 
  actualstring VARCHAR(100) DEFAULT NULL,
  replacementstring VARCHAR(100) NOT NULL,  
  PRIMARY KEY (lineagecleanupid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table templineagedataset(
templineagedatasetid INT(11) NOT NULL AUTO_INCREMENT,
oeschemaid INT(11) NOT NULL ,
oetableid INT(11) NOT NULL ,
datasetid INT(11) NOT NULL  ,
schemaname varchar(500),
tablename varchar(500),
reason varchar(500),
createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
createdby varchar(500), 
 PRIMARY KEY (templineagedatasetid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table datasetorigquery(
datasetorigqueryid INT(11) NOT NULL AUTO_INCREMENT,
datasetid INT(11) NOT NULL  ,
origquery mediumtext, 
 PRIMARY KEY (datasetorigqueryid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE a_custom_objects (
  customobjectid int(11) not null,
  objectid int(11) NOT NULL,
  objecttype varchar(50) NOT NULL,
  ccf1 int(11) DEFAULT NULL,
  ccf2 int(11) DEFAULT NULL,
  ccf3 int(11) DEFAULT NULL,
  ccf4 int(11) DEFAULT NULL,
  ccf5 int(11) DEFAULT NULL,
  ccf6 int(11) DEFAULT NULL,
  ccf7 int(11) DEFAULT NULL,
  ccf8 int(11) DEFAULT NULL,
  ccf9 int(11) DEFAULT NULL,
  ccf10 int(11) DEFAULT NULL,
  ccf11 int(11) DEFAULT NULL,
  ccf12 int(11) DEFAULT NULL,
  ccf13 int(11) DEFAULT NULL,
  ccf14 int(11) DEFAULT NULL,
  ccf15 int(11) DEFAULT NULL,
  tcf1 text DEFAULT null,
  tcf2 text DEFAULT null,
  tcf3 text DEFAULT null,
  tcf4 text DEFAULT null,
  tcf5 text DEFAULT null,
  tcf6 text DEFAULT null,
  tcf7 text DEFAULT null,
  tcf8 text DEFAULT null,
  tcf9 text DEFAULT null,
  tcf10 text DEFAULT null,
  tcf11 text DEFAULT null,
  tcf12 text DEFAULT null,
  tcf13 text DEFAULT null,
  tcf14 text DEFAULT null,
  tcf15 text DEFAULT null,
  tcf16 text DEFAULT null,
  tcf17 text DEFAULT null,
  tcf18 text DEFAULT null,
  tcf19 text DEFAULT null,
  tcf20 text DEFAULT null,
  tcf21 text DEFAULT null,
  tcf22 text DEFAULT null,
  tcf23 text DEFAULT null,
  tcf24 text DEFAULT null,
  tcf25 text DEFAULT null,
  tcf26 text DEFAULT null,
  tcf27 text DEFAULT null,
  tcf28 text DEFAULT null,
  tcf29 text DEFAULT null,
  tcf30 text DEFAULT null,
  tcf31 text DEFAULT null,
  tcf32 text DEFAULT null,
  tcf33 text DEFAULT null,
  tcf34 text DEFAULT null,
  tcf35 text DEFAULT null,
  tcf36 text DEFAULT null,
  tcf37 text DEFAULT null,
  tcf38 text DEFAULT null,
  tcf39 text DEFAULT null,
  tcf40 text DEFAULT null,
  tcf41 text DEFAULT null,
  tcf42 text DEFAULT null,
  tcf43 text DEFAULT null,
  tcf44 text DEFAULT null,
  tcf45 text DEFAULT null,
  tcf46 text DEFAULT null,
  tcf47 text DEFAULT null,
  tcf48 text DEFAULT null,
  tcf49 text DEFAULT null,
  tcf50 text DEFAULT null,
  ncf1 double(11,2) DEFAULT NULL,
  ncf2 double(11,2) DEFAULT NULL,
  ncf3 double(11,2) DEFAULT NULL,
  ncf4 double(11,2) DEFAULT NULL,
  ncf5 double(11,2) DEFAULT NULL,
  ncf6 double(11,2) DEFAULT NULL,
  ncf7 double(11,2) DEFAULT NULL,
  ncf8 double(11,2) DEFAULT NULL,
  ncf9 double(11,2) DEFAULT NULL,
  ncf10 double(11,2) DEFAULT NULL,
  ncf11 double(11,2) DEFAULT NULL,
  ncf12 double(11,2) DEFAULT NULL,
  ncf13 double(11,2) DEFAULT NULL,
  ncf14 double(11,2) DEFAULT NULL,
  ncf15 double(11,2) DEFAULT NULL,
  dcf1 date DEFAULT NULL,
  dcf2 date DEFAULT NULL,
  dcf3 date DEFAULT NULL,
  dcf4 date DEFAULT NULL,
  dcf5 date DEFAULT NULL,
  dcf6 date DEFAULT NULL,
  dcf7 date DEFAULT NULL,
  dcf8 date DEFAULT NULL,
  dcf9 date DEFAULT NULL,
  dcf10 date DEFAULT NULL,
  dcf11 date DEFAULT NULL,
  dcf12 date DEFAULT NULL,
  dcf13 date DEFAULT NULL,
  dcf14 date DEFAULT NULL,
  dcf15 date DEFAULT NULL,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT NULL,
  lastmoddate timestamp NULL DEFAULT NULL,
  updatedby varchar(50) DEFAULT NULL,
  connectioninfoid int(11) not null COMMENT 'this column is to store connectioninfoid for corresponding object for archive table'
) ENGINE=InnoDB;

CREATE TABLE a_governpolicydesc(
	governpolicyid int(11) DEFAULT NULL,
	domainid INT(11) NOT NULL,
	governpolicyname VARCHAR(100) NOT NULL,
	description mediumtext,
	lastmoddate TIMESTAMP NULL DEFAULT NULL,
	lastmodby VARCHAR(50) DEFAULT NULL
)ENGINE = INNODB;

CREATE TABLE stg_lineage (
	id INT(11) NOT NULL AUTO_INCREMENT,
	sourceconnection varchar(100) DEFAULT NULL,
	sourceschema varchar(255) DEFAULT NULL,
	sourcename varchar(255) DEFAULT NULL,
	sourcetype varchar(50) DEFAULT NULL, 
	targetconnection varchar(100) DEFAULT NULL,
	targetschema varchar(255) DEFAULT NULL,
	targetname varchar(255) DEFAULT NULL,
	targettype varchar(50) DEFAULT NULL,
	referencevalue text default null,
	referencename varchar(256),
	transformationnotes text DEFAULT NULL,
	columninfo text DEFAULT NULL,
	sourcecolumn varchar(255) DEFAULT NULL,
	targetcolumn varchar(255) DEFAULT NULL,
	createdate timestamp NULL DEFAULT NULL,
  	processed_flag tinyint(4) DEFAULT '0',
  	error_msg varchar(500) DEFAULT NULL,
  	batchno varchar(50) DEFAULT NULL,
  	referenceconnection varchar(255) DEFAULT NULL COMMENT 'To capture dataset connection name',
  	referenceschema varchar(255) DEFAULT NULL COMMENT 'To capture dataset user selected DB i.e schema',
	PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE mailstatus (
  mailstatusid INT(11) NOT NULL AUTO_INCREMENT,
  mailtype varchar(100) DEFAULT NULL,
  toemail varchar(100) NOT NULL,
  status int(11) NOT NULL,
  statusmsg varchar(50) DEFAULT NULL,
  objecttype varchar(50) DEFAULT NULL,
  objectid  varchar(50) DEFAULT NULL,
  PRIMARY KEY (mailstatusid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE a_connectioninfo (
  connectioninfoid int(11) NOT NULL,
  servertype varchar(200)  DEFAULT NULL,
  name varchar(100) DEFAULT NULL,
  conntype int(11) DEFAULT NULL,
  auditdate timestamp NULL DEFAULT NULL,
  updatedby varchar(50) DEFAULT NULL,
  action varchar(100) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `a_objectrolepermissions` (
  `objectid` int(11) DEFAULT NULL,
  `objectname` varchar(256) DEFAULT NULL,
  `objecttype` varchar(64) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  `rolename` varchar(50) DEFAULT NULL,
  `permission` varchar(255) DEFAULT NULL,	
  `permissionvalue` int(11) DEFAULT NULL,
  audituser VARCHAR(50) DEFAULT NULL,
  auditdate timestamp NULL DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `include_folders` (
  `connectioninfoid` int(50) DEFAULT NULL,
  `Folder_Name` varchar(3000) NOT NULL,
  `createdate` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `a_objectendorsement` (
  `objectendorsementid` int NOT NULL COMMENT 'this is objectendorsementid for primary key' ,
  `objecttype` varchar(50) DEFAULT NULL COMMENT 'this is objecttype for differentiate objects',
  `objectid` int(11) DEFAULT NULL COMMENT 'this is objectid for different objects id',
  `endorsementtype` varchar(20) DEFAULT NULL COMMENT 'this is endorsementtype according to endorsements',
  `rating` float DEFAULT NULL COMMENT 'this is rating for observations',
  `message` mediumtext default null,
  `userid` varchar(50) DEFAULT NULL COMMENT 'this is userid from which endorsements happened',
  `lastmoddate` timestamp NULL DEFAULT NULL COMMENT 'this is lastmoddate when endorsements happened',
  `lineageflag` tinyint(4) DEFAULT '0' COMMENT 'this is lineageflag for indicating lineage',
  objectidref int(11) COMMENT 'this is objectidref for reference objects id'
) ENGINE=InnoDB
COMMENT 'This is a_objectendorsement table created for archieve objectendorsements';

create table stg_columnrelation(
id INT(11) NOT NULL AUTO_INCREMENT COMMENT 'this is id for primary key',
columnid INT(11) COMMENT 'creating column relations to this column id ',
connectionname varchar(100) COMMENT 'this is connname of below schemaname',
schemaname varchar(256) COMMENT 'this is schemaname of below tablename',
tablename varchar(256) COMMENT 'this is tablename for below columnname',
columnname varchar(256) COMMENT 'this is columnname which we need to add column relation',
createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'this is for current timestamp',
processed_flag tinyint(4) DEFAULT '0' COMMENT 'this is flag of of execution record 1-completed,2-error',
error_msg varchar(200) DEFAULT NULL COMMENT 'this is final status msg of execution record',
batchno varchar(50) DEFAULT NULL COMMENT 'this is uniquely generated number on timestamp',
PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1000
COMMENT='This stg_columnrelation table is for creating column relations for given column Id';

CREATE TABLE jobprocesseddates (
  processeddate DATE COMMENT 'Column to store the processed dates',
  jobstepid int(11) COMMENT 'Column to store jobstepId',
  connectioninfoid int(11) DEFAULT '0'
) COMMENT 'Table to store the dates which are already processed for AssetUsageAnalysis';

CREATE TABLE sync_instance_data (
  syncdataid int(11) NOT NULL AUTO_INCREMENT,
  instanceid varchar(200) NOT NULL,
  context varchar(50) NOT NULL,
  value1 varchar(200) DEFAULT NULL,
  value2 varchar(200) DEFAULT NULL,
  value3 varchar(200) DEFAULT NULL,
  value4 varchar(200) DEFAULT NULL,
  value5 varchar(200) DEFAULT NULL,
  status int(11) NOT NULL default 0,
  createdby varchar(50) DEFAULT NULL,
  createdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updatedby varchar(50) DEFAULT NULL,
  PRIMARY KEY (syncdataid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `mailtemplate` (
  `templateid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'It is primary key',
  `templatetype` varchar(50) DEFAULT NULL COMMENT 'It differentiates emailtemplate type',
  `emailsubject` mediumtext COMMENT 'It is email subject',
  `emailbody` text COMMENT 'It is email body',
  `emailvariable` varchar(250) DEFAULT NULL COMMENT 'These are the variables present in email body',
  PRIMARY KEY (`templateid`)
) AUTO_INCREMENT=1000 COMMENT 'This table stores customized email body and email subject';

create table stg_datasetcorrection (
	id int(11) NOT NULL AUTO_INCREMENT COMMENT 'It is primary key',
	datasetid int(11) COMMENT 'It is used to store datasetid',
	actualquery longtext COMMENT 'It is used for dataset actual query',
	correctedquery longtext COMMENT 'It is used for dataset correction query',
	lineagestatus varchar(100) COMMENT 'It is used for status correction',
	createdate timestamp COMMENT 'It is used for storing created timestamp',
	processed_flag tinyint(4) COMMENT 'It is used for knowing the status of operation',
	error_msg varchar(255) COMMENT 'It is used for storing error msg',
	batchno varchar(50) COMMENT 'It is used for batch number',
	manuallineage text COMMENT 'It is used for storing details for manual lineage',
	PRIMARY KEY (id)
) 
COMMENT='It is Staging table for storing dataset correction';

CREATE TABLE searchterms (
  searchtermid INT(11) NOT NULL AUTO_INCREMENT,
  searchterm varchar(100) NOT NULL,
  searchcount int(11) NOT NULL,
  objecttype varchar(50) NOT NULL,
  objectid int(11) NOT NULL,
  createdby varchar(50) NOT NULL,
  createdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updatedby varchar(50) NOT NULL,
  isbgrelated tinyint(1) default 0,
  PRIMARY KEY (searchtermid),
  UNIQUE ukey_st_ot_oi(searchterm, objecttype, objectid),
  INDEX ikey_st_ot_oi (searchterm, objecttype, objectid)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

create table ignoresqlforlineage(
	ignoresqlid int(11)NOT NULL AUTO_INCREMENT,
	connectioninfoid int(11),
	sqlstartswith varchar(255),
	sqlcontainsall varchar(255),
	sqlcontainsany varchar(255),
	sqlnegationwords varchar(255),
	PRIMARY KEY(`ignoresqlid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000
COMMENT 'The table used to ignore queries to process the lineage those queries mention by inserting the data to this table ';

CREATE TABLE oesynonym (
    oesynonymid       int(11)   NOT NULL AUTO_INCREMENT COMMENT 'this is objectendorsementid for primary key',
    connectionid      int(11)   NOT NULL,
    synonymname       varchar(255)       DEFAULT NULL COMMENT 'name of the synonym',
    synonymdefinition varchar(1000)      DEFAULT NULL COMMENT 'actual code for the synonym',
    servername        varchar(255)       DEFAULT NULL COMMENT 'server to which this synonym pointing to',
    dbname            varchar(255) COMMENT 'database name that this synonym resolve to',
    schemaname        varchar(255)       DEFAULT NULL COMMENT 'schema name for the synonym',
    tablename         varchar(255)       DEFAULT NULL COMMENT 'table name for the synonym',
    createdate        timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    modifydate        timestamp NULL     DEFAULT NULL,
    PRIMARY KEY (oesynonymid)
) ENGINE = InnoDB AUTO_INCREMENT = 1000
COMMENT 'Table used to store synonyms from the Relational databases';

CREATE TABLE dataiddetails (
	impacttype varchar(225),
	impactedtable varchar(225),
	impactedcolumn varchar(225),
	impactnotes_1 varchar(225),
	impactnotes_2 varchar(225),
	replacementtable varchar(225),
	replacementcolumn varchar(225),
	replacementnotes_1 varchar(225),
	replacementnotes_2 varchar(225)
);

CREATE TABLE dqfunctiondef (
  dqfunctiondefid INT(11) NOT NULL AUTO_INCREMENT COMMENT 'this is dqfunctiondefid for primary key.',
  name varchar(100) DEFAULT NULL COMMENT 'this name is for user given rule name.',
  standardcode varchar(2000) NOT NULL COMMENT 'this standardcode is sqlcode.',
  objecttype varchar(50) DEFAULT NULL COMMENT 'this objecttype is differentiate objects.',
  runonsource boolean default false COMMENT 'This runonsource is to check query need to execute in remote system or in ovaledge application.',
  dimension  varchar(50) DEFAULT NULL COMMENT 'this dimension is to associate the fucntions.',
  functiontype varchar(50) DEFAULT NULL COMMENT 'this functiontype is to know which type of a function is it.',
  functioninputcount INT(11) DEFAULT NULL COMMENT 'this functioninputcount is to provide count of a functioninput ',
  type varchar(100) NOT NULL,
  statscode varchar(2000) default null,
  valuescode varchar(2000) default null,
  PRIMARY KEY (dqfunctiondefid)
) ENGINE=InnoDB AUTO_INCREMENT=1000
COMMENT 'This is dqfunctiondef table created for mentioning functions, deminsions of an object.';

CREATE TABLE dqfunctiondefserver (
  dqruledefserverid INT(11) NOT NULL AUTO_INCREMENT COMMENT 'this is dqruledefserverid for primary key',
  servertype varchar(50) DEFAULT NULL COMMENT 'this servertype is to know in which type of server is it.',
  type varchar(100) NOT NULL,
  servercode varchar(2000) NOT NULL COMMENT 'this servercode is serversqlcode.',
  statscode varchar(2000) default null,
  valuescode varchar(2000) default null,
  PRIMARY KEY (dqruledefserverid)
) ENGINE=InnoDB AUTO_INCREMENT=1000
COMMENT 'This is dqfunctiondefserver table created for mentioning the servers with respect to the dqfunctiondef.';

create table stg_affectedobjects(
	id INT(11) AUTO_INCREMENT COMMENT 'Column to store id as primary key',
	connectionname  LONGTEXT COMMENT 'Column to store connection name',
	schemaname VARCHAR(200) COMMENT 'Column to store schema name',
	impactanalysisname VARCHAR(200) COMMENT 'Column to store impactanalysis name',
	objectname VARCHAR(200) COMMENT 'Column to store table name',
	fieldname VARCHAR(100) COMMENT 'Column to store table column name',
	objecttype VARCHAR(100) COMMENT 'Column to store objectype',
	analysistype VARCHAR(10) COMMENT 'Column to store analysis type',
	createdate TIMESTAMP COMMENT 'Column to store current time stamp',
	processed_flag TINYINT(4) COMMENT 'Column to store flag status',
	error_msg VARCHAR(500) COMMENT 'Column to store message',
	batchno VARCHAR(50) COMMENT 'Column to store batch number', 
	PRIMARY KEY (ID)
) COMMENT 'Table to store stage affected objects to load metadata from file';

CREATE TABLE `atlas_audits` (
	  `atlas_audit_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'this is atlas_audits for primary key. ',
	  `db_connectioninfo_id` int(11) NOT NULL COMMENT 'this is connection info id of base database connection. ',
	  `database_name` varchar(255) DEFAULT NULL COMMENT 'this is name of schema name with GUID. ',
	  `guid` varchar(255) DEFAULT NULL COMMENT 'this is GUID of an Object. ',
	  `atlas_entity_type` varchar(255) DEFAULT NULL COMMENT 'this is atlas entity type. ',
	  `entity_name` varchar(255) DEFAULT NULL COMMENT 'this is atlas entity name. ',
	  `object_id` int(11) DEFAULT NULL COMMENT 'this is object id in ovaledge .',
	  `object_type` varchar(255) DEFAULT NULL COMMENT 'this is object type in ovaledge. ',
	  `last_crawl_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'this is last updated or crawled date. ',
	  PRIMARY KEY (`atlas_audit_id`)
)COMMENT 'This is atlas audit table created for fetching and mapping atlas objects with objects in Ovaledge. ';

CREATE TABLE stg_dqdefserver (
	stgdqdefserverid INT(11) NOT NULL AUTO_INCREMENT COMMENT 'this is stgdqdefserverid for primary key',
	servertype VARCHAR(50) DEFAULT NULL COMMENT 'this servertype is to know in which type of server is it.',
	type VARCHAR(100)DEFAULT NULL,
	servercode VARCHAR(1000) DEFAULT NULL COMMENT 'this servercode is serversqlcode.',
	name VARCHAR(100) DEFAULT NULL COMMENT 'this name is for user given rule name.',
	objecttype VARCHAR(50) DEFAULT NULL COMMENT 'this objecttype is differentiate objects.',
	standardcode VARCHAR(1000) NOT NULL COMMENT 'this standardcode is sqlcode.',
	dimension VARCHAR(50) DEFAULT NULL COMMENT 'this dimension is to associate the fucntions.',
	functiontype VARCHAR(50) DEFAULT NULL COMMENT 'this functiontype is to know which type of a function is it.',
	processed_flag tinyint default 0,
  	status_msg varchar(255) default null,
  	lastmoddate date null,
 	createdate date null,
	PRIMARY KEY(stgdqdefserverid)
) ENGINE = INNODB AUTO_INCREMENT = 1000 COMMENT 'This is stg_dqdefserver table user can insert sqls into this table for dqrule.';

CREATE TABLE `custombuiltaffectedobjectsapi` (
  `affectedobjectid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This is an unique identifier for each record',
  `impactanalysisid` int(11) DEFAULT NULL COMMENT 'This is to link with impactanalysis table which is parent',
  `impacttype` varchar(50) NOT NULL COMMENT 'This is to define whether the impact is for right or left',
  `objecttype` varchar(50) DEFAULT NULL COMMENT 'This is to define the type of object added',
  `objectid` int(11) DEFAULT NULL COMMENT 'This describes the object id added',
  `jobstatus` varchar(50) DEFAULT NULL COMMENT 'This describes the object id added to the impact analysis',
  `lastupdatedate` timestamp NULL DEFAULT NULL COMMENT 'To track when is the record modified',
  `jobrundate` timestamp NULL DEFAULT NULL COMMENT 'Date on which the impacted objects are identified for this affected object',
  `isreference` tinyint(4) DEFAULT NULL COMMENT 'Boolean value that describes whether it is reference or not ',
  `clientid` varchar(50) DEFAULT NULL COMMENT 'Defines which client has triggered this from API',
  PRIMARY KEY (`affectedobjectid`)	
) AUTO_INCREMENT=1000 COMMENT 'This is to save given affected objects info from API for impact analysis';


CREATE TABLE `custombuiltimpactedobjectsapi` (
  `impactedobjectid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'This is an unique identifier for each record',
  `impactanalysisid` int(11) NOT NULL COMMENT 'To link with impactanalysis table',
  `affectedobjectid` int(11) DEFAULT NULL COMMENT 'To link with custombuiltaffectedobjectsapi table',
  `connectionname` varchar(100) DEFAULT NULL COMMENT 'Defines destination connection name',
  `objectname` varchar(256) DEFAULT NULL COMMENT 'Defines destination object name',
  `fieldname` varchar(256) DEFAULT NULL COMMENT 'Defines destination column name',
  `datasetid` int(11) DEFAULT NULL COMMENT 'Defines dataset id that causes lineage',
  `datasetname` varchar(256) DEFAULT NULL COMMENT 'Defines dataset name that causes lineage',
  `code` longtext COMMENT 'Code that causes lineage',
  `transformtype` varchar(50) DEFAULT NULL COMMENT 'Defines transformation type',
  `reviewedstatus` varchar(50) DEFAULT NULL COMMENT 'Defines reviewed status',
  `reviewedby` varchar(10000) DEFAULT NULL COMMENT 'Defines reviewed by which user',
  `revieweddate` timestamp NULL DEFAULT NULL COMMENT 'Defines reviewed date',
  `objecttype` varchar(50) DEFAULT NULL COMMENT 'Defines object type',
  `objectid` int(11) DEFAULT NULL COMMENT 'Defines respective object id',
  `fieldid` int(11) DEFAULT NULL COMMENT 'Defines respective column object id',
  `inproject` tinyint(2) DEFAULT NULL COMMENT 'To know whether this object is in project or not',
  `sourcesystem` varchar(100) DEFAULT NULL COMMENT 'Defines source schema details',
  `sourcefieldname` varchar(256) DEFAULT NULL COMMENT 'Defines source object name from lineage',
  `sourcefieldid` int(11) DEFAULT NULL COMMENT 'Defines source column object id from lineage',
  `sourceobjectid` int(11) DEFAULT NULL COMMENT 'Defines source object id from lineage',
  `sourceobjectname` varchar(256) DEFAULT NULL COMMENT 'Defines source object name from lineage',
  `sourceobjecttype` varchar(50) DEFAULT NULL COMMENT 'Defines source object type from lineage',
  `impacttype` varchar(50) DEFAULT NULL COMMENT 'Always transformation as lineage is source for impact analysis',
  `trcode` mediumtext COMMENT 'Defines tranformation code',
  `sourcesystemid` int(11) DEFAULT NULL COMMENT 'Defines source schema id',
  `sourceconnectionname` varchar(255) DEFAULT NULL COMMENT 'Defines source connection name from lineage',
  `system` varchar(255) DEFAULT NULL COMMENT 'Defines destination target schema',
  `systemid` int(11) DEFAULT NULL COMMENT 'Defines destination target id',
  `objectactive` tinyint(4) DEFAULT '1' COMMENT 'Defines whether the object is active or inactive',
  `fieldactive` tinyint(4) DEFAULT '1' COMMENT 'Defines whether the column object is active or inactive',
  `datasetconnectionname` varchar(100) DEFAULT NULL COMMENT 'Defines dataset connection name',
  `datasetjobtype` varchar(255) DEFAULT NULL COMMENT 'Defines job type from dataset',
  `impactlevel` int(11) DEFAULT NULL COMMENT 'Defines impact level to which the process is done',
  `streamtype` VARCHAR(50) default null COMMENT 'Defines whether upstream or downstream',
  datasetsystemname varchar(100),
  PRIMARY KEY (`impactedobjectid`),
  KEY `impobj_index` (`impactanalysisid`,`affectedobjectid`,`objectid`,`objecttype`,`impacttype`,`datasetid`),
  KEY `impobj_index1` (`impactanalysisid`,`affectedobjectid`,`objectid`,`objecttype`,`impacttype`,`fieldid`,`datasetid`)
) AUTO_INCREMENT=1000 COMMENT 'This is to save identified impacted objects info for the custom Api requests';

CREATE TABLE `governpolicyobjects` (
  `governpolicyobjectid` int(11) NOT NULL AUTO_INCREMENT,
  `governpolicyid` int(11) DEFAULT 0 COMMENT 'it stores governpolicyid if auto certification, 0 for manual certification',
  `objectid` int(11) NOT NULL COMMENT 'it stores the objectids (tableid, fileid..etc)',
  `objecttype` varchar(50) NOT NULL COMMENT 'it stores the objectids (oetable, oefile..etc)',
  `certifieddate` timestamp NULL DEFAULT NULL COMMENT 'it stores certification date',
  `certifiedby` varchar(50) DEFAULT NULL COMMENT 'it stores the user who certify the object',
  `certifiedtype` varchar(20) DEFAULT NULL COMMENT 'it stores the certification type (Certify, Violation..etc)',
  PRIMARY KEY (`governpolicyobjectid`),
  UNIQUE KEY `ukey_id_type` (`objectid`,`objecttype`),
  KEY `objectid` (`objectid`),
  KEY `objecttype` (`objecttype`)
) ENGINE=InnoDB AUTO_INCREMENT = 1000 COMMENT 'This table stores associated objects of governpolicies. either manual or auto certification objects';

create table dqfileparams(
dqfileparamsid INT(11) NOT NULL AUTO_INCREMENT,
dqruleid INT(11) NOT NULL,
dqruleobjectid int(11),
param1 varchar(1000),
param2 varchar(1000),
param3 varchar(1000),
param4 varchar(1000),
param5 varchar(1000),
wherecol1 int(11),
wherecolval1 varchar(1000),
wherepredicate1 varchar(1000),
wherecol2 int(11),
wherecolval2  varchar(1000),
wherepredicate2  varchar(1000),
norows int(11),
rootpath varchar(1000),
createby varchar(50) DEFAULT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  lastmoddate timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  updateby varchar(50) DEFAULT NULL,
  PRIMARY KEY (dqfileparamsid )
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE affectedextrainfo (
  affectedimpacttype varchar(50) DEFAULT NULL COMMENT 'Column to store affected impact type',
  impactnotes varchar(1000) DEFAULT NULL COMMENT 'Column to store impact notes',
  replacementnotes varchar(1000) NOT NULL COMMENT 'Column to store replacement notes',
  replacementtable varchar(256) DEFAULT NULL COMMENT'Column to store replacement table',
  replacementcolumn varchar(256) DEFAULT NULL COMMENT 'Column to store replacement column',
  `affectedobjectid` int(11) NOT NULL COMMENT 'Column to store affected object id of affected object table'
)  COMMENT 'Table to store affected objects extra information';

CREATE TABLE compareschemadata (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  oecolumnid bigint(20) DEFAULT NULL,
  oetableid bigint(20) DEFAULT NULL,
  oeschemaid bigint(20) DEFAULT NULL,
  tablename varchar(256) DEFAULT NULL,
  columnname varchar(256) DEFAULT NULL,
  columnposition int(11) DEFAULT NULL,
  oecolumntype varchar(256) DEFAULT NULL,
  columnlength double DEFAULT NULL,
  lastmetasyncdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  isarchive tinyint DEFAULT false,
  PRIMARY KEY (id),
  KEY id1 (oeschemaid),
  KEY id2 (lastmetasyncdate),
  KEY id3 (columnname),
  KEY id4 (columnposition),
  KEY id5 (oecolumntype),
  KEY id6 (columnlength),
  KEY id7 (tablename),
  KEY id8 (oetableid),
  KEY id9 (oecolumnid)
);

CREATE TABLE `ticketparams` (
  `ticketparamid` int(11) NOT NULL AUTO_INCREMENT,
  `ticketid` int(11) NOT NULL,
  `objectid` int(11) DEFAULT NULL,
  `objecttype` VARCHAR(50) DEFAULT null,
  `objectname` VARCHAR(50) DEFAULT null,
  PRIMARY KEY (`ticketparamid`)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE lineagecolumnreference (
	id INT(11) NOT NULL AUTO_INCREMENT,
    sourceobjectid INT(11) NOT NULL COMMENT 'this is for sourcecolumn objectid',
    sourceobjecttype varchar(50) DEFAULT NULL COMMENT 'this is for sourcecolumn objecttype',
    targetobjectid INT(11) NOT NULL COMMENT 'this is for targetcolumn objectid',
    targetobjecttype varchar(50) DEFAULT NULL COMMENT 'this is for targetcolumn objecttype',
    createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'this is for current timestamp',
    createdby varchar(50) DEFAULT NULL COMMENT 'this is for created user info',
    lineagecolumnid INT(11) NOT NULL COMMENT 'this is for lineagecolumninfo refernce',
    PRIMARY KEY(id)
) ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE `a_sourcecode` (
  `sourcecodeid` int(11) NOT NULL COMMENT 'Source code table is used for storing xml or other files and data which is related to lineage building information',
  `connectioninfoid` int(11) NOT NULL,
  `objecttype` varchar(64) NOT NULL,
  `objectid` int(11) NOT NULL,
  `type` varchar(16) NOT NULL,
  `code` longtext NOT NULL,
  `lastupdatedate` datetime DEFAULT NULL,
  `createddate` datetime NOT NULL,
  `createdby` varchar(64) NOT NULL,
  `lineagebuilt` tinyint(4) DEFAULT '0',
  `sourcecodename` varchar(256) DEFAULT NULL,
  `lineagestatus` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `errormessage` mediumtext,
  `lastlineagerundate` datetime DEFAULT NULL COMMENT 'This column is to store lastlineagerundate of lineage (ETL and Reports)',
  `version` int(11) NOT NULL DEFAULT 1,
  islineagefit tinyint(1) not null default 1 COMMENT "Is sourcecode eligible for lineage build process"
) ENGINE=InnoDB;

CREATE TABLE qlikstakeholdersdata (
    applicationname VARCHAR(255) COMMENT 'This contains chartname of qlikview/qliksense',
    stakeholderrole varchar(255) COMMENT 'This represents custom text fields (Access Approver-tcf1,Qlik Developer-tcf2,ETL Developer-tcf3)',
    stakeholder varchar(255) COMMENT 'This represents the values of the stakeholerrole(custom text fields) fields',
    isprocessedflag int not null default 0 COMMENT 'This flag gets updated to 1 after the stakeholerrole(custom text fields) fields get updated' not null default 0
    ) ENGINE=InnoDB;
    
CREATE TABLE `dashboardstats` (
  `dashboardstatsid` int(11) NOT NULL AUTO_INCREMENT,
  `reporttype` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the reporttype of a Report',
  `xparam1` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the xparam1 of a Report',
  `xparam2` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the xparam2 of a Report',
  `xparam3` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the xparam3 of a Report',
  `xparam4` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the xparam4 of a Report',
  `xparam5` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the xparam5 of a Report',
  `yparam1` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the yparam1 of a Report',
  `yparam2` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the yparam2 of a Report',
  `yparam3` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the yparam3 of a Report',
  `yparam4` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the yparam4 of a Report',
  `yparam5` varchar(100)  DEFAULT NULL COMMENT 'This is used to get the yparam5 of a Report',
  `createdby` varchar(50) DEFAULT NULL COMMENT 'This is used to get the username of a Report',
  `createdate` timestamp NULL DEFAULT NULL COMMENT 'This is used to get created time of a Report',
  `updatedby` varchar(50) DEFAULT NULL COMMENT 'This is used to get the username of a Report',
  `lastmoddate` timestamp NULL DEFAULT NULL COMMENT 'This is used to get last updated time of a Report',
  PRIMARY KEY (`dashboardstatsid`)
) ENGINE=InnoDB AUTO_INCREMENT = 1000;

create table faileddqdata(
  id int(11) NOT NULL AUTO_INCREMENT,
  connectioninfoid int(11) DEFAULT NULL,
  oeschemaid int(11) DEFAULT NULL,
  oetableid int(11) DEFAULT NULL,
  oecolumnid int(11) DEFAULT NULL,
  columnpkname varchar(256) DEFAULT NULL,
  columnpkvalue varchar(256) DEFAULT NULL,
  description text,
  createdate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  updatedate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  impactedtype varchar(250) DEFAULT NULL,
  status varchar(20) DEFAULT NULL,
  PRIMARY KEY (id)
  )ENGINE = INNODB AUTO_INCREMENT = 1000 COMMENT 'This is faileddqdata table used to insert remote data where condition is failed.';
  
  CREATE TABLE log4jlogs (
  dt timestamp NULL,
  level varchar(10) NOT NULL,
  file varchar(200) DEFAULT NULL,
  line varchar(5) DEFAULT NULL,
  sessionid varchar(200) DEFAULT NULL,
  msg  varchar(5000) DEFAULT NULL
) ENGINE=InnoDB;

CREATE TABLE `a_comment` (
  `commentid` int(11) DEFAULT NULL COMMENT 'this column meant for maintaining the index.',
  `userid` varchar(50) NOT NULL COMMENT 'refers the users',
  `comment` mediumtext COMMENT 'contains the comment messages',
  `lastmoddate` timestamp NOT NULL COMMENT 'holds the last commented time',
  `parentcommentid` int(11) DEFAULT NULL COMMENT 'initial comments it will always be 0 for replies it holds > 0',
  `numberofreply` int(11) DEFAULT NULL COMMENT 'shows the count of no.of replies for a comment',
  `commenttype` varchar(20) DEFAULT NULL COMMENT 'can be collaboration,alerts,watchlist,servicedesk,dqr',
  `objecttype` varchar(20) DEFAULT NULL COMMENT 'can be schema,table,file,report',
  `objectid` int(11) DEFAULT NULL COMMENT 'refers the foreign objectid(schema,table,file,report)',
  `createddate` timestamp NULL DEFAULT NULL COMMENT 'holds the time of the comments'
) ENGINE=InnoDB COMMENT 'a_comment used to restore/backup for the comment table';

CREATE TABLE `a_message` (
  `MESSAGEID` int(11) DEFAULT NULL COMMENT 'this column meant for maintaining the index.',
  `HASHTAGORUSERID` varchar(50) DEFAULT NULL COMMENT 'refers the users who commented/hashtagged',
  `COMMENTID` varchar(50) DEFAULT NULL COMMENT 'foreign key of comment table',
  `ISREAD` tinyint(1) DEFAULT '0' COMMENT 'a notification flag if comment read 1 else 0',
  `NEEDANSWER` tinyint(1) DEFAULT '0' COMMENT 'a flag (0 or 1) for the hashtagged user to be answerd',
  `LASTMODDATE` timestamp NOT NULL COMMENT 'holds the last commented time',
  `markasdone` tinyint(1) DEFAULT '0' COMMENT 'a flag if read then 1 else 0'
) ENGINE=InnoDB COMMENT 'a_message used to restore/backup for the message table';

CREATE TABLE `a_ticket` (
  `ticketid` int(11) NOT NULL,
  `description` text,
  `status` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `objecttype` varchar(50) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL,
  `objectid` int(11) DEFAULT NULL,
  `definition` MEDIUMTEXT,
  `expirationdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `permtype` varchar(20) DEFAULT NULL,
  `nextapprover` varchar(50) DEFAULT NULL,
  `comments` mediumtext,
  `createdby` varchar(50) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedby` varchar(50) DEFAULT NULL,
  `businessdesc` text,
  `assobjectid` int(11) DEFAULT NULL,
  `assetname` varchar(255) DEFAULT NULL,
  `urlcontext` varchar(500) DEFAULT NULL,
  `requestpriority` varchar(50) NOT NULL,
  `priority` varchar(50) NOT NULL,
  `potentialamount` int(11) DEFAULT NULL
) ENGINE=InnoDB COMMENT 'a_ticket used to restore/backup for the ticket table';

CREATE TABLE `a_alert` (
  `alertid` int(11) NOT NULL,
  `alertname` varchar(255) DEFAULT NULL,
  `datasetid` int(11) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `helptext` varchar(255) DEFAULT NULL,
  `createdby` varchar(255) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`alertid`)
) ENGINE=InnoDB COMMENT 'a_alert used to restore/backup for the alert table';

CREATE TABLE `a_backlink` (
  `backlinkid` int(11) NOT NULL,
  `mainobject` varchar(50) DEFAULT NULL,
  `mainobjectid` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `associatedobject` varchar(50) DEFAULT NULL,
  `associatedobjectid` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `createdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`backlinkid`),
  KEY `mainobject` (`mainobject`,`mainobjectid`),
  KEY `associatedobject` (`associatedobject`,`associatedobjectid`)
) ENGINE=InnoDB COMMENT 'a_backlink used to restore/backup for the backlink table';

CREATE TABLE a_queryuserstats ( 
  queryuserstatsid int(11) NOT NULL,
  datasetid int(11) DEFAULT NULL,
  userid varchar(50) DEFAULT NULL,
  queryuserscore int(11) DEFAULT NULL,
  numberlooked int(11) DEFAULT NULL,
  numbercommented int(11) DEFAULT NULL,
  numberqueried int(11)
) ENGINE=InnoDB COMMENT 'a_queryuserstats used to restore/backup for the queryuserstats table';

CREATE TABLE a_datasetcorrection ( 
  datasetcorrectionid int(11) NOT NULL,
  datasetid int(11) NOT NULL,
  corrected_query longtext,
  status varchar(12) DEFAULT NULL
) ENGINE=InnoDB COMMENT 'a_datasetcorrection used to restore/backup for the datasetcorrection table';

CREATE TABLE a_datasetresults ( 
  jobstepid INT(11) NOT NULL,
  results longblob,
  datasetid INT(11) NOT NULL,
  createdate timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB COMMENT 'a_datasetresults used to restore/backup for the datasetresults table';

create table a_datasetorigquery(
datasetorigqueryid INT(11) NOT NULL ,
datasetid INT(11) NOT NULL,
origquery mediumtext
) ENGINE=InnoDB COMMENT 'a_datasetorigquery used to restore/backup for the datasetorigquery table';

CREATE TABLE `a_ticketaccess` (
  `ticketaccessid` int(11) NOT NULL,
  `ticketid` int(11) NOT NULL,
  `assobject` int(11) DEFAULT '0',
  `userid` varchar(50) DEFAULT NULL,
  `inqueue` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB COMMENT 'a_ticketaccess used to restore/backup for the ticketaccess table';

CREATE TABLE `a_ticketworkflow` (
  `ticketworkflowid` int(11) NOT NULL,
  `ticketid` int(11) DEFAULT NULL,
  `workflowtype` varchar(50) NOT NULL,
  `assobject` int(11) DEFAULT '0',
  `userid` varchar(50) DEFAULT NULL,
  `approver` varchar(50) DEFAULT NULL,
  `floworder` int(11) NOT NULL,
  `isapproved` tinyint(1) DEFAULT '0',
  `comments` longtext,
  `createby` varchar(50) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lastmoddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updateby` varchar(50) DEFAULT NULL,
  `businessglossaryid` int(11) DEFAULT NULL
) ENGINE=InnoDB COMMENT 'a_ticketworkflow used to restore/backup for the ticketworkflow table';

CREATE TABLE `stg_dqrule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domainname` varchar(100) DEFAULT NULL,
  `rulename` varchar(100) DEFAULT NULL,
  `termname` varchar(100) DEFAULT NULL,
  `purpose` mediumtext,
  `status` varchar(20) DEFAULT NULL,
  `alerts` tinyint(4) DEFAULT NULL,
  `ticket` tinyint(4) DEFAULT NULL,
  `autoterm` tinyint(1) DEFAULT NULL,
  `cronentry` varchar(50) DEFAULT NULL,
  `tagname` varchar(100) DEFAULT NULL,
  `objecttype` varchar(100) DEFAULT NULL,
  `functionname` varchar(100) DEFAULT NULL,
  `lowerrange` bigint(20) DEFAULT NULL,
  `upperrange` bigint(20) DEFAULT NULL,
  `valuesname` mediumtext,
  `connectionname` varchar(100) DEFAULT NULL,
  `schemaname` varchar(100) DEFAULT NULL,
  `tablename` varchar(100) DEFAULT NULL,
  `columnname` varchar(100) DEFAULT NULL,
  `queryname` varchar(256) DEFAULT NULL,
  `statsqueryname` varchar(256) DEFAULT NULL,
  `valuesqueryname` varchar(256) DEFAULT NULL,
  `filename` varchar(256) DEFAULT NULL,
  `filecolumnname` varchar(100) DEFAULT NULL,
  `createdate` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `processed_flag` tinyint(4) DEFAULT '0',
  `error_msg` varchar(200) DEFAULT NULL,
  `batchno` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1041 COMMENT 'stg_dqrule used to store the dqrule csv file values through metadata';

CREATE TABLE `a_wikides` (
  `wikiid` int(10) NOT NULL,
  `wikiobject` varchar(20) DEFAULT NULL,
  `wikiobjectid` int(10) DEFAULT NULL,
  `wikitext` mediumtext,
  `version` int(11) DEFAULT NULL,
  `lastupdatetime` datetime DEFAULT NULL,
  `lastupdateuser` varchar(100) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `wikitextplain` mediumtext  COMMENT 'This column is to store plainText of Business/Technical Description in archive',
  KEY `wiki_idx` (`wikiobjectid`,`wikiobject`,`wikitext`(100))
)ENGINE=InnoDB AUTO_INCREMENT=1000;

CREATE TABLE govern_matrix_model(
 id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 model VARCHAR(50) NOT NULL,
 description VARCHAR(255) DEFAULT NULL
) ENGINE = InnoDB COMMENT = 'Enumeration of govern matrix model, ex: RACI, RASCI, RACIO, etc.';

CREATE TABLE govern_matrix_model_role(
 id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 rolename varchar(100) DEFAULT NULL,
 role VARCHAR(50) NOT NULL,
 description VARCHAR(255) DEFAULT NULL,
 type VARCHAR(50) DEFAULT NULL,
 multiselect TINYINT(1) DEFAULT NULL
) ENGINE = InnoDB COMMENT = 'Enumeration of govern matrix model role, ex: Responsible, Accountable, Support, etc.';

CREATE TABLE govern_matrix_type_model_map(
 object_type VARCHAR(50) DEFAULT NULL,
 model_id INT(11) NOT NULL
) ENGINE = InnoDB COMMENT = 'Mapping of type, govern matrix model';

CREATE TABLE govern_matrix_type_model_role_map(
 object_type VARCHAR(50) DEFAULT NULL,
 model_id INT(11) NOT NULL,
 role_id INT(11) NOT NULL
) ENGINE = InnoDB COMMENT = 'Mapping of type, govern matrix model, and role';

CREATE TABLE govern_matrix(
 id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
 model_id INT(11) NOT NULL,
 role_id INT(11) NOT NULL,
 object_id INT(11) NOT NULL,
 object_type VARCHAR(50) DEFAULT NULL,
 assignee VARCHAR(50) NOT NULL
) ENGINE = InnoDB COMMENT = 'Defines model, role, and assignee';

CREATE TABLE stg_tableuserstats (
  id int(11) NOT NULL AUTO_INCREMENT,
  oetableid int(11) DEFAULT NULL,
  userid varchar(50) DEFAULT NULL,
  tableuserscore int(11) DEFAULT NULL,
  numberlooked int(11) DEFAULT NULL,
  numberqueried int(11) DEFAULT NULL,
  numbercommented int(11) DEFAULT NULL,
  processeddate DATE COMMENT 'Column to store the processed dates',
  PRIMARY KEY (id),
  UNIQUE KEY unique_index (oetableid,userid)
) ENGINE=InnoDB;

CREATE TABLE oeschemareference (
 oeschemaid int(11) NOT NULL COMMENT 'It is used for oeschemaid', 
 oetableids varchar(255) NOT NULL COMMENT 'It is used for oetableids list', 
 profiled boolean default false COMMENT 'It is used for knowing if tableids are profiled',
 createddate timestamp default current_timestamp COMMENT 'It stores created date', 
 updatedate timestamp default current_timestamp COMMENT 'It stores updated date'
) ENGINE = InnoDB COMMENT = 'Mapping of SAPTable list for profiling';

CREATE TABLE `connectorconfigs` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
    `connectioninfoid` int(11) NOT NULL,
    `parameterfilename` VARCHAR(255),
    `schemaname` varchar(255), 
    `objectname` text,
    `configkey` varchar(255),
    `configvalue` text,
    `createddate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_cc_cid_on` (`connectioninfoid`,`objectname`(50)),
    KEY `idx_cc_cid_sn_on` (`connectioninfoid`,`schemaname`,`objectname`(50))
)ENGINE = InnoDB;

create view oesecurehashtagmask as 
select oi.object_id_identity as hashtagid, usr.userid, max(entry.mask) as mask from acl_object_identity oi 
join acl_class class on (oi.object_id_class = class.id) join acl_entry entry on (entry.acl_object_identity = oi.id ) 
join acl_sid sid on (entry.sid = sid.id) join roles role on (sid.sid = role.authority) 
join user_role usr on (usr.roleid = role.roleid) WHERE class.class = 'com.ovaledge.oasis.domain.HashTag' GROUP BY hashtagid, userid;

create view projectview as 
select p.projectid, pc.assobject, pc.assobjectid, pu.userid from project p 
join projectcontent pc on (p.projectid = pc.projectid) 
join projectuser pu on (p.projectid = pu.projectid and pu.defaultproj = 1);

create view oetableownersteward as 
select dag.owner, dag.steward, ot.oetableid from oetable ot 
join dataassetgroup dag on ot.oeschemaid = dag.objectid and dag.objecttype = 'oeschema'
where ot.oetableid not in (select tt.oetableid from dataassetgroup dag join tabletag tt on tt.tagid = dag.tagid) union 
select owner, steward, tt.oetableid from dataassetgroup dag join tabletag tt on tt.tagid = dag.tagid;

create view oechartownersteward as 
select dag.owner, dag.steward, c.chartid from chart c 
join dataassetgroup dag on c.domainid = dag.objectid and dag.objecttype = 'oedomain'
where c.chartid not in (select ct.chartid from dataassetgroup dag join charttag ct on ct.tagid = dag.tagid) union 
select owner, steward, ct.chartid from dataassetgroup dag join charttag ct on ct.tagid = dag.tagid;

create view oefileownersteward as 
select dag.owner, dag.steward, f.fileid from file f 
join dataassetgroup dag on f.filefolderid = dag.objectid and dag.objecttype = 'filefolder'
where f.fileid not in (select ft.fileid from dataassetgroup dag join filetag ft on ft.tagid = dag.tagid) union 
select owner, steward, ft.fileid from dataassetgroup dag join filetag ft on ft.tagid = dag.tagid;

create view oequeryownersteward as 
select owner, steward, qt.datasetid from dataassetgroup dag join querytag qt on qt.tagid = dag.tagid;


INSERT INTO action (actionname, actiondescription) VALUES ('DOWNLOAD_FILE_ACTION', 'Allow User to download file');


INSERT INTO advancejob (ajname, ajtype, classname, help, attr1, attr2, attr3, attr4, attr5) VALUES 
('Discover Relationships', 'DISCOVER_RELATIONS', 'com.ovaledge.oasis.advance.DiscoverRelationships', 'This job discover relationships. Attr0: 0 means MR. Attr2 means Type, 0 means Schema, 1 means Hive Data lake. Att3 means either schemaid or connection id based on the attr2 description.',NULL,NULL,NULL,NULL,NULL);
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1, attr2, attr3, attr4, attr5) VALUES 
('Process Importance Score', 'PROCESS_IMP_SCORE', 'com.ovaledge.oasis.advance.ProcessImpScore', 'This job would process the importance score of a table and its columns. The calculation performed during the profiling of a database. ATTR1. (Mandatory) is the schemaid, Use ATTR2 is tableid, when you want to process the score for a specific table.',NULL,NULL,NULL,NULL,NULL);
insert into advancejob (ajname, ajtype, classname, help, attr1, attr2, attr3, attr4, attr5) values 
('Reset Encryption-Decryption', 'ENCRYPTDECRYPTRESET', 'com.ovaledge.oasis.advance.EncryptDecryptResetService', 'This job will reset the fields with new OVALEDGE_ENCRYPT_DECRYPT_KEY. Attr1 : Pass old Encrypt-Decrypt Key', NULL, NULL, NULL, NULL, NULL);
insert into advancejob(ajname, ajtype, classname, help, attr1label, attr2label, attr3label) values 
('Discover Primary and Foreign key recommendations auto', 'DISCOVER_RELATIONSHIP','com.ovaledge.oasis.advance.DiscoverPKFKRelationshipsAI', 'This job will discover all the primary and foreign keys automatically. If you want to run the algorithm only in a certain schema, then type the schemaids seperated by comma in attr1', 'Crawler ID / Database Name', 'Schema ID / Name (Provide comma(,) seperation for multiple schemas)','Build relationships across schemas(true/false)');
INSERT INTO advancejob(ajname, ajtype, classname, help) VALUES 
('Load oereportext table for reporting framework', 'LOADOEREPORTEXT', 'com.ovaledge.oasis.advance.LoadReportingSQL',
'This job will load sqls from Staging table to oereportext table');
INSERT INTO advancejob(ajname, ajtype, classname, help,attr1, attr2, attr1label,attr2label, attr3label, attr4label, attr5label) 
VALUES ('Load Users Into Ovaledge', 'LOADUSERSTOOE', 'com.ovaledge.oasis.advance.LoadOEUsers', 'This job loads users from an external CSV file, takes nfs connectioninfoid as attr1 and filename as attr2', '\\', '', 'FileName with extension', 'Common Role', '', '', '');
insert into advancejob(ajname, ajtype, classname, help, attr1, attr2, attr1label, attr2label) 
values ('Creation and Deletion of Orphan ACLs', 'CREATE_DELETE_ORPHAN_ACL', 'com.ovaledge.oasis.advance.DeleteCreateACL', 'This job is used for Creation and Deletion of ACLs for Orphan Objects, attr1 is true if you want to Delete Orphan ACLs and false if you Donot want to Delete and attr2 is true if you want to Create ACLs for Orphan Objects and false if you Donot want to Create', 'false if you donot want to delete orphan ACLs', 'false if you donot want to create ACLs for orphan objects', 'False If You Donot Want To Delete Orphan ACLs', 'False If You Donot Want To Create ACLs for Orphan Objects');
insert into advancejob(ajname,ajtype,classname,help,attr1,attr2,attr3,attr4,attr5,attr1label,attr2label,attr3label,attr4label,attr5label)
values("Build BusinessGlossary for table column","Build BusinessGlossary","com.ovaledge.oasis.advance.BuildBusinessGlossaryAuto","This job would create BusinessGlossary for table column","Put domain name","number of terms you want ","Optional schema name if want to create in specific schema","Optional connection name if want to create in specific connection",NULL,"Domain name","No of term","Schema name","Connection name",NULL);
INSERT INTO `advancejob` ( `ajname`, `ajtype`, `classname`, `help`, `attr1`, `attr2`, `attr3`, `attr4`, 
`attr5`, `attr1label`, `attr2label`, `attr3label`, `attr4label`, `attr5label`) VALUES 
('Discover relationships automatically', 'DISCOVER_RELATIONSHIP', 'com.ovaledge.oasis.advance.DiscoverRelationshipsAI', 
'This job will discover various relations automatically. If you want to run the algorithm only in a certain schema, then type the schemaids seperated by comma in attr1', '', '', '', '', '', 'Crawler ID / Database Name', 'Schema ID / Name (Provide comma(,) seperation for multiple schemas)','Build relationships across schemas(true/false)', 'Attr4', 'Attr5');
INSERT INTO `advancejob` ( `ajname`, `ajtype`, `classname`, `help`, `attr1`, `attr2`, `attr3`, `attr4`, `attr5`, 
`attr1label`, `attr2label`, `attr3label`, `attr4label`, `attr5label`) VALUES ('Calculate relationships strength', 
'CALCULATE_RELATIONSHIP', 'com.ovaledge.oasis.advance.CalculateRelationships', 
'This job will calculate the strength of all relationships. If you want to run the algorithm only in a specific schema, then type the schema id separated by a comma in attr1', '', '', '', '', '', 'Schema Ids', 'Attr2', 'Attr3', 'Attr4', 'Attr5');
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1, attr2, attr3, attr4, attr5, attr1label, attr2label, attr3label, attr4label, attr5label) VALUES 
('LDAP Connection Validate Service', 'LDAPConnectionValidateService', 'com.ovaledge.oasis.advance.LDAPConnectionValidateService', 
'LDAP Connection Validate Service', 'ldaps://ldap.jumpcloud.com:636', 
'dc=jumpcloud,dc=com||ou=Users,o=abc1234,dc=jumpcloud,dc=com||ou=Users,o=abc1234,dc=jumpcloud,dc=com||PREFIX', 
'uid=ldapuser,ou=Users,o=abc1234,dc=jumpcloud,dc=com||admin', 
'(&(objectClass=inetOrgPerson)(uid={0}))||(&(objectClass=groupOfNames)(member={0}))||(&(objectClass=inetOrgPerson)(uid={0}))', 
'admin||admin', 'LDAP Url', 'RootDN||UserSearchBase||GroupSearchBase||CustomPrefix', 'ManagerDn||ManagerPassword', 
'UserSearchFilter||GroupSearchFilter||GroupRoleAttribute', 'UserName||Password');
insert into advancejob(ajname,ajtype,classname,help,attr1label,attr2label,attr3label,attr4label,attr5label) values 
("Get Relationships with Column Names","DISCOVER_RELATIONS","com.ovaledge.oasis.advance.DiscoverColumnNameRelationshipAI",
"This job discovers relationships considering column names matching, provide either crawler id/ database name and schema id/name as input, Recalculate Scores(true/false): if false, it calculates scores for not yet calculated relations",
"Crawler ID / Database Name", "Schema ID / Name (Provide comma(,) seperation for multiple schemas)","Calculate Scores(true/false)","Column Name","Table Name (To build relationships only for a particular table columns)");
insert into advancejob(ajname,ajtype,classname,help,attr1label,attr2label,attr3label)values("Project Level Relationships Building","PROJECTLEVEL_RELATIONSHIPS","com.ovaledge.oasis.advance.ProjectLevelRelationshipsBuild",
"This job builds project level relationships", "Project Name", NULL,NULL);
INSERT INTO advancejob(ajname,ajtype,classname,HELP) VALUES('Build DashboardStats', 'BUILD_DASHBOARD_STATS','com.ovaledge.oasis.advance.BuildDashboardStatsService' ,
'This job will populate Dashboard Statistics');
insert into advancejob(ajname,ajtype,classname,help)values("Create Security ACL Entries","Create ACL Entries For All Objects","com.ovaledge.oasis.advance.CreateSecurityTables","This job will create security ACL entries at all object levels");
insert into advancejob(ajname,ajtype,classname,help,attr1label,attr2label,attr3label,attr4label,attr5label)
values("Load Affected Objects For Table Columns","LoadAffectedColumns","com.ovaledge.oasis.advance.LoadAffectedObjects",
"This job helps in loading affected objects at column level at downstream which are included in the csv file", 
"Filepath(with extension)", "Impact Analysis Name","| Impact type (DR or UR or U or D)", " Impact Analysis Name", "");
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1label, attr1, attr2label, attr2, attr3label, attr3, attr4label, attr4, attr5label, attr5) 
VALUES ('Build Terms', 'AI_TERM_BUILD_SERVICE','com.ovaledge.oasis.advance.TermBuilderAIService','This job will generate Business glossarys using Lineage and Object Name', 
'Recommendation Type(Name/Lineage)?', 'name','Domain Name', '','Category1|Category2', '','Count(Number of Terms to Recommend Using Names/Minimum number of objects to Build a Term using Lineage)', '5','Attr5', '');
INSERT INTO advancejob(ajname, ajtype, classname, help)VALUES ('Process CouchDb Lineage', 'PROCESS_COUCHDB_LINEAGE', 'com.ovaledge.oasis.advance.CouchDbAdvanceJob', 'This job will build lineage for couchdb it takes one input attr, pass couchdb connectionid in attr1');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label)VALUES ("SAPBO Labels", "Sapbo labels", "com.ovaledge.oasis.advance.SAPBOlabelsjob",
"This Advance job is to create business glossary from SAP BO labels from all the reports","SAPBO connectionid");
INSERT into advancejob(ajname, ajtype, classname, attr1label, attr2label, attr3label, attr4label, attr5label, help) VALUES 
('Recommend Term to newly Added Columns', 'AI_TERM_RECOMMEND_SERVICE', 'com.ovaledge.oasis.advance.TermRecommendationAIService', 
'Global Domain Name', 'Category Name', 'SubCategory Name', 'Last Run time(ex: 2020-12-28 16:30:00)',
'Alert Threshold Score(Min score to alert Stewards of Business Glossary/Column, must be greater than AI Match Score(Configuration))',
'This job will recommend Business Glossary to newly added Columns after a certain Date');
insert into advancejob(ajname,ajtype,classname,help)values("Assign Default Role at all Object level","ASSIGNDEFAULTROLES","com.ovaledge.oasis.advance.ApplyDefaultRolesToAllObject","This job assigns default role to all the objects");
INSERT INTO advancejob (ajname, ajtype, classname, attr1label, help) VALUES('Validate Available Crawled Connections', 'VALIDATECRWALEDCONNECTION', 
'com.ovaledge.oasis.advance.ValidateCrawledConnections', 'Roles', 
'This job validates available crawled connections. Add Roles with coma seperated if multiple roles for which users need to be notified for Failed Connections.');
insert into advancejob (ajname, ajtype, classname, help, attr1label, attr1, attr2label, attr2) values 
('Advance Job for updating editor from md to froala', 'MdEditorMigration', 
'com.ovaledge.oasis.advance.MdEditorMigration', 
'This job is for updating editor from md to froala.', 'Schema Id', '', 'Table Id', '');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label, attr2label, attr3label, attr4label, attr5label) VALUES 
('Load File Columns', 'LoadFileColumns', 'com.ovaledge.oasis.advance.LoadFileColumns', 
'This job would help in loading the file, file columns and its definitions.', 'Filepath(with extension)', '', '', '', '');
INSERT into advancejob(ajname, ajtype, classname, help) VALUES 
('Update WikiText to store Plain Text','UPDATE_PLAIN_WIKITEXT','com.ovaledge.oasis.advance.UpdateWikiTextPlainData', 
'This job will Update WikiText to store Plain Text');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label,attr2label) VALUES 
('Load Dataid Details', 'LoadDataIdDetails', 'com.ovaledge.oasis.advance.LoadDataIdDetails', 
'This job would help generating and downloading csv with dataid,objectname and objecttype', 'nfs connectioninfo id', 'File name with extension');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label, attr2label) VALUES 
('Load Dataset SourceCode Names', 'LoadDatasetSourceCodeNames', 'com.ovaledge.oasis.advance.LoadDatasetSourceCodeNames', 
'This job would help in loading the dataset & source code details from csv file', 'Only File name without extension', 'Attr2');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label) VALUES 
('Archive Logs Data', 'ArchiveLogs', 'com.ovaledge.oasis.advance.ArchiveLogs', 
'This job would help in taking backup of logs into files and free up the memory from log table', 'Provide how many days logs which should not be archived');
INSERT into advancejob(ajname, ajtype, classname, help) VALUES 
('Update User License Type','PROCESS_USER_LICENSE','com.ovaledge.oasis.advance.AssignUserLicense', 
'This job will update the User License Type based on current Permissions');
insert into advancejob (ajname, ajtype, classname, help, attr1label) values 
('Advance Job for Indexing Existing Data into ElasticSearch', 'ESDataMigration', 
'com.ovaledge.oasis.advance.ESDataMigration', 
'This job will Sync ElasticSearch with Existing Data from DB, Runs on given Object Types, else on all Object Types.','Comma separated Object Types(oetable,oecolumn, etc.,)');
INSERT INTO advancejob(ajname, ajtype, classname, help) VALUES 
('Load DataQuality Function', 'LOAD_DATAQUALITY_FUNCTION', 
'com.ovaledge.oasis.advance.LoadDataQualityFunctionsSql', 
'This job will build sqls for the Function');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES ( 'Impact Analysis for Spark1', 'IMPACT_ANALYSIS_SPARK1', 'com.ovaledge.oasis.advance.ImpactAnalysisForSpark1', 'Shows all the files/tables involved in given YAML File, Attribute1: Name of the YAML File, Attribute2 : Folder Path','YAML File Name','YAML File Folder Path');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES ( 'Impact Analysis for Spark2', 'IMPACT_ANALYSIS_SPARK2', 'com.ovaledge.oasis.advance.ImpactAnalysisForSpark2', 'Shows all the files/tables involved in given YAML File, Attribute1: Name of the YAML File, Attribute2 : Folder Path','YAML File Name','YAML File Folder Path');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label, attr3label, attr4label, attr5label)
VALUES  ('Impact Analysis for a given Table or File', 'IMPACT_ANALYSIS_TABLE_FILE', 'com.ovaledge.oasis.advance.ImpactAnalysisForAGivenTableOrFile', 'Shows all the real files/tables and involved scripts, Attribute1: Name of the Table/File, Attribute2: Table Schema/File Location, Attribute3: Of type Table/File, Attribute4: ConnectionId, Attribute5: Output Folder Path', 'Name of the Table/File', 'Table Schema/File Location', 'Type(Table/File)', 'ConnectionId', 'Output Folder Path');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES  ('Impact Analysis for Bulk Tables or Files', 'IMPACT_ANALYSIS_BULK_TABLE_FILE', 'com.ovaledge.oasis.advance.ImpactAnalysisForBulkTablesOrFiles', 'Shows all the real files/tables and involved scripts, Attribute1: Input file path, Attribute2: Output Folder Path', 'Input file path', 'Output Folder Path');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES  ('Impact Analysis for Bulk Tables or Files(Real and Included in script)', 'IMPACT_ANALYSIS_BULK_TABLE_FILE_2', 'com.ovaledge.oasis.advance.ImpactAnalysisForBulkTablesOrFiles2', 'Shows all the real files/tables and involved scripts, Attribute1: Input file path, Attribute2: Output Folder Path', 'Input file path', 'Output Folder Path');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label)
VALUES  ('Catalogues real files from Hdfs', 'CATALOG_REAL_FILES', 'com.ovaledge.oasis.advance.CatalogRealFileFromHdfs', 'Catalogues real files from Hdfs, Attribute1: HDFS Connection Id', 'HDFS Connection Id');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES  ('Impact Analysis for Columns', 'IMPACT_ANALYSIS_COLUMNS', 'com.ovaledge.oasis.advance.ImpactAnalysisForColumns', 'Shows all the column impacted objects, Attribute1: Input file path, Attribute2: Output Folder Path', 'Input file path', 'Output Folder Path');
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label) VALUES 
('Build Lineage and Associate Term', 'BUILDLINEAGEANDASSOCIATETERM', 
'com.ovaledge.oasis.advance.AssosciateTermLineage', 
'This job Build Lineage and Associate Term.', 'ConnectionId(NFS Connection ID)', 'FileName with extension(file.xlsx)', 'DomainName', 'Crawled path for files specified in the template');
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1, attr2) VALUES 
('Process Lineage Validation', 'PROCESS_LINEAGE_VALIDATION', 
'com.ovaledge.oasis.advance.LineageValidationAdvanceJob', 
'This will validate Lineage for a given connections, jobtypes', 'comma sep list of connectionids', 'comma sep list of job types');
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1, attr2) VALUES 
('Process Lineage Validation', 'PROCESS_LINEAGE_VALIDATION', 
'com.ovaledge.oasis.advance.LineageValidationAdvanceJob', 
'This will validate Lineage for a given connections, jobtypes', 'comma sep list of connectionids', 'comma sep list of job types');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES ('Process Source Code', 'PROCESS_SOURCE_CODE', 'com.ovaledge.oasis.advance.ProcessSourceCode', 'Generates a secured zip file with the dataset, schemas, tables and columns involved in a given source code id, Attribute1: Source Code Id, Attribute2: Password', 'Source Code Id', 'Password');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES  ('SSIS Validation', 'SSIS_VALIDATION', 'com.ovaledge.oasis.advance.SsisValidation',
'Validates SSIS Packages, give either connection id or query id, Attribute1: Connection Id, Attribute2: Query Id',
'Connection Id', 'Query Id');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label) VALUES 
('Archive oecolumntimeline to table/file', 'ARCHIVE_COLUMN_TIMELINE', 'com.ovaledge.oasis.advance.ArchiveColumnTimelineService', 
'This job would help in taking backup of oecolumntimeline into files and free up the memory from the table', 'Provide the number of days to retain');
INSERT into advancejob(ajname, ajtype, classname, help, attr1label, attr2label, attr3label) VALUES 
('Process File Data Quality Rules','PROCESS_FILE_DATA_QUALITY_RULES','com.ovaledge.oasis.advance.DQFleRuleProcessorJob', 
'Use this job to submit the File Data Quality Rules.  For running all active rules setup FILE_ID = -1', 'RuleId', 'Databricks Connection Id', 'Databricks Job Id');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label, attr2label, attr3label, attr4label) VALUES
('Email IA Results', 'EMAILIARESULTS', 'com.ovaledge.oasis.advance.EmailImpactAnalysis',
'This job would help in emailing the impacted objects of a specific impact analysis based on connection type.', 'impact analysis id', 'connection type', 'roles(whom to get alerted)', 'external emails');
insert into advancejob(ajname,ajtype,classname,help,attr1label,attr2label,attr3label, attr4label)
values("Export DQ Rule Results","EXPORTDQRESULTS","com.ovaledge.oasis.advance.EXPORTDQRULES","This job will write the results into an excel file and copy into your desired file connection",  "start time (yyyy-mm-dd 00:00:00)","end time (yyyy-mm-dd 00:00:00)", "connection where you need to copy the file", "path where do you need to copy the file");
insert into advancejob(ajname,ajtype,classname,help,attr1label,attr2label)
values("Import SQL DQRules","IMPORTSQLDQRULES","com.ovaledge.oasis.advance.ImportDQQueryRules","This job will create the dqrules and assosciate sqls to the corresponding rules", "nfs connection id", "file name with extesion");
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label)
VALUES  ('Report Validation', 'REPORT_VALIDATION', 'com.ovaledge.oasis.advance.ReportValidation',
         'Validates Reports, give either connection id or report id, Attribute1: Connection Id, Attribute2: Report Id',
         'Connection Id', 'Report Id');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label, attr3label)
VALUES  ('Delete Lineage', 'DELETE_LINEAGE', 'com.ovaledge.oasis.advance.DeleteLineage',
         'Deletes the lineage for a given connection',
         'Connection Id and Connection Name Separated by pipe(|) ',
         'Give values Dataset or SourceCode or both separated by comma(,) if you want those tables to be deleted',
         'Give one value either Delete or Archive');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label,attr2label,attr3label,attr4label,attr5label) VALUES 
('Load Dataset SourceCode Names By Connectors', 'LoadDatasetSourceCodeNamesByConnectors', 'com.ovaledge.oasis.advance.LoadDatasetSourceCodeNamesByConnectors', 
'This job would help in loading the dataset & source code details by bringing data based on SSIS,SAPBODS,SAPBO,qliksense,qlikview connectors from csv file', 'Only File name without extension','connection type','roles(whom to get alerted)','external emails','Attr5' );
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label,attr5label) VALUES('Load Domain and BG Terms and Associate to Columns', 'ASSOCIATETERMSTOCOLUMNS', 'com.ovaledge.oasis.advance.AssociateTermsToColumnsService', 'This job is to Load Domains, Data Classifications and Terms and Associat to Columns, .', 'Enter File Name with extension', 'Enter Schema Id(s) coma seperated', 'Enter the ParentTag Name(Optional)', 'Enter the Path to download the file', 'Enter True to reset whole data');
insert into advancejob (ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label) values 
('Recommend Term to Objects', 'AI_TERM_OBJECT_RECOMMEND_SERVICE',  'com.ovaledge.oasis.advance.TermObjectRecommendationAIService', 
'This job is to Recommend a Term to Objects(oetable, oecolumn, etc.,)', 'Filter Criteria', 
'Domain Id (mandatory if criteria is empty and business glossary is empty)', 'Business GlossaryId(mandatory if Criteria is empty and Domain Id is empty. Optional if domain id is provided)', 'Object Type(mandatory if Criteria is empty)');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label, attr2, attr2label) VALUES 
('Archive Comments & Messages', 'ArchiveJob', 'com.ovaledge.oasis.advance.ArchiveCommentsMessages', 
'This job would help in taking backup of comments & messages into files and free up the memory from comment & message table', 'Data Retention Days(Data will be archived/deleted prior to this)', 'SA,WA', 'Enter the Comment Type(SA,WA,CA,SRA,DQA) to be archived');
INSERT INTO advancejob(ajname, ajtype, classname, HELP, attr1label, attr2label, attr3label)
VALUES  ('Deactivate Tables with Zero Row Count', 'DEACTIVATE_TABLES', 'com.ovaledge.oasis.advance.DeactivateTables',
         'Deactivates tables with Zero Row Count, Attribute1: ConnectionIds (Comma separated if multiple),Attribute2: Row count,
         Attribute3: CSV file path','ConnectionIds (Comma separated if multiple)', 'Row count (default 0)', 'CSV file path');
INSERT INTO advancejob(ajname,ajtype,classname,help, attr1label,attr2label,attr3label)
values("Notify Admin on File server Changes","Notify Admin On File server Changes ","com.ovaledge.oasis.advance.NotifyFileSeverChanges","This job will alert admin user on remote file server changes", "connectionid", "root folder path","folder levels to be checked");
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label,attr2label, attr3label) VALUES 
('Load Qlik Stakeholder Data', 'LoadQlikStakeholderData', 'com.ovaledge.oasis.advance.LoadQlikStakeholderData', 
'This job would help loading csv file data in qlikstakeholdersdata table', 'nfs connectioninfo id', 'File name with extension', 'connectioninfoid');
insert into advancejob ( ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label) 
values('DiscoverPIIData', 'DiscoverPIIData', 'com.ovaledge.oasis.advance.DiscoverPIIData', 'This job is to Load failed DQ Data into OE',
'Enter the Schema Id', 'Enter tableName,columnName,pkColumnName coma seperated if more then seperate with |', 'Last processed date (For reference)',
'Enter lastNameTable,lastNameColumn coma seperated');
insert into advancejob ( ajname, ajtype, classname,	help, attr1label, attr2label, attr3label)
values( 'Associate Tags to existing Terms','ASSOCIATE_TAGS_TO_TERMS','com.ovaledge.oasis.advance.AssociateTagsToTermsService',
'This advancejob is to create and associate Tags to existing Terms. NFS connectionId to load the file should be configured under Administration -> Configurations -> aj.fileconn.id',
'Provide the Filename with extension', 'Enter the Path to download the file', 'Enter true to remove the existing associated tags and add new tags');
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label, attr5label)
VALUES  ('Parse JSON data to table', 'JSON_TO_TABLE', 'com.ovaledge.oasis.advance.JsonToTable',
         'Attribute1: SchemaId, Attribute2: Table Name | Primary Key | Create Date Column | Update date Column | Json Column,
         Attribute3: New Table Name, Attribute4: Json Column, Attribute5: Job Last Run Date',
         'Source Schema Id',
         'Source Table Name* | Primary Key* | Create Date Column | Update date Column | Json Column*',
         'Target Schema Id',
         'Target Table Name',
         'Job Last Run Date(You can leave this blank)');
INSERT INTO advancejob (ajname, ajtype, classname, help) values 
('Advance Job for deleting non catalog queries', 'NonCatalogQueryDelAD', 'com.ovaledge.oasis.advance.NonCatalogQueryDelAD', 
'This job is for deleting non catalog queries.');
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label, attr5label) VALUES 
('Qliksenseusage analysis', 'QLIKSENSEASSETUSAGEANALYSIS', 
'com.ovaledge.oasis.advance.QlikSenseAssetUsageAnalysis', 
'This job will process the Asset usage analysis for Qliksense by reading log Files' , 'Enter ConnectionInfoId' , 'Enter SessionFolderPath',
'Enter UserListPath','Enter startDate','Enter EndDate' );
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1label, attr2label, attr3label)
VALUES  ('Parse JSON data to table V2', 'JSON_TO_TABLE_V2', 'com.ovaledge.oasis.advance.JsonToTableV2',
         'Attribute1: Input file path, Attribute2: Schema Name | Table Name | Primary Key | Json Column, Attribute3: Output file path',
         'Input file path',
         'Schema Name | Table Name | Primary Key | Json Column Name',
         'Output file path');
INSERT INTO advancejob(ajname, ajtype, classname, help, attr1label) VALUES 
('Sqlserver Hash staging tables removal', 'TEMP_Lineage_Removal', 
'com.ovaledge.oasis.advance.StageTempLineageRemovalAdvancejob', 
'This job will Remove the lineage for staging tables starts with # by considering connectionid as attribute', 
'Conncetion id for Hash Table Removal: ');
insert into advancejob (ajname, ajtype, classname, help, attr1label) values 
('Advance Job for Remove staging temp tables starts with # for a Connection', 'TempLineageDeletionForStagingTempTables', 
'com.ovaledge.oasis.advance.StageTempLineageRemovalAdvancejob', 
'Advance job input attributes are connectionid delete the lineage for # Temp tables for the staging tables ', 'ConnectioninfoId');
INSERT INTO advancejob
(ajname, ajtype, classname, help, attr1label, attr2label, attr3label, attr4label, attr5label, visible)
VALUES('SAP BO Asset Usage Analysis', 'BOASSETUSAGE', 'com.ovaledge.oasis.advance.SAPBOAssetUsageAnalysis', 'This job process the usage stats for the BO events for provided dates', 'Enter Audit Database ConnectionId and Audit Database Name seperated by coma', 'Enter SAPBO ConnId', 'Enter the path for userlist file', 'Enter the start date', 'Enter the end date', 1);
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1label, attr2label, attr3label) VALUES 
('Load BdDesc And TechDesc After Text Format', 'LoadBdDescAndTechDescAfterTextFormat', 'com.ovaledge.oasis.advance.LoadBdDescAndTechDescAfterTextFormat', 
'This job would help in loading dataset details from csv file', 'Wiki (Enter TRUE to update bd & td format of wiki)', 'Business Glossary (Enter TRUE to update bd & td of bg)', 'Custom Objects(Enter TRUE to update Text format of Custom Objects)' );
insert into advancejob (ajname, ajtype, classname, help, attr1) values ('Download Query Results', 'download_query_results', 'com.ovaledge.oasis.advance.DownloadQueryResults', 'This Job is used to download the query results', 'Enter the file name with extension');
INSERT INTO advancejob (ajname, ajtype, classname, help,  attr1label) VALUES 
('Load Td From Workbook', 'LoadTdFromWorkbook', 'com.ovaledge.oasis.advance.LoadTdFromWorkbook', 
'This job would help in updating tech desc for chartchilds from tableau workbook', 'connectioninfo id');
INSERT INTO advancejob (ajname, ajtype, classname, help, attr1label, 
attr2label, attr3label, attr4label, attr5label, visible)
VALUES 
('Update techincal table and column descriptions from user table', 'AssignTableTechDescriptions', 
'com.ovaledge.oasis.advance.AssignTableTechDescriptions', 
'This job would help in fetching table and column descriptions if they are maintained in seperate user tables.', 
'Connection Info Id','Schema Name', 'Table with Tables, Table with Columns', 'Column with Table Names, Column with Column Names, Column with Table Names in Column Table',
'Column with Table Descriptions, Column with Column Descriptions',1);


INSERT INTO dashboard (DASHBOARDID, WIDGET_GRID, DASHBOARD_NAME) VALUES (1, "[]", "Admin's Dashboard");


INSERT INTO dataidentifier (datatype, datatypedesc, regex, LASTMODDATE) VALUES 
('SSN', '123-45-6789', '^(?!000|666)[0-8][0-9]{2}-(?!00)[0-9]{2}-(?!0000)[0-9]{4}$', now());


INSERT INTO filestructurefcn (fcnname, fcntype, inputsize, description, regularexp, columnname) VALUES 
('Label', 'RB', 2, 'Provide Label name and number of words you expect in outcome. This function would determine the value of label. For example Label of \"Total Price:\" and \"1\" would return the text Total Price: 100 would be converted into 100 as Total Price. ', '', 'Custom_Label');
INSERT INTO filestructurefcn (fcnname, fcntype, inputsize, description, regularexp, columnname) VALUES 
('In Between', 'RB', 2, 'This function will determine any content, which is in between of these two values and associate with the column name. \nExample: In Between of \"would be\" and \"dollar\" would result like following:\ntotal price would be 600 dollars. PRICE: 600', '', 'Custom_Inbetween');
INSERT INTO filestructurefcn (fcnname, fcntype, inputsize, description, regularexp, columnname) VALUES 
('Charcter Position', 'RB', 2, 'This function returns the value between two positions. For example Characer Position(INPUT_TEXT_SOMETHING, 7, 11) is TEXT', NULL, 'Custom_CP');


INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.admin.principle', 'admin', 'OvalEdge application admin userid. (RESTART REQUIRED)', 1, 0, 'USERS_ROLES'); 
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.admin.credential', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'OvalEdge applications admin password.', 1, 1, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.login.application', 'TRUE', 'Is OvalEdge allowed to be login via self-service user account.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.jarpath', '/home/ovaledge/third_party_jars', 'Various drivers jar files location, to ingest data into OvalEdge. (RESTART REQUIRED)', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.running.jobs.count', '15', 'Maximum jobs on runnnig (max count 20)', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.smtp.server', '', 'SMTP Server of Email Provider', 1, 0, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.smtp.port', '', 'Port number at SMTP Server', 1, 0, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.smtp.mode', 'Default', 'Transport Mode: SSL/TLS/Default', 1, 0, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.email.username', '', 'UserId at SMTP Server. Leave Empty for password less smtp server', 1, 0, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.email.password', '', 'Password of this account',1,1, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.email.fromEmail', '', 'Default from Email Address', 1, 0, 'SMTP');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.base.url', 'http://localhost:8080/ovaledge/', 'New user registration URL', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.role.admin', 'OE_ADMIN', 'Default admin role. (RESTART REQUIRED)', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.image.path', '', 'Enter the path where all the images would be stored. Wor windows use in format C:ovaledgeimages and for unix use /home/ovaledge/images', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.tag.role', 'OE_ADMIN', 'Role designated for creating tags', 1, 0, 'USERS_ROLES');
insert into jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) values 
('OVALEDGE_APP', 'ovaledge.locale', 'en', 'Default App Locale', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.role.public', 'OE_PUBLIC', 'Default public role', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.license.agreement.link', 'https://ovaledge.com/eula/', 'License Agreement Link', '1', '0', 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.credentialfiles.path', '', 'credentials path', '1', '0', 0, 'SYSTEM_PATHS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'high.perf.server.host', '', 'OvalEdge high performance server.', 1, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'high.perf.server.port', '', 'OvalEdge high performance port.', 1, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'high.perf.rt.server.port', '', 'OvalEdge high performance real time port.', 1, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'high.perf.rt.server.host', '', 'OvalEdge high performance real time server.', 1, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'high.perf.use.blue.print', '', 'Use blueprint concept for this client.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.log.level', 'info', 'Root log level', 1, 0, 'OTHERS');
INSERT INTO jobparm(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'ovaledge.term.policy', 'A|3', 'OvalEdge Term Recommedation Policy', 1, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'ovaledge.temppath', 'It should be server folder path', 'OvalEdge temporary operation path.', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ssis.filepath', '', 'All Files, which are used in SSIS packages should go to this location', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'high.perf.limit.catalog.file', '0', 'OvalEdge high performance catalog job will execute on a folder only when number of files in that folder is less than this limit.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.crawler.role', 'OE_ADMIN', 'Role designated for Manage crawling', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'high.perf.limit.profile.file', '0', 'OvalEdge high performance profile job will execute on a folder only when number of files in that folder is less than this limit.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.filesize.limit', '2097152', 'Size limit for uploading files', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'rpttoxml.executable.path', '', 'Path to Executable, which converts rpt file to xml format', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'qlik.sense.path', '', 'Qlik sense Certificate path', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'qlik.sense.xml', '', 'Qlik Sense XML Path', 1, 0, 'SYSTEM_PATHS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ai.match.score', '10', 'AI Match Score', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'tag.tile.size', 'large', 'OvalEdge Tag Size', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'pagination.row.limit', '20', 'To show number of records in a page.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'nosql.rowcount', '100', 'No of Rows to crawl to Get NoSQL Column details', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'profile.json.file.read.single.line', 'true', 'Defines if the json files for profile have json on each line', 1, 0, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'saml.role.prefix', '', 'saml role prefix', 1, 0, 'SSO');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'qubolehive.skipviewprofile', 'false', 'Skip profiling of Qubole Hive Views', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'snowflake.skipviewprofile', 'false', 'Skip profiling of Snowflake Views', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'file.skipfullprofile', 'false', 'Skip File Profiling', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.saml.type', 'HYBRID', 'Ovaledge saml type (REMOTE or HYBRID)', 1, 0, 'SSO');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.dqrule.bg.enforcement', 'false', 'Ovaledge DQ Rule BG Enforcement', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'shallow.lineage.connection.ids', '', 'Add all possible connection ids to search tables / columns for shallow lineage', 1, 0, 'LINEAGE'); 
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.api.role', '', 'API Role(Leave empty to permit all user roles)', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'lineage.selfbuild', 'false', 'To build self lineage', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.qlik.iframe', 'true', 'Qlik iframe value(true or false)', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'handle.missing.view.name', 'false', 'Use Additional logic to handle missing view names in code', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'use.conn.to.resolve.tables', 'false', 'Use Connection info logic to resolve ambiguous tables in code', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'aiterm.maxcolumns', '50000', 'Max Columns to consider in AI Term Recommendation', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'proxy.host', '', 'Proxy Host', 1, 0, 'PROXY');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'proxy.port', '', 'Proxy Port', 1, 0, 'PROXY');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'proxy.protocol', 'http', 'Proxy Protocol(https/http)', 1, 0, 'PROXY');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.fileupload.maxfiles', '10', 'Maximum File Count to be considered in uploading Files', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.role.governance', 'OE_ADMIN', 'Default Governance role', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'enforce.validateobjects', 'false', 'To validate New Objects by Data Governance Team', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ldap.allow.emptyemail', 'false', 'Empty EMAIL support for ldap user', 1, 0, 'SSO');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'disable.deactivate.missing.table', 'false', 'Disable Table deactivate in Schema Crawl', 1, 0, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'saml.role.suffix', 'false', 'SAML Role Suffix', 1, 0, 'SSO');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'user.allow.hashpassword', 'false', 'true if you want to allow users to login through hashedpassword', 1, 0, 0, 'USERS_ROLES');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
( 'OVALEDGE_APP', 'ordertyperetrieve.default.classification', '', 'Default retrieve classification', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.default.domain', '', 'Default domain', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
( 'OVALEDGE_APP', 'ordertypedelete.default.classification', '', 'Default delete classification', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
( 'OVALEDGE_APP', 'parent.exceptiontag.name', '', 'Default exception tag', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
( 'OVALEDGE_APP', 'default.customdefinition.name', '', 'Default exception tag', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
( 'OVALEDGE_APP', 'tag.additionalretrieve.fieldname', '', 'Default tag retrieve name', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
( 'OVALEDGE_APP', 'tag.additionaldelete.fieldname', '', 'Default tag delete name', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
( 'OVALEDGE_APP', 'default.customobject.fieldposition', '', 'Default CustomObject field', 1, 0, 0, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
( 'OVALEDGE_APP', 'oe.userdelete.role', '', 'Alternate user management role', 1, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'alternate.file.ext.types', '{"TXT":"CSV"}', 'Alternate file types for client aka TXT=CSV', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'lineage.width.nodes', '3', 'To show lineage graph width at max', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'lineage.height.nodes', '30', 'To show lineage graph height at max ', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'lineage.debugmode', 'false', 'debug the temptable lineage', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.namebasedrelationsjob.ispkbased', 'false', 'This param confirms to consider PK or not while building column name based relationships', 1, 0, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.session.timeout', '86400', 'Session timeout for application in seconds.(RESTART REQUIRED).', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'lineage.pick.anytable', 'false', 'To build the lineage pick any table which is available in oetable', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'lineage.shallow', 'false', 'Building Shallow lineage', 1, 0, 'LINEAGE');
INSERT INTO jobparm
(jobparmid, jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup)
VALUES(1086, 'OVALEDGE_APP', 'jwt.bearerToken.expiryTime', '28800000', 'Expiry time for bearer token in milli seconds. Recommonded time is less than 24hrs', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'connections.order.lineage', '', 'Add needed connection id to pick the tables if multiple conenctions are there', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'querysheet.row.limit', 50000, 'limit to query during download', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword, configgroup) 
values ('OVALEDGE_APP','bg.unique.constraint','domain','Term uniqueness constraints - enhancement to allow same name in different category/sub category of same domain',1,0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
('OVALEDGE_APP', 'navigator.batch.days', '7', 'No of days of events to be collected in one Batch', 1, 0, false, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
('OVALEDGE_APP', 'navigator.event.limit', '5000', 'Navigator Events to be collected in one Request', 1, 0, false, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
('OVALEDGE_APP', 'qlikreports.crawl.starttime', '0', 'CrawlStartTime for Qliksense and Qlikview', 1, 0, false, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES 
('OVALEDGE_APP', 'qlikreports.crawl.endtime', '0', 'CrawlEndTime for Qliksense and Qlikview', 1, 0, false, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'application.defaulttheme', '', 'OvalEdge Application theme', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.skip.instances', '', 'To skip the jobs running on unwanted instances or machines, please provide information of them.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'skip.relations.view', 'false', 'True if you want to skip calculating relations for views(Works only for snowflake connections)', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'need.hard.coded.values.in.lineage', 'false', 'To the hard-coded/fixed-values in lineage make this flag as true', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword,visible, configgroup) values 
('OVALEDGE_APP','ovaledge.dqr.topvalue.separator',',','OVALEDGE DQR TOPVALUE SEPARATOR',1,0,1, 'OTHERS');
INSERT INTO `jobparm`(jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
( 'OVALEDGE_APP', 'dqr.databricks', '', 'Process DQR via Databricks(Y/N)', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ai.recommendation.weightage', '', 'Weightage configuration in (Pattern-Data-Name) respectively ex : 33-34-33 (should be nearest match to 100)', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'navigator.row.limit', 50, 'Pagination row limit to show  Navigator Audit events', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'add.dataset.lineage.version', 'false', 'Apply dataset lineage versioning ? (true/false)', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'aj.fileconn.id', '0', 'File Connection(ID) from which AdvanceJob reads Files', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'config.file.types.upload', 'csv,conf,env,sh,properties,txt,yaml,xlsx,json,ddl,sql,hql', 'Configure file types for upload', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'exclude.datacatalog.subreport', 'false', 'Exclude or Include sub report in datacatalog', '1', '0', 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'disable.sourcecode.search', 'false', 'To disable sourcecode search make this flag as true', '1', '0', 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'process.function.related.lineage', 'false', 'A User defined function is used in a query pick the function and process the function, use function related table column in the query instead of function ', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.sampleprofile.rowsize', '5000', 'Sample profile row size fetch count at one database hit', '1', '0', 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword,configgroup) VALUES
('OVALEDGE_APP', 'ovaledge.topvalues.configuration', '50', 'Top values size configuration', '1', '0', 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'lineage.report.column.reference', 'false','show lineage for tablecolumn to reportcolumn in reports? (true/false)', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'temporary.object.identification.pattern', '', 'The comma seperated patterns for identifying internal staging tables in queries. Tables matching this pattern will be prefixed with <Query Name>_ to get <Query Name>_<Table Name>  ', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) 
VALUES ('OVALEDGE_APP', 'bg.showallcf', 'false', 
'To Show All Custom Fields in Business Glossary, this will be applicable only when Global Custom Field definition is defined', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'enable.dq.faileddata', 'false', 'To Enable DQFailedData Link under Advanced Tools', 1, 0, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'oe.temp.object.hide', 'true', 'Hiding the temparory objects from ovaledge application.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'oe.object.search.count', '20', 'For search the object in ovaledge application.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'oe.impact.tr.column.hide', 'true', 'Hiding the T/R Code, T/R Type column from IA.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.enable.log4j', 'false', 'This will persist Application logs to ElasticSearch/DB Table', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword, configgroup) values 
('OVALEDGE_APP','ovaledge.branding.logo','UPLOAD YOUR BRAND LOGO','UPLOAD THE COMPANY BRAND LOGO HERE.',1,0, 'OTHERS');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword) values 
('OVALEDGE_APP','profiling.configurations','','Aggregations and Grouping sets for Salesforce Profiling not support so maintaining inmemory and mysql profiling',1,0);
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'dq.dqprinciple.visible', 'false', 'Make this flag as true to populate DQ Principle under Execution Results tab', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'dl.internalsearch', 'false', 'To Integrate Internal Page Search with DL Search Input', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'ovaledge.jobs.view.role', '', 'Jobs view/edit role', '1', '0', 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'download.row.limit', '50000', 'To download number of records in a page.', 1, 0, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'saml.mandatory.prefix', '', 'SAML Role Mandatory prefix', 1, 0, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'saml.mandatory.suffix', '', 'SAML Role Mandatory Suffix', 1, 0, 0, 'USERS_ROLES');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword, visible, configgroup) values 
('OVALEDGE_APP','page.refresh.time','30000', 'Page refresh time for pages (in seconds) where automatic page refresh enabled.(RESTART REQUIRED).',1,0, 1, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES 
('OVALEDGE_APP', 'versioning.for.lineage.connection', "", 'lineage versioning for datasets which are part of OE database connections. Add such connection ids seperated by comma(,)', 1, 0, 'LINEAGE');
INSERT INTO jobparm (jobparmtype,jobparmkey,jobparmvalue,jobparmdescription,needinlite,ispassword, visible, configgroup) values
('OVALEDGE_APP','informatica.query.dialect','','Configuration to store database used in Informatica Workflows.',1,0, 1, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'is.raci.enabled', 'false', 'Make this flag as true to populate govern matrix', 1, 0, 1, 'OTHERS');
INSERT INTO `jobparm` ( `jobparmtype`, `jobparmkey`, `jobparmvalue`, `jobparmdescription`,  needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'sqlserver.profile.nolock', 'false', 'SqlServer profile with NOLOCK', 1, 0, 1, 'OTHERS');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, visible, configgroup) VALUES
('OVALEDGE_APP', 'lineage.node.height', '3', 'To show lineage graph width at max for a particular node', 1, 0, 1, 'LINEAGE');
INSERT INTO jobparm (jobparmtype, jobparmkey, jobparmvalue, jobparmdescription, needinlite, ispassword, configgroup) VALUES
('OVALEDGE_APP', 'dremio.build.lineage.with.external.sources', 'false', 'Make this flag as true to run dremio lineage job that builds lineage between dremio crawled schema and its source schema', 1, 0, 'OTHERS');


INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('jobworkflow.log','OvalEdge System Alert: Job Workflow Log Files','Hello, {owner_name} please see the log files resulting from the processed job {job_name}, for more information please follow this link {link} to be taken to OvalEdge.','{owner_name,link,job_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('jobworkflow.success','OvalEdge System Alert: Job Workflow {status}','Hello, {owner_name} the following job {job_name} has succeeded. {job_run_time_completion_time}','{owner_name,job_name,job_run_time_completion_time}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('jobworkflow.failure','OvalEdge System Alert: Job Workflow {status}','Hello, {owner_name} the following job {job_name} has failed. {job_run_time_completion_time}','{owner_name,job_name,job_run_time_completion_time}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('watchlist.success','OvalEdge Watchlist Alert: {obj_type} {metadata} Changes','Hello, {owner_name} Please tap on the following link to review the {metadata} changes for {schema/table/file/report}.The crawl/profile job(s) are completed successfully.','{owner_name,schema/table/file/report}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('term.add','OvalEdge Business Glossary Update: New term created','Hello, {steward_name}, the following term(s) has/have been created by {creator_name}. Please follow this link to review the request {link}','{steward_name,creator_name,link}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('term.approval','OvalEdge Business Glossary Update: Term Approval','Hello, {steward_name}, The following Business Glossary requires your Approval. Please follow the below conversation to approve.','{steward_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('crawl.metadata','OvalEdge Crawler Alert: Metadata Changes','Hello, {owner_name} the following changes have been noted during the latest crawl. Please follow the link to review the changes {schema/table/file/report}.','{owner_name,schema/table/file/report}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('crawl.missingschema','OvalEdge Crawling Alert: Remote Schema not found','Hello, {data_owner} please review the following alert that resulted from the latest crawl, there is a schema missing in the remote system. The following schema, {schema_name} was found and crawled in OvalEdge but the remote system could not be identified.','{data_owner,schema_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('dqrule.violation','OvalEdge Data Quality Rule - {rule_name} has failed','Hello, {receiver_name}. Please see below for the results of the {rule_name} quality rule which completed at {run_time_complete_time}. {Rule_Results}','{receiver_name,rule_name,run_time_complete_time}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('servicedesk.creation','Service Request - New Request has created {req_name}','Hello,  {receiver_name}, {requestor_name} has submitted a {req_name} request, please click on the below link conversation to be taken to the service request to view the details.','{receiver_name,requestor_name,request_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('servicedesk.approvals','Service Request - Requires your Approval for {req_name}','Hello, {receiver_name} You are the next approver to take the action of the Request for {req_name}, please click on the below link conversation to be taken to the service request to view the details.','{receiver_name,request_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('servicedesk.approved','Service Request - Approved','Hello, {receiver_name}, Your Service Request has been Approved for {req_name}. please click on the below link conversation to be taken to the service request to view the details.','{receiver_name,request_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('servicedesk.rejected','Service Request - Rejected','Hello, {receiver_name}, Your Service Request is Rejected for {req_name}. please click on the below link conversation to be taken to the service request to view the details.','{receiver_name,request_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('collaboration.newmsg',"You've been mentioned in a conversation",'Hello, {receiver_name}, {tagger_name} has mentioned you in a comment please view below conversation.','{receiver_name,tagger_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('collaboration.replymsg','You got a reply message','Hello, {receiver_name}, {responder_name}  has responded to your conversation, please follow below Conversation.','{receiver_name,responder_name,link}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('app.newuser','OvalEdge: New User Created','Hello, {admin_name}{new_users_list} have been added and their account(s) are now active. Please follow this {link} to review their role and responsibilities assigned.','{admin_name,new_users_list}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('app.forgetpswrd','OvalEdge: Request to Reset Password','Hello, {user_name}A reset password request was made for your OvalEdge account. Your userid:{userid} Please follow this {link} to reset your password or tap on the button.','{user_name,link}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('project.invite',"OvalEdge: You've been Invited for Project {project_name}",'Hello, {user_name}. You''ve been invited for a Project, tap on the link {project_name} to review.','{user_name, project_name}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('app.buildnew','OvalEdge: Your Account is Ready.','Hello, {user_name}. Your OvalEdge account has been created. Your userid : {userid}.','{user_name}, {userid}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('app.pswrdreset','Ovaledge: Your password reset is Successful.','Hello, {user_name}You recently requested to reset your password for your OvalEdge account. your password has been succesfully changed. Your userid:{userid}','{user_name}, {userid}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES 
('jobworkflow.partialsuccess','OvalEdge System Alert: Job Workflow{status}','Hello, {owner_name} the following job {job_name} has partially succeeded. {job_run_time_completion_time}','{owner_name,job_name,job_run_time_completion_time}');
INSERT INTO mailtemplate (templatetype,emailsubject,emailbody,emailvariable) VALUES
('term.published','OvalEdge Business Glossary Update: Term Published','Hello, {creator_name}, 
The following Business Glossary Approved and Published. {link}','{creator_name}');


INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog - Tables', 'nav/datacatalog/datacatalog.tables', 'datacatalog.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog - Columns', 'nav/datacatalog/datacatalog.columns', 'datacatalog.columns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog - Files', 'nav/datacatalog/datacatalog.files', 'datacatalog.files', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog - File Columns', 'nav/datacatalog/datacatalog.filecolumns', 'datacatalog.filecolumns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCataLog - Reports', 'nav/datacatalog/datacatalog.reports', 'datacatalog.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog.Reports.Columns', 'nav/datacatalog/datacatalog.reportscolumn', 'datacatalog.reportscolumn', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('DataCatalog - Queries', 'nav/datacatalog/datacatalog.queries', 'datacatalog.queries', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data And Metadata Changes', 'nav/dataandmetachanges', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Bussinessglossary Associated Datadictinary', 'nav/glossary/glossary.dictionary.query_dictionary', 'bussinessglossary.associateddatadictinary', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tags Queries', 'nav/tag/tag.querytag', 'tags.queries', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Data', 'nav/table/table.data', 'table.data', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Entity Relationships', 'nav/table/table.relationships', 'table.relationships', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Lineage', 'nav/table/table.lineage', 'table.lineage', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - References', 'nav/table/table.references', 'table.references', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Column Details', 'nav/table/table.columndetails', 'table.columndetails', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File - Data', 'nav/file/file.data', 'file.data', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File - Lineage', 'nav/file/file.lineage', 'file.lineage', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File - References', 'nav/file/file.references', 'file.references', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File - Column Details', 'nav/file/file.columndetails', 'file.columndetails', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Chart - Lineage', 'nav/chart/chart.lineage', 'chart.lineage', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('CHART - References', 'nav/chart/chart.references', 'chart.references', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query - Results', 'nav/query/query.results', 'query.results', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query - Visualize Results', 'nav/query/query.visualize', 'query.visualize', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query - References', 'nav/query/query.references', 'query.references', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query - Lineage', 'nav/query/query.lineage', 'query.lineage', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query Associations', 'nav/query/query.associations', 'query.associations', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Dashboard - User Dashboard', 'nav/userpermissions', 'dashboard.userdashboard', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Dashboard - Lineage Dashboard', 'nav/lineagedashboard', 'dashboard.lineagedashboard', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Governance Catalog - AuditEvents', 'nav/auditevents', 'governancecatalog.auditevents', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Certification Policies', 'nav/certificationpolicy', 'governancecatalog.datacertificationpolicy', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advance Tools - Compare Profile Results', 'nav/compare', 'advancedtools.compareprofileresults', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Queries', 'nav/projectdetail/projectdetail.query', 'project.details', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Chart - Column Details', 'nav/chart/chart.columndetails', 'chart.columndetails', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('My Watch List', 'nav/watchlist', 'watchlist', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Tables', 'nav/security/security.tables', 'security.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Columns', 'nav/security/security.columns', 'security.columns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Applications', 'nav/security/security.applications', 'security.applications', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Folders', 'nav/security/security.folders', 'security.folders', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - ReportGroups', 'nav/security/security.reportsgroups', 'security.reportsgroups', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Reports', 'nav/security/security.reports', 'security.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Domains', 'nav/security/security.domains', 'security.domains', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Story Zone', 'nav/security/security.storyzone', 'security.storyzone', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security - Data Asset Group', 'nav/security/security.dataassetgroup', 'security.dataassetgroup', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Business Glossary', 'nav/tag/tag.glossary', 'tag.glossary', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Databases', 'nav/tag/tag.databases', 'tag.databases', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Tables', 'nav/tag/tag.tables', 'tag.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Table Columns', 'nav/tag/tag.columns', 'tag.columns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Files', 'nav/tag/tag.files', 'tag.files', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - File Columns', 'nav/tag/tag.filecolumns', 'tag.filecolumns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Reports', 'nav/tag/tag.reports', 'tag.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Report Column', 'nav/tag/tag.reportscolumn', 'tag.reportscolumn', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Data Stories", "tag.stories', 'nav/tag/tag.stories', 'tag.stories', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag - Queries', 'nav/tag/tag.query', 'tag.query', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('My Watch List - Tables', 'nav/watchlist/watchlist.tables', 'watchlist.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('My Watch List - Reports', 'nav/watchlist/watchlist.reports', 'watchlist.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('My Watch List - Data Quality Rule', 'nav/watchlist/watchlist.dataquality', 'watchlist.dataquality', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Impact Analysis - AffectedObjects', 'nav/impactAnalysis/impactAnalysis.affectedobjects', 'impactAnalysis.affectedobjects', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Impact Analysis - ImpactedObjects', 'nav/impactAnalysis/impactAnalysis.impactedobjects', 'impactAnalysis.impactedobjects', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Tables', 'nav/projectdetail/projectdetail.tables', 'projectdetail.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Table Columns', 'nav/projectdetail/projectdetail.columns', 'projectdetail.columns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Files', 'nav/projectdetail/projectdetail.files', 'projectdetail.files', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - File Columns', 'nav/projectdetail/projectdetail.filecolumns', 'projectdetail.filecolumns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Reports', 'nav/projectdetail/projectdetail.reports', 'projectdetail.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details - Report Column', 'nav/projectdetail/projectdetail.reportscolumn', 'projectdetail.reportscolumn', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Classification - Tables', 'nav/dataclassification/dataclassification.tables', 'dataclassification.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Classification - Table Columns', 'nav/dataclassification/dataclassification.columns', 'dataclassification.columns', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Classification - Files', 'nav/dataclassification/dataclassification.files', 'dataclassification.files', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Classification - Reports', 'nav/dataclassification/dataclassification.reports', 'dataclassification.reports', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Business Glossary - Detail', 'nav/glossary/glossary.detail', 'glossary.detail', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Business Glossary - Associated Data', 'nav/glossary/glossary.bgdictionary', 'glossary.bgdictionary', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Business Glossary - Recommendations', 'nav/glossary/glossary.bgrecommendations', 'glossary.bgrecommendations', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Business Glossary - References', 'nav/glossary/glossary.references', 'glossary.references', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('User Manager - Users and Roles', 'nav/user-manager/user-manager/userroles', 'usermanager.userroles', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Tables', 'nav/schema/schema.tables', 'schema.tables', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Queries', 'nav/schema/schema.queries', 'schema.queries', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Functions', 'nav/schema/schema.functions', 'schema.functions', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Views', 'nav/schema/schema.views', 'schema.views', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Procedures', 'nav/schema/schema.procedures', 'schema.procedures', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Others', 'nav/schema/schema.others', 'schema.others', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Audit Trails', 'nav/audittrail', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Load Metadata from files', 'nav/loadfilesdata', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Profile Details', 'nav/profile', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Security', 'nav/security', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('User Manager', 'nav/user-manager', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Compare Schema', 'nav/comparedb', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Metachanges', 'nav/metachanges', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Jobs', 'nav/jobs', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Inbox', 'nav/messages', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advance Search', 'nav/advancedsearch', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Catalog', 'nav/datacatalog', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table', 'nav/table', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Endorsement', 'nav/endorsement', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('GetWikiHistory', 'nav/getwikihistory', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File', 'nav/file', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Report', 'nav/report', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schema', 'nav/schema', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query Sheet', 'nav/querysheet', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query', 'nav/query', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Query Execute', 'nav/query/query.execute', 'query.execute', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Job Workflow Details', 'nav/jobworkflowdetails', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Dashboard', 'nav/dashboard', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schedule', 'nav/schedule', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Search', 'nav/search', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('File Manager', 'nav/filemanager', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Crawler', 'nav/crawler', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('About Ovaledge', 'nav/about-app', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Job WorkFlow', 'nav/job-workflow', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Time Line Dashboard', 'nav/timelinedashboard', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Configuration', 'nav/configuration', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Queries', 'nav/queries', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Create Table', 'nav/createtable', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Story', 'nav/story', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Lineage', 'nav/lineage', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advance Jobs', 'nav/advanceJob', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Tag', 'nav/tag', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Column Tag', 'nav/columntag', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Impact Analysis', 'nav/impactAnalysis', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Alerts', 'nav/alert', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Domains', 'nav/domains', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Asset Group', 'nav/dataassets', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Classification', 'nav/dataclassification', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Servicedesk', 'nav/servicedesk', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Business Glossary', 'nav/glossary', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Projects', 'nav/project', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Project Details', 'nav/projectdetail', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('SP Lineage', 'nav/splineage', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Custom Fields', 'nav/custom-fields', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('User-Dashboard', 'nav/user-dashboard', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('UserDash', 'nav/userdash', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Quality Rule', 'nav/dqrule', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Data Quality', 'nav/dataquality', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Governed Data Query', 'nav/governdataquery', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('GDQ Compliance', 'nav/gdqcompliance', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('GDQ Result', 'nav/gdqresult', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advanced Tools', 'nav/advancedtools', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Reset', 'nav/reset', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Logs', 'nav/logs', '', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advanced Tools - Temp Lineage Correction', 'nav/templineagemerge', 'advancedtools.templineagemerge', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Quality Index', 'nav/dqindex', 'qualityindex.dqindex', 0 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Servicedesk All Requests', 'nav/servicedesk/servicedesk.allrequests', 'servicedesk.allrequests', 1 , 0 );
INSERT INTO application (name, path, code, issubtab, active) VALUES
('Security.ApprovalWorkflow', 'nav/security/security.approvalworkflow',
 'security.approvalworkflow', 1 , 0 );
 INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Trigger', 'nav/schema/schema.trigger', 'schema.trigger', 1 , 0 ) ON DUPLICATE KEY UPDATE active = true;
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Schemas - Synonyms', 'nav/schema/schema.synonyms', 'schema.synonyms', 1 , 0 ) ON DUPLICATE KEY UPDATE active = true;
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Column Details', 'nav/table/table.columndetails.relationships', 'table.columndetails.relationships', 1 , 0 ) ON DUPLICATE KEY UPDATE active = true;
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Table - Column Details', 'nav/table/table.columndetails.patternrelationships', 'table.columndetails.patternrelationships', 1 , 0 ) ON DUPLICATE KEY UPDATE active = true;
INSERT INTO application (name, path, code, issubtab, active) VALUES 
('Advance Tools - File Upload', 'nav/filesupload', 'advancedtools.filesupload', 1 , 0 ) ON DUPLICATE KEY UPDATE active = true;


INSERT INTO license VALUES ('InvalidKey');


INSERT INTO regextable (functionid, filestructureid, columnname, inputvalue) VALUES (1, 6, 'From_Email', 'From:,1');
INSERT INTO regextable (functionid, filestructureid, columnname, inputvalue) VALUES (1, 6, 'To_Email', 'To:,1');
INSERT INTO regextable (functionid, filestructureid, columnname, inputvalue) VALUES (1, 10, 'Custom_Label', 'ss,ss');



INSERT INTO roles (ROLEID, AUTHORITY, defaultrole, defaultpermission, licensetype) VALUES (1, 'OE_ADMIN', 1, 18, 3);
INSERT INTO roles (ROLEID, AUTHORITY, defaultrole, defaultpermission, licensetype) VALUES (2, 'OE_PUBLIC', 0, 0, 1);



INSERT INTO schedule (DESCRIPTION, CRONENTRY, USERID, ACTIVE, LASTMODDATE, CLASSNAME, CONTEXT,ENABLED) VALUES 
('JobServiceBackgroundThread', '0/20 * * * * ?', 'admin', 1, now(), 'JobServiceBackgroundThread', 0,true);
insert into schedule (DESCRIPTION, CRONENTRY, USERID, ACTIVE, LASTMODDATE, CLASSNAME, CONTEXT,ENABLED) values 
('Object Access Expiry', '* * 2 * * ?', 'admin', 1, now(), 'AccessExpiryThread', 0,true);
INSERT INTO schedule (DESCRIPTION, CRONENTRY, USERID, ACTIVE, LASTMODDATE, CLASSNAME, CONTEXT,ENABLED) VALUES 
('Job Orchestration Service', '0/5 * * * * ?', 'admin', 1, now(), 'JobOrchestrationThread', 0,true);
INSERT INTO schedule (DESCRIPTION, CRONENTRY, USERID, ACTIVE, LASTMODDATE, CLASSNAME, CONTEXT, ENABLED) VALUES 
('Data Synchronization Service', '0/10 * * * * ?', 'admin', 1, now(), 'DataSynchronizationThread', 0, false);


INSERT INTO stxpackage (packagename, description) VALUES ('ML-Name', 'This package automaticall identify common names');
INSERT INTO stxpackage (packagename, description) VALUES ('RB-Email', 'Contain various rules to identify from/to email, subject etc');
INSERT INTO stxpackage (packagename, description) VALUES ('ML-Country', 'Identify countries automatically');
INSERT INTO stxpackage (packagename, description) VALUES ('ML-Language', 'Identify language automatically');


INSERT INTO user (USERID, FNAME, LNAME, EMAIL, GENDER, PERSONAL_PHONE, PASSWORD, ADDRESS, CITY_STATE, ZIP, AUTHORITIES, TITLE, status, usertype, 
token, licenseaccepted, createdate, licensetype) VALUES ('admin', 'Admin', 'OvalEdge', 'admin@ovaledge.com', 'Male', '(678) 111-1111', 
'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '123 Main St Marietta', 'GA', 30067, 'OE_ADMIN', 'Admin', 'active', 'ovaledge', '', false, now(), 3);

INSERT INTO user_role (USERID, ROLEID) VALUES ('admin', 1);

INSERT INTO userdashboard (USER_USERID, DASHBOARD_DASHBOARDID, DEFAULTDASH) VALUES ('admin', 1, 1);

update roles set licensetype = 1 where authority= 'OE_PUBLIC';

INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('dataowner', 0, 1, 'access', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('dataowner', 0, 1, 'newassetreq', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('datasteward', 0, 1, 'content', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('datasteward', 0, 1, 'dataquality', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('datasteward', 0, 1, 'other', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, floworder, type, createby, updateby) 
values ('steward', 0, 1, 'governancecatalog', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, userid, floworder, type, createby, updateby) 
values ('user', 0, 'admin', 1, 'crawlprofile', 'admin', 'admin');
INSERT into globalworkflow (workflowtype, assobject, userid, floworder, type, createby, updateby) 
values ('user', 0, 'admin', 1, 'lineagebuild', 'admin', 'admin');

insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('DENSITY PERCENT(TB)', 'densitypercentage', 'select COUNT(DISTINCT($COLUMN)) as densitycnt from $TABLE where $COLUMN is NOT NULL', 'oetable', false, 'completeness', 'rangepercentage', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('NULL DENSITY PERCENT(TB)', 'nulldensitypercentage', 'select count(*) as nulldensity from $TABLE  WHERE  $COLUMN is NULL', 'oetable', false, 'completeness', 'rangepercentage', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('TOTAL ROW COUNT(TB)', 'rowcountrange', 'select count(*) from $TABLE', 'oetable', false, 'completeness', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('AVERAGE(TC)', 'avgrange', 'select avg($COLUMN) as avg from $TABLE  WHERE  $COLUMN is NOT NULL', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('DISTINCT(TC)', 'distinctrange', 'select COUNT(DISTINCT($COLUMN)) as distcnt from $TABLE where $COLUMN is NOT NULL', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('MIN(TC)', 'minrange', 'select Min($COLUMN) as min from $TABLE  WHERE  $COLUMN is NOT NULL', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('MAX(TC)', 'maxrange', 'select MAX($COLUMN) as max from $TABLE  WHERE  $COLUMN is NOT NULL', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('NULL COUNT RANGE(TC)', 'nullcountrange', 'select count(*) as count from $TABLE  WHERE  $COLUMN is NULL', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('STD DEVIATION(TC)', 'deviationrange', 'select STDEV($COLUMN) as stddev from $TABLE  WHERE $COLUMN is not null', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('SUM(TC)', 'sumrange', 'select SUM($COLUMN) as sum from $TABLE  WHERE $COLUMN is not null', 'oecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('TOP VALUES(TC)', 'topvaluescontains', 'SELECT $COLUMN , COUNT(*) AS cnt FROM $TABLE WHERE $COLUMN IS NOT NULL GROUP BY  $COLUMN ORDER BY 2 DESC', 'oecolumn', false, 'validity', 'valid', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('SQL EXACT VALUE(SQL)', 'custom', '', 'oequery', true, 'uniqueness', 'valid', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('SQL VALUE CONTAINS(SQL)', 'customvalues', '', 'oequery', true, 'validity', 'valid', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('SQL VALUE RANGE(SQL)', 'customrange', '', 'oequery', true, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('HAS NO NULL VALUE(FC)', 'notnullrange', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('HAS NO DIGITS OR SPECIAL CHARS(FC)', 'hasnodigitsorspecialchars', '','oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('HAS DIGITS AND SPECIAL CHARS(FC)', 'hasdigitsandspecialchars', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('NO LEADING OR TRAILING SPACES(FC)', 'hascharatposition', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('HAS SUBSTRING IN STRING(FC)', 'hassubstringinstring', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('BELONGS TO ONE OF LANGUAGES(FC)', 'haslanguage', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('WORD COUNT WITH IN RANGE(FC)', 'haswordcount', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('COLUMN VALUE SAME AS OTHER COLUMN VALUE(FC)', 'hasvalue', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('REGEX MATCH(FC)', 'hasregexmatch', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('COLUMN VALUE MATCHES ONE OF GIVEN VALUES(FC)', 'hascolumnvaluematch', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('ALL COLUMN VALUES MATCHES GIVEN FIXED VALUE(FC)', 'hascolumnmatchfixedvalue', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('FIRST LETTER OF WORD UPPER CASE AND REST LOWER CASE(FC)', 'hasfirstupperrestlower', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('THIS COLUMN VALUE SHOULD BE UNIQUE(FC)', 'hasuniquevalue', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('WORD VALIDATION(FC)', 'wordvalidation', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('NUMBER VALIDATION(FC)', 'numbervalidation', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('DATE VALIDATION(FC)', 'datevalidation', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('NUMERIC VALUE BETWEEN MIN AND MAX VALUES(FC)', 'numericvaluerange', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('VALUE VALIDATION(FC)', 'valuevalidation', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('ALLOW ONLY SPECIFIED SPECIAL CHARACTAR(FC)', 'allowonlyspecifiedspecialchar', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('HAS LENGTH OF THE VALUE WITH IN RANGE(FC)', 'haslengthrange', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('COLUMNS UNIQUE PERCENT VALUE(FC)', 'coluniquepercentvalue', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount) 
values('OUTLIERS TO AGGREGATIONS(FC)', 'customoutlierstoaggregations', '', 'oefilecolumn', false, 'validity', 'range', 0);
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode)
values('VALIDATE EMAIL PERCENT(TC)', 'validateemailpercentage', 'select SUM((CASE WHEN (trim($COLUMN) like \'%_@_%._%\' AND trim($COLUMN)  not like \'% %\' AND  trim($COLUMN) not like \'%@%@%\' AND trim($COLUMN) not like \'%..%\' AND trim($COLUMN) not like \'.%\' AND trim($COLUMN) not like \'%.\' AND trim($COLUMN) not like \'%.@%\' AND trim($COLUMN) not like \'%@.%\' AND trim($COLUMN) not like \'%&%\' AND trim($COLUMN) not like \'%$%\') then 1 else 0 END)) * 100 / count(*) as result from $TABLE', 
'oecolumn', false, 'validity', 'rangepercentage', 0,
'select count(*) as Totalcount, sum(CASE WHEN (trim($COLUMN) like \'%_@_%._%\' AND trim($COLUMN)  not like \'% %\' AND  trim($COLUMN) not like \'%@%@%\' AND trim($COLUMN) not like \'%..%\' AND trim($COLUMN) not like \'.%\' AND trim($COLUMN) not like \'%.\' AND trim($COLUMN) not like \'%.@%\' AND trim($COLUMN) not like \'%@.%\' AND trim($COLUMN) not like \'%&%\' AND trim($COLUMN) not like \'%$%\') then 1 else 0 END) as Passedcount,sum(CASE WHEN (trim($COLUMN) like \'%_@_%._%\' AND trim($COLUMN)  not like \'% %\' AND  trim($COLUMN) not like \'%@%@%\' AND trim($COLUMN) not like \'%..%\' AND trim($COLUMN) not like \'.%\' AND trim($COLUMN) not like \'%.\' AND trim($COLUMN) not like \'%.@%\' AND trim($COLUMN) not like \'%@.%\' AND trim($COLUMN) not like \'%&%\' AND trim($COLUMN) not like \'%$%\') then 0 else 1 END) as Failedcount from $TABLE', 
'SELECT $COLUMN FROM $TABLE where trim($COLUMN) not like \'%_@_%._%\' OR trim($COLUMN) like \'% %\' OR  trim($COLUMN) like \'%@%@%\' OR trim($COLUMN) like \'%..%\' OR trim($COLUMN) like \'.%\' OR trim($COLUMN) like \'%.\' OR trim($COLUMN) like \'%.@%\' OR trim($COLUMN) like \'%@.%\' order by $COLUMN ASC');
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode) 
values('DENSITY PERCENT(TC)', 'tcdensitypercentage', 'select count(distinct($COLUMN)) * 100 / (CASE WHEN count(*) = 0 THEN 1 ELSE count(*) END) as densitycnt from $TABLE WHERE $COLUMN IS NOT NULL', 'oecolumn', false, 'uniqueness', 'rangepercentage', 0,'', '');
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode) 
values('NULL DENSITY PERCENT(TC)', 'tcnulldensitypercentage', 'select sum(case when $COLUMN is null then 1 else 0 end)*100/count(*) as nulldensity from $TABLE', 'oecolumn', false, 'uniqueness', 'rangepercentage', 0,'', '');
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode) 
values('VALIDATE REGEX PERCENT(TC)', 'validateregexpercentage', '', 'oecolumn', false, 'validity', 'rangepercentage', 0,'', '');
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode) 
values('VALIDATE PATTERN PERCENT(TC)', 'validatepatternpercentage', '', 'oecolumn', false, 'validity', 'rangepercentage', 0,'', '');
insert into dqfunctiondef(name, type, standardcode, objecttype, runonsource, dimension, functiontype, functioninputcount, statscode, valuescode) 
values('OUTLIER RULE(TC)', 'outliersrange', 'select (CASE WHEN count(*) = 0 then 1 else 0 END) as result from $TABLE where $COLUMN < $MINVALUE or $COLUMN > $MAXVALUE', 
'oecolumn', false, 'validity', 'range', 0,'select count(*) as Totalcount, sum(CASE WHEN ($COLUMN >= $MINVALUE and $COLUMN <= $MAXVALUE) then 1 else 0 END) as Passedcount,sum(CASE WHEN ($COLUMN < $MINVALUE or $COLUMN > $MAXVALUE) then 1 else 0 END) as Failedcount from $TABLE', 
'SELECT $COLUMN FROM $TABLE WHERE $COLUMN < $MINVALUE or $COLUMN > $MAXVALUE order by $COLUMN desc');

insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('mysql', 'validateregexpercentage', 'select SUM((CASE WHEN trim(`$COLUMN`) regexp $REGEX then 1 else 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN (trim(`$COLUMN`) regexp $REGEX) then 1 else 0 END) as Passedcount,sum(CASE WHEN (trim(`$COLUMN`)  not regexp $REGEX) then 1 else 0 END) as Failedcount from $TABLE', 'SELECT `$COLUMN` FROM $TABLE WHERE (trim(`$COLUMN`) not regexp $REGEX) order by `$COLUMN` ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('oracle', 'validateregexpercentage', 'SELECT Nvl(SUM((CASE WHEN (REGEXP_LIKE(trim($COLUMN),$REGEX)) THEN 1 ELSE 0 end)), 0) * 100 / (case when count(*) = 0 then 1 else count(*) end) AS result FROM $TABLE', 'select count(*) as Totalcount, Nvl(sum(CASE WHEN ( REGEXP_LIKE (trim($COLUMN) , $REGEX)) then 1 else 0 END), 0) as Passedcount, Nvl(sum(CASE WHEN (NOT REGEXP_LIKE(trim($COLUMN), $REGEX)) then 1 else 0 END), 0) as Failedcount from $TABLE' , 'SELECT $COLUMN FROM $TABLE WHERE ( NOT REGEXP_LIKE(trim($COLUMN), $REGEX)) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('postgres', 'validateregexpercentage', 'SELECT SUM((CASE WHEN trim(cast ("$COLUMN" as varchar)) ~ $REGEX THEN 1 ELSE 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE' , 'SELECT count(*) as Totalcount, sum(CASE WHEN trim(cast ("$COLUMN" as varchar) ) ~ $REGEX THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN trim(cast ("$COLUMN" as varchar)) !~ $REGEX THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT "$COLUMN" FROM $TABLE WHERE (trim(cast ("$COLUMN" as varchar)) !~ $REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('redshift', 'validateregexpercentage', 'select SUM(case when (trim($COLUMN) ~ $REGEX) then 1 else 0 end) * 100 /count(*) from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN trim($COLUMN) ~ $REGEX THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN trim($COLUMN) !~ $REGEX THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE (trim($COLUMN) !~ $REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('vertica', 'validateregexpercentage', 'SELECT SUM((CASE WHEN (REGEXP_LIKE(trim($COLUMN), $REGEX)) THEN 1 ELSE 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN REGEXP_LIKE(trim($COLUMN), $REGEX) THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN REGEXP_NOT_LIKE(trim($COLUMN), $REGEX) THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE REGEXP_NOT_LIKE(trim($COLUMN),$REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('snowflake', 'validateregexpercentage', 'SELECT SUM((CASE WHEN (REGEXP_LIKE(trim($COLUMN), $REGEX)) THEN 1 ELSE 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN REGEXP_LIKE(trim($COLUMN),$REGEX) THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN NOT REGEXP_LIKE(trim($COLUMN), $REGEX) THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE REGEXP_LIKE(trim($COLUMN),$REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('maria', 'validateregexpercentage', 'select SUM((CASE WHEN trim($COLUMN) regexp  $REGEX then 1 else 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN (trim($COLUMN) regexp $REGEX) then 1 else 0 END) as Passedcount,sum(CASE WHEN (trim($COLUMN)  not regexp $REGEX) then 1 else 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE (trim($COLUMN) not regexp $REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('impala', 'validateregexpercentage', 'SELECT SUM((CASE WHEN (REGEXP_LIKE(trim($COLUMN), $REGEX)) THEN 1 ELSE 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN REGEXP_LIKE(trim($COLUMN),$REGEX) THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN NOT REGEXP_LIKE(trim($COLUMN), $REGEX) THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE NOT REGEXP_LIKE(trim($COLUMN),$REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('greenplum', 'validateregexpercentage', 'SELECT SUM((CASE WHEN trim($COLUMN) ~ $REGEX THEN 1 ELSE 0 END)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN trim($COLUMN) ~ $REGEX THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN trim($COLUMN) !~ $REGEX THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE (trim($COLUMN) !~ $REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('exasol', 'validateregexpercentage', 'SELECT SUM(CASE WHEN trim($COLUMN) REGEXP_LIKE $REGEX THEN 1 ELSE 0 END) * 100 / (case when count(*) = 0 then 1 else count(*) end) as "result" from $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN trim($COLUMN) REGEXP_LIKE $REGEX THEN 1 ELSE 0 END) as Passedcount,sum(CASE WHEN trim($COLUMN) NOT REGEXP_LIKE $REGEX THEN 1 ELSE 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE trim($COLUMN) NOT REGEXP_LIKE $REGEX order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('denodo', 'validateregexpercentage', 'SELECT SUM((CASE WHEN (trim($COLUMN) REGEXP_LIKE $REGEX) THEN 1 ELSE 0 end)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result FROM $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN ( trim($COLUMN) REGEXP_LIKE  $REGEX) then 1 else 0 END) as Passedcount,sum(CASE WHEN (trim($COLUMN) REGEXP_LIKE $REGEX) then 0 else 1 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE  NOT ( trim($COLUMN) REGEXP_LIKE $REGEX) order by $COLUMN desc');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('db2', 'validateregexpercentage', 'SELECT SUM((CASE WHEN ( REGEXP_LIKE(trim($COLUMN),$REGEX)) THEN 1 ELSE 0 end)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result FROM $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN ( REGEXP_LIKE (trim($COLUMN) , $REGEX)) then 1 else 0 END) as Passedcount,sum(CASE WHEN (NOT REGEXP_LIKE(trim($COLUMN), $REGEX)) then 1 else 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE ( NOT REGEXP_LIKE(trim($COLUMN), $REGEX)) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('hive', 'validateregexpercentage', 'SELECT SUM((CASE WHEN (trim($COLUMN) REGEXP $REGEX) THEN 1 ELSE 0 end)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result FROM $TABLE', 'select count(*) as Totalcount, sum(CASE WHEN ( trim($COLUMN) REGEXP $REGEX) then 1 else 0 END) as Passedcount,sum(CASE WHEN (trim($COLUMN) NOT REGEXP $REGEX) then 1 else 0 END) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE (trim($COLUMN) NOT REGEXP $REGEX) order by $COLUMN ASC');
insert into dqfunctiondefserver(servertype, type, servercode, statscode, valuescode) values('clickhouse', 'validateregexpercentage', 'select SUM(IF( match(trim($COLUMN), $REGEX),1,0)) * 100 / (case when count(*) = 0 then 1 else count(*) end) as result from $TABLE', 'select count(*) as Totalcount, sum(IF( match(trim($COLUMN), $REGEX),1,0)) as Passedcount,sum(IF(NOT match(trim($COLUMN), $REGEX),1,0)) as Failedcount from $TABLE', 'SELECT $COLUMN FROM $TABLE WHERE (NOT match(trim($COLUMN), $REGEX)) order by $COLUMN ASC');

insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'maxrange', 'select MAX("$COLUMN") as max from $TABLE  WHERE  "$COLUMN" is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'minrange', 'select Min("$COLUMN") as min from $TABLE  WHERE  "$COLUMN" is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'distinctrange', 'select COUNT(DISTINCT("$COLUMN")) as distcnt from $TABLE where "$COLUMN" is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'tcdensitypercentage', 'select (select count(distinct("$COLUMN")) from $TABLE where "$COLUMN" is not null)*100 / (case when count(*) = 0 then 1 else count(*) end) as densitycnt from $TABLE');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'deviationrange', 'select STDEV("$COLUMN") as stddev from $TABLE  WHERE "$COLUMN" is not null');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'sumrange', 'select SUM("$COLUMN") as sum from $TABLE  WHERE "$COLUMN" is not null');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'topvaluescontains', 'SELECT "$COLUMN" , COUNT(*) AS cnt FROM $TABLE WHERE "$COLUMN" IS NOT NULL GROUP BY  "$COLUMN" ORDER BY 2 DESC');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'avgrange', 'select avg("$COLUMN") as avg from $TABLE  WHERE  "$COLUMN" is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'nulldensitypercentage', 'select count(*) as nulldensity from $TABLE  WHERE  "$COLUMN" is NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'nullcountrange', 'select count(*) as count from $TABLE  WHERE  "$COLUMN" is NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'tcnulldensitypercentage', 'select sum(case when "$COLUMN" is null then 1 else 0 end)*100 / (case when count(*) = 0 then 1 else count(*) end) as nulldensity from $TABLE');
insert into dqfunctiondefserver(servertype, type, servercode) values('postgres', 'densitypercentage', 'select COUNT(DISTINCT("$COLUMN")) as densitycnt from $TABLE where "$COLUMN" is NOT NULL');

insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'maxrange', 'select MAX(`$COLUMN`) as max from $TABLE  WHERE  `$COLUMN` is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'minrange', 'select Min(`$COLUMN`) as min from $TABLE  WHERE  `$COLUMN` is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'distinctrange', 'select COUNT(DISTINCT(`$COLUMN`)) as distcnt from $TABLE where `$COLUMN` is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'tcdensitypercentage', 'select (select count(distinct(`$COLUMN`)) from $TABLE where `$COLUMN` is not null)*100 / (case when count(*) = 0 then 1 else count(*) end) as densitycnt from $TABLE');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'deviationrange', 'select STDEV(`$COLUMN`) as stddev from $TABLE  WHERE `$COLUMN` is not null');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'sumrange', 'select SUM(`$COLUMN`) as sum from $TABLE  WHERE `$COLUMN` is not null');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'topvaluescontains', 'SELECT `$COLUMN` , COUNT(*) AS cnt FROM $TABLE WHERE `$COLUMN` IS NOT NULL GROUP BY  `$COLUMN` ORDER BY 2 DESC');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'avgrange', 'select avg(`$COLUMN`) as avg from $TABLE  WHERE  `$COLUMN` is NOT NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'nulldensityrange', 'select count(*) as nulldensity from $TABLE  WHERE  `$COLUMN` is NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'nullcountrange', 'select count(*) as count from $TABLE  WHERE  `$COLUMN` is NULL');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'tcnulldensitypercentage', 'select sum(case when `$COLUMN` is null then 1 else 0 end)*100 / (case when count(*) = 0 then 1 else count(*) end) as nulldensity from $TABLE');
insert into dqfunctiondefserver(servertype, type, servercode) values('mysql', 'densityrange', 'select COUNT(DISTINCT(`$COLUMN`)) as densitycnt from $TABLE where `$COLUMN` is NOT NULL');

INSERT INTO govern_matrix_model (model, description) VALUES ('RACI', 'Responsible, Accountable, Consulted, Informed');
INSERT INTO govern_matrix_model_role (rolename, role, description, type, multiselect) VALUES ('Responsible', 'responsible',
        'The person who does the work to achieve the task. They have responsibility for getting the work done or decision made',
        'USERS', 1);
INSERT INTO govern_matrix_model_role (rolename, role, description, type, multiselect) VALUES ('Accountable', 'accountable',
        'The person who is accountable for the correct and thorough completion of the task. This must be one person and is often the project executive or project sponsor',
        'USERS', 1);
INSERT INTO govern_matrix_model_role (rolename, role, description, type, multiselect) VALUES ('Consulted', 'consulted',
        'The people who provide information for the project and with whom there is two-way communication. This is usually several people, often subject matter experts',
        'USERS', 1);
INSERT INTO govern_matrix_model_role (rolename, role, description, type, multiselect) VALUES ('Informed', 'informed',
        'The people kept informed of progress and with whom there is one-way communication. These are people that are affected by the outcome of the tasks, so need to be kept up-to-date',
        'USERS', 1);
INSERT INTO govern_matrix_type_model_map(object_type, model_id) VALUES ('glossary', 1);

INSERT INTO govern_matrix_type_model_role_map(object_type, model_id, role_id) VALUES ('glossary', 1, 1);
INSERT INTO govern_matrix_type_model_role_map(object_type, model_id, role_id) VALUES ('glossary', 1, 2);
INSERT INTO govern_matrix_type_model_role_map(object_type, model_id, role_id) VALUES ('glossary', 1, 3);
INSERT INTO govern_matrix_type_model_role_map(object_type, model_id, role_id) VALUES ('glossary', 1, 4);


INSERT INTO version(dbversion, appversion, dbminorversion, comments) VALUES (4300, 4300, 138, 'Release 4.3');
INSERT INTO version(dbversion, appversion, dbminorversion, comments) VALUES (4310, 4310, 102, 'Release 4.3.1');
INSERT INTO version(dbversion, appversion, dbminorversion, comments) VALUES (5000, 5000, 109, 'Release 5.0');
INSERT INTO version(dbversion, appversion, dbminorversion, comments) VALUES (5100, 5100, 126, 'Release 5.1');
INSERT INTO version(dbversion, appversion, dbminorversion, comments) VALUES (5140, 5100, 50, 'Release 5.1.4');





