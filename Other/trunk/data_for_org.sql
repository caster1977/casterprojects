DROP TABLE IF EXISTS _org;
CREATE TABLE _org (
  org_id smallint(5) unsigned NOT NULL auto_increment,
  org_erased enum('0','1') NOT NULL default '0',
  _org_type text NOT NULL,
  _org_name text NOT NULL,
  _org_address text NOT NULL,
  org_firm_code int(10) unsigned default NULL,
  org_how_to_reach text NOT NULL,
  org_work_time text NOT NULL,
  org_other_info mediumtext NOT NULL,
  org_other_info_rtf mediumblob,
  org_created_at datetime NOT NULL default '0000-00-00 00:00:00',
  org_created_by_user_id tinyint(3) unsigned NOT NULL default '0',
  org_modified_at datetime NOT NULL default '0000-00-00 00:00:00',
  org_modified_by_user_id tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (org_id),
  UNIQUE KEY org_id (org_id),
  KEY org_erased (org_erased),
  KEY org_created_at (org_created_at),
  KEY org_created_by_user_id (org_created_by_user_id),
  KEY org_modified_at (org_modified_at),
  KEY org_modified_by_user_id (org_modified_by_user_id)
) TYPE=MyISAM COMMENT='Таблица организаций для версии 4.0';
INSERT INTO rne3._org
SELECT
	a.id,
	"0",
	b.organizationtype,
	a.organizationname,
	a.organizationaddress,
	NULL,
	a.organizationhowtoreach,
	'',
	a.organizationinfo,
	NULL,
	"00000000000000",
	"6",
	a.LMTS,
	"6"
FROM rne.organizationnames a LEFT JOIN rne.organizationtypes b ON b.id=a.organizationtypeid
ORDER BY a.id;
