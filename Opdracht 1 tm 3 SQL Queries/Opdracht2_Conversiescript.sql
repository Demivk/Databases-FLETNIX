--=== Opdracht 2A t/m 2C ===--

/*	A:	MAAK ALLES LEEG	*/
USE FLETNIX
DELETE FROM Watchhistory; 
DELETE FROM Movie_Genre;
DELETE FROM Movie_Directors;
DELETE FROM Movie_Cast;
DELETE FROM Movie;
DELETE FROM Customer;
DELETE FROM Person;
DELETE FROM Payment;
DELETE FROM Genre;
DELETE FROM Country;
DELETE FROM [Contract];

/* B:	Conversie voor Parent tabbellen
&  C:	Conversie voor Child tabbellen */
USE master
RAISERROR ('Converting tables. This may take a while...', 0, 1) WITH NOWAIT

-- Contract
INSERT INTO FLETNIX.dbo.[CONTRACT]
VALUES	('Basic',	4,	0),
		('Pro',		5,	20),
		('Premium', 6,	40)
RAISERROR ('Table: Contract, has been converted', 0, 1) WITH NOWAIT

-- Country
INSERT INTO FLETNIX.dbo.Country
VALUES	('China'),
		('India'),
		('United States'),
		('Indonesia'),
		('Brazil'),
		('Russia'),
		('Japan'),
		('Mexico'),
		('Germany'),
		('France'),
		('Italy'),
		('Spain'),
		('Poland'),
		('Canada'),
		('Netherlands'),
		('Belgium'),
		('Sweden'),
		('Austria'),
		('Switzerland'),
		('Denmark')
RAISERROR ('Table: Country, has been converted', 0, 1) WITH NOWAIT

-- Genre
INSERT INTO FLETNIX.dbo.Genre(genre_name)
SELECT DISTINCT LEFT (Genre, 255) AS genre_name
FROM MYIMDB.dbo.Imported_Genre
RAISERROR ('Table: Genre, has been converted', 0, 1) WITH NOWAIT

-- Payment
INSERT INTO FLETNIX.dbo.Payment
VALUES	('Visa'),
		('Mastercard'),
		('Paypal'),
		('Ideal'),
		('Am. Ex.'),
		('Maestro'),
		('Amex'),
		('V pay')
RAISERROR ('Table: Payment, has been converted', 0, 1) WITH NOWAIT

-- Person
INSERT INTO FLETNIX.dbo.Person
SELECT	CAST (Id AS int) AS person_id,
		LEFT (FName, 50) AS firstname,
		LEFT (LName, 50) AS lastname,
		CAST (Gender AS char(1)) AS gender
FROM MYIMDB.dbo.Imported_Person
RAISERROR ('Table: Person 1/2, has been converted', 0, 1) WITH NOWAIT

INSERT INTO FLETNIX.dbo.Person
SELECT	CAST (1000000 + Id AS int) AS person_id,
		LEFT (FName, 50) AS firstname,
		LEFT (LName, 50) AS lastname,
		NULL AS gender
FROM MYIMDB.dbo.Imported_Directors
RAISERROR ('Table: Person 2/2, has been converted', 0, 1) WITH NOWAIT

-- Customer
INSERT INTO FLETNIX.dbo.Customer
VALUES	('Vivamus.rhoncus.Donec@tellus.net',				'Collier',		'Aline',		'Visa',				'630 41532 41993 762',		'Basic',	'08/08/2014','08/26/2017',	'simplifytinted,',			'ISP44zpb2ZB',	'Denmark',			'F',	'09/15/1956'),
		('nec@Nullam.edu',									'Callahan',		'Jamalia',		'Mastercard',		'67636733803341',			'Pro',		'03/24/2013','12/15/2016',	'sustaincultured.',			'WRC02uwm0WC',	'Denmark',			'M',	'01/10/1971'),
		('Phasellus.dapibus.quam@inlobortistellus.com',		'Bennett',		'Bo',			'Mastercard',		'675924 02 9180 8103 873',	'Basic',	'11/07/2013', NULL,			'timingcordial',			'TYZ67xnu4RP',	'Spain',			NULL,	'10/02/1923'),
		('feugiat.nec@ac.net',								'Haley',		'Karleigh',		'Mastercard',		'57721748308171',			'Premium',	'12/29/2013','07/30/2017',	'wingssweltering',			'VJC38jbm6CB',	'France',			NULL,	'01/21/1971'),
		('et.risus@eu.com',									'Ochoa',		'Joy',			'Mastercard',		'676301 72 1043 8755 822',	'Premium',	'02/07/2013','05/17/2015',	'smellypromethium',			'ZPK11ykg0AU',	'Austria',			'F',	'10/07/1942'),
		('Cras.eu@etmagnisdis.co.uk',						'Acevedo',		'Camden',		'Paypal',			'676360 7568166959',		'Pro',		'12/28/2014','08/15/2017',	'droningbread',				'QKS75gfm8MS',	'Japan',			'F',	'01/18/1977'),
		('cursus.Nunc.mauris@liberoduinec.com',				'Herrera',		'Zachary',		'Amex',				'6759746473995',			'Premium',	'06/15/2013','04/29/2015',	'outriggeraldine,',			'ITF53emw2XC',	'Russia',			'F',	'06/02/1911'),
		('nunc@nascetur.com',								'Romero',		'Lester',		'Amex',				'50181829246865875',		'Pro',		'02/24/2014','11/04/2015',	'bouncyfretful',			'DOB43pvk5PQ',	'India',			'F',	'04/04/1986'),
		('nisi.Aenean.eget@varius.edu',						'Long',			'Malachi',		'Am. Ex.',			'585104547535242825',		'Pro',		'02/27/2013', NULL,			'tolenscrogs,',				'HZW82gph6FZ',	'Japan',			'M',	'07/07/1998'),
		('Sed.neque@rutrum.edu',							'Pace',			'Calvin',		'Maestro',			'576753518991',				'Premium',	'11/21/2014','02/07/2016',	'conductingvanilla',		'ZUQ19acs8JD',	'Belgium',			'F',	'06/15/1900'),
		('augue.eu@enim.co.uk',								'Leonard',		'Nathan',		'Amex',				'676 30827 71229 012',		'Basic',	'09/15/2013', NULL,			'bloatedkentledge',			'KMN29ioa6CX',	'India',			'M',	'05/21/1995'),
		('dolor.Fusce@montesnasceturridiculus.net',			'Velez',		'Rhonda',		'Am. Ex.',			'67635762424482',			'Basic',	'02/17/2013','02/27/2015',	'urethradolls',				'MPV66cmo8II',	'Austria',			NULL,	'10/24/1922'),
		('lectus.Nullam.suscipit@nasceturridiculus.edu',	'Lawson',		'Basia',		'Maestro',			'6304621984038',			'Premium',	'01/16/2013','05/11/2015',	'scraperlibra',				'PGW50cey1XW',	'India',			'F',	'01/24/1943'),
		('luctus.felis.purus@enimcondimentumeget.edu',		'Lucas',		'Silas',		'Visa',				'571606335984426',			'Premium',	'04/26/2014','06/02/2017',	'helicopterhelping',		'UTK15asl7VF',	'Mexico',			NULL,	'03/28/1967'),
		('dui.augue.eu@nequeetnunc.co.uk',					'Fox',			'Carson',		'Paypal',			'56602441781137005',		'Pro',		'09/13/2013', NULL,			'hazelnutsiphone',			'MLP95kdn9XG',	'Netherlands',		'F',	'01/12/1995'),
		('felis@estarcuac.edu',								'Shelton',		'Dexter',		'Amex',				'5849 990347 35719',		'Pro',		'08/20/2013', NULL,			'tantalumretweet',			'ICR76hdl3GH',	'Denmark',			'f',	'04/17/1922'),
		('ornare@commodoipsumSuspendisse.ca',				'Ruiz',			'Blythe',		'Ideal',			'675 95766 83522 006',		'Premium',	'11/16/2013','02/09/2015',	'pastoralenchant',			'VQP14phb7EX',	'Indonesia',		NULL,	'03/01/1994'),
		('sapien.imperdiet@facilisisnonbibendum.edu',		'Lindsay',		'Keaton',		'Ideal',			'589347529390',				'Premium',	'08/06/2013','06/28/2017',	'hypothesisreduced',		'CDQ18ndm6JU',	'France',			NULL,	'05/06/1952'),
		('Aliquam.tincidunt@nibhAliquamornare.com',			'Burch',		'Lesley',		'V pay',			'6761 3197 3480 9825',		'Premium',	'09/03/2014','07/25/2016',	'thunderingsplendid',		'AZZ99qjy6CL',	'Canada',			'M',	'03/23/1955'),
		('condimentum.eget.volutpat@velitegestas.net',		'James',		'Aladdin',		'Maestro',			'630 42692 44462 215',		'Pro',		'02/24/2013','12/07/2015',	'keysalacia',				'KGW32tww2HS',	'Indonesia',		'F',	'09/15/1942'),
		('arcu@molestiearcu.edu',							'Ingram',		'Signe',		'Mastercard',		'6304 799 61 1124',			'Basic',	'05/21/2013', NULL,			'shiverlament',				'BPW53hsa7ZA',	'Russia',			NULL,	'09/26/1991'),
		('scelerisque.lorem.ipsum@primis.edu',				'Trevino',		'Ria',			'V pay',			'501877 7793391915',		'Pro',		'11/20/2014','07/10/2016',	'attacheddirector,',		'QXL09frq6DY',	'Belgium',			'M',	'06/12/1989'),
		('mauris@tellusfaucibus.edu',						'Hunt',			'Ralph',		'Ideal',			'63047978506039742',		'Basic',	'10/26/2014','11/30/2016',	'bintbleach',				'ZAD39kku9MK',	'Germany',			NULL,	'11/15/1936'),
		('in.tempus.eu@venenatislacus.ca',					'Wilder',		'Rudyard',		'V pay',			'67614496194729',			'Basic',	'12/11/2014','10/12/2015',	'beratecrummy.',			'GRF77fsd4UI',	'Japan',			'M',	'04/23/1921'),
		('non@egestasligulaNullam.ca',						'Fischer',		'Alexander',	'Am. Ex.',			'67613305624494135',		'Basic',	'08/21/2013','10/28/2017',	'suitewigeon',				'POC91kfm6YJ',	'Sweden',			NULL,	'02/08/1996'),
		('tincidunt.adipiscing.Mauris@acliberonec.co.uk',	'Nielsen',		'Jaime',		'Amex',				'676366 39 8010 0838 794',	'Premium',	'05/26/2013','09/30/2015',	'woodenfizzy',				'RQG47lnk9KS',	'Belgium',			NULL,	'02/25/1973'),
		('faucibus.lectus@Sed.ca',							'Wood',			'Sacha',		'Paypal',			'676286286804396437',		'Premium',	'04/06/2013','06/29/2015',	'estivalgrab.',				'ZHM41nic3MF',	'China',			'M',	'03/31/1974'),
		('lacus.Nulla.tincidunt@urnaconvalliserat.org',		'Callahan',		'Kirby',		'Paypal',			'67631911197155876',		'Premium',	'06/19/2014', NULL,			'celestialperiods',			'IEL71ivs6WN',	'Mexico',			NULL,	'06/23/1952'),
		('consectetuer.euismod@Curabitur.edu',				'Levine',		'Alden',		'Maestro',			'63044233044839804',		'Premium',	'01/01/2015','06/17/2016',	'kedgeobsolete',			'LIP43vim0YJ',	'Netherlands',		'F',	'03/17/1924'),
		('lorem.sit.amet@dignissimtempor.edu',				'Henderson',	'Seth',			'Mastercard',		'587843848009',				'Premium',	'08/19/2013','03/17/2017',	'coulombgiant',				'VFS11ope3FH',	'Austria',			'F',	'07/25/1983'),
		('quis.massa@molestiepharetra.com',					'Walters',		'Benjamin',		'Maestro',			'67630042852248',			'Pro',		'12/31/2013','04/01/2015',	'sombergelatin',			'ILM52dct8MT',	'Japan',			NULL,	'01/10/1910'),
		('porttitor.scelerisque@diamSed.net',				'Ford',			'Ursa',			'Maestro',			'630406173413',				'Pro',		'10/22/2013', NULL,			'conivalrestless',			'FNY07gtx4WX',	'Netherlands',		NULL,	'09/29/1947'),
		('mi.enim@congue.com',								'Whitaker',		'Stacy',		'Amex',				'67631525770129270',		'Premium',	'08/02/2014','06/15/2017',	'cootmolybdenum',			'FMY30jzk3LR',	'Germany',			'F',	'10/30/1993'),
		('erat.eget.tincidunt@massa.com',					'Riggs',		'Anjolie',		'Visa',				'6763 856 11 5768',			'Basic',	'11/29/2013', NULL,			'forcepsburkitt',			'VNR57jsm5LE',	'Indonesia',		'M',	'06/19/1905'),
		('habitant.morbi.tristique@purusmauris.edu',		'Hewitt',		'Xander',		'Am. Ex.',			'6304209481954060',			'Premium',	'01/30/2013','08/06/2016',	'chideuser',				'JEX27iwh4CE',	'France',			'M',	'10/22/1902'),
		('iaculis.enim@bibendum.net',						'Koch',			'Eagan',		'Amex',				'5687068925063512590',		'Pro',		'11/20/2013','02/03/2015',	'dolphinshops',				'BIT41xmy4EU',	'Austria',			'F',	'01/02/1900'),
		('ac.sem.ut@inhendrerit.net',						'Dyer',			'Ignatius',		'Am. Ex.',			'6761 144 96 9343',			'Premium',	'10/08/2014','06/21/2017',	'glintwrathful',			'BIK61tnj6NQ',	'United States',	'F',	'02/04/1974'),
		('dui.Cum@quamvelsapien.edu',						'Herrera',		'Martha',		'Am. Ex.',			'501806295584313497',		'Pro',		'03/06/2014','08/01/2016',	'melonclip',				'WNR58xkt0FJ',	'Indonesia',		'F',	'10/10/1994'),
		('pretium.neque@adipiscingelitCurabitur.com',		'Glenn',		'Kylynn',		'Am. Ex.',			'5018725322603',			'Basic',	'03/20/2013', NULL,			'managementalcoholic',		'MGX56hiu6BM',	'Italy',			'M',	'06/29/1979'),
		('aliquet@pede.com',								'Massey',		'Hiroko',		'Visa',				'676198 09 0668 6307 755',	'Pro',		'04/25/2013','07/18/2015',	'nutsappeal',				'DWZ72vyv0RY',	'Indonesia',		NULL,	'09/15/1974'),
		('risus@mollisDuis.com',							'Mcguire',		'Cleo',			'Visa',				'50386494693905154',		'Premium',	'12/15/2013','01/27/2015',	'pitybinge',				'OXP98jqa4VO',	'Canada',			NULL,	'08/09/1972'),
		('quam.Curabitur.vel@sitametmetus.ca',				'Robbins',		'Benjamin',		'Maestro',			'5893 569137 50829',		'Basic',	'04/03/2013','08/04/2016',	'syntaxtrivial',			'ASG68hni0MU',	'Indonesia',		NULL,	'02/25/1962'),
		('aliquet.libero@sapien.co.uk',						'Chandler',		'Demetrius',	'Amex',				'576155029878',				'Premium',	'10/10/2013','07/28/2017',	'inferiorcopper',			'WJH69aqt1RC',	'Brazil',			NULL,	'12/27/1926'),
		('dolor@placerat.org',								'Castaneda',	'Kim',			'Amex',				'5658220533355382',			'Basic',	'05/08/2014', NULL,			'puffytag',					'WZV07uot0ES',	'Sweden',			NULL,	'05/31/1939'),
		('fermentum.convallis@lobortis.net',				'Stevenson',	'Pamela',		'Ideal',			'5893193569508239',			'Pro',		'02/02/2013','05/15/2017',	'ashamedmineral',			'BVD38qvg1UJ',	'Poland',			'F',	'06/06/1927'),
		('felis@leoin.ca',									'Morton',		'Kessie',		'Amex',				'5600 902310 88389',		'Basic',	'01/21/2014','11/14/2015',	'gluttonousstilt',			'WFH78bkj7BO',	'Sweden',			'F',	'01/04/1975'),
		('lacus.Ut@malesuada.co.uk',						'Atkinson',		'Shannon',		'Am. Ex.',			'5882 643210 3793',			'Premium',	'08/17/2013','10/25/2016',	'crackerallen',				'PVD23axt7BJ',	'Switzerland',		NULL,	'05/04/1995'),
		('non.luctus.sit@sedconsequatauctor.org',			'Delgado',		'Burke',		'Amex',				'574587972773',				'Pro',		'06/12/2014','05/08/2017',	'trigmolarity',				'XJL28fjb7TZ',	'Austria',			'F',	'03/16/1911'),
		('aliquam.adipiscing.lacus@sitamet.co.uk',			'Blevins',		'Magee',		'Amex',				'5893967399798940698',		'Basic',	'11/09/2013','09/03/2017',	'quailsquish',				'WKK85enu6DH',	'Sweden',			'M',	'09/27/1996'),
		('Aenean@nuncid.co.uk',								'Stark',		'Yasir',		'Am. Ex.',			'676106895647061301',		'Basic',	'09/14/2014', NULL,			'crakeclaw',				'XMT61krg0UD',	'France',			'F',	'08/30/1924'),
		('diam.vel@utlacus.net',							'Kennedy',		'Jasper',		'Amex',				'6304633036670198141',		'Basic',	'07/03/2014','03/05/2017',	'moneydegree',				'LIS84ern1VI',	'Austria',			'M',	'01/13/1943'),
		('at@vel.ca',										'Dawson',		'Ingrid',		'Am. Ex.',			'5611 836984 07397',		'Premium',	'05/24/2013','03/24/2016',	'bombspica',				'RSP05wcd2OK',	'Italy',			'F',	'12/22/1976'),
		('at.pretium.aliquet@euelit.net',					'Goodwin',		'Teagan',		'Am. Ex.',			'5657454765455500',			'Basic',	'08/09/2014','10/30/2015',	'cornaxe',					'JBN63dlu9CN',	'Italy',			'M',	'10/15/1929'),
		('velit.dui.semper@eu.co.uk',						'Pace',			'Sandra',		'Visa',				'5790 609883 7818',			'Basic',	'01/26/2013','04/25/2017',	'audioclicking',			'AYV95rqe3PF',	'China',			'F',	'05/22/1928'),
		('Sed.eu@Integerin.co.uk',							'Miranda',		'Macy',			'Mastercard',		'630424919472431',			'Pro',		'10/11/2013', NULL,			'whizzthing.',				'MYJ83bcl1QA',	'China',			NULL,	'12/14/1998'),
		('nunc@Cum.co.uk',									'Marshall',		'Candice',		'Ideal',			'50387603915180482',		'Basic',	'08/07/2014','11/02/2016',	'enunciateloud',			'RMY19snc4TK',	'Japan',			'F',	'02/26/1958'),
		('turpis.Nulla@Morbisitamet.org',					'Hicks',		'Carson',		'Am. Ex.',			'501881298023436299',		'Premium',	'04/19/2013','05/12/2015',	'incredibletemple',			'VFN96dyo1CT',	'Sweden',			'F',	'12/07/1974'),
		('sit@vitae.com',									'Castaneda',	'Rajah',		'Maestro',			'589314687068563',			'Pro',		'09/16/2014','09/04/2017',	'responsepicky',			'OYB24gyb7LP',	'Austria',			'F',	'03/06/1945'),
		('eros.Nam.consequat@dapibus.net',					'Austin',		'Eric',			'Mastercard',		'58936754825699',			'Premium',	'10/07/2013', NULL,			'duniteretrograde,',		'CGP80ngn6UB',	'United States',	'M',	'12/02/1930'),
		('eu.ligula@placerat.ca',							'Spencer',		'Carissa',		'Paypal',			'589300397319628',			'Pro',		'07/14/2014','08/21/2017',	'blotweirdo',				'UOS67uxb3KX',	'Netherlands',		NULL,	'03/01/1961'),
		('ullamcorper@molestiepharetra.ca',					'Albert',		'Aladdin',		'Mastercard',		'67614210811004',			'Premium',	'11/02/2013','04/03/2015',	'unaffectedleo',			'NHD85fut8BT',	'Switzerland',		'M',	'02/28/1939'),
		('mauris.Integer.sem@euismodestarcu.ca',			'Allison',		'Yoshio',		'Ideal',			'56302793818291798',		'Premium',	'01/08/2013','07/30/2015',	'skatespast',				'DWW95owd7VI',	'Canada',			'F',	'10/31/1919'),
		('montes.nascetur@Pellentesquehabitant.org',		'Nelson',		'Lilah',		'V pay',			'501865556431326216',		'Basic',	'04/24/2013','02/14/2016',	'hayinventory',				'MKD37ame5IU',	'Belgium',			NULL,	'12/24/1937'),
		('velit.justo.nec@rhoncusid.com',					'Flynn',		'Jeanette',		'Amex',				'560501525627377958',		'Pro',		'03/11/2014', NULL,			'mushyartlesss,',			'TIS92pxl1FW',	'Germany',			'F',	'04/19/1963'),
		('Proin.velit.Sed@massarutrum.com',					'Simmons',		'Lynn',			'Mastercard',		'58932521450236027',		'Premium',	'03/29/2013', NULL,			'smashmechanics',			'JYD04teg6ER',	'Germany',			'M',	'07/31/1966'),
		('Nunc.laoreet@necquam.ca',							'Head',			'Palmer',		'V pay',			'588350964288',				'Basic',	'09/24/2013','09/28/2015',	'phoenixpedant',			'NJY56evj0EJ',	'Belgium',			NULL,	'12/03/1907'),
		('nunc.Quisque.ornare@facilisiseget.ca',			'Butler',		'Remedios',		'Amex',				'676376431778499673',		'Premium',	'11/13/2013','04/02/2015',	'tabernaclesoothe',			'KUX06llh9XU',	'Russia',			'F',	'07/31/1959'),
		('non.feugiat@ultricesmauris.edu',					'Collins',		'Kelly',		'Maestro',			'5869 0910 8416 6253',		'Basic',	'02/10/2014','09/07/2017',	'pistonpastoral',			'IDX31pis7PI',	'Germany',			'M',	'11/11/1961'),
		('interdum.ligula@tristique.com',					'Craft',		'Oleg',			'Maestro',			'57461411022349931',		'Pro',		'06/14/2013','06/11/2017',	'dashcultivated',			'YMS15nok2TF',	'France',			'M',	'10/04/1981'),
		('magna@consectetuerrhoncus.edu',					'White',		'Thor',			'Paypal',			'576739817160',				'Premium',	'01/14/2014','06/21/2016',	'harmfulretina',			'YVS02vfc7VF',	'Denmark',			'F',	'05/15/1981'),
		('venenatis.lacus.Etiam@magnamalesuada.org',		'Silva',		'Maxwell',		'Am. Ex.',			'50385034092330355',		'Premium',	'09/27/2013','11/01/2017',	'phobosalkyne',				'NJZ04evu2FA',	'China',			'M',	'02/19/1955'),
		('Curabitur@magnaPhasellus.net',					'Horn',			'Alice',		'Maestro',			'5741297412382694',			'Premium',	'12/09/2014','04/14/2016',	'pryplayers,',				'YWJ31mud1RQ',	'Italy',			'F',	'05/31/1987'),
		('urna.justo@fringillaornareplacerat.edu',			'Kidd',			'Jared',		'V pay',			'676249784221',				'Pro',		'04/30/2014','03/05/2017',	'fanfaretelrad',			'ZTF85fie3KT',	'Russia',			'M',	'05/14/1928'),
		('sed.dui.Fusce@et.edu',							'Tucker',		'Flavia',		'Maestro',			'676156 55 7233 1900 858',	'Premium',	'12/27/2014', NULL,			'twotinosvulnerable',		'ZGG33aws5VC',	'Sweden',			'M',	'07/07/1932'),
		('Suspendisse@quis.com',							'Camacho',		'Chantale',		'Visa',				'6759917271218047',			'Basic',	'06/28/2014','11/02/2016',	'talkingyttrium.',			'JZX06wiz0LX',	'Indonesia',		'F',	'10/10/1989');
RAISERROR ('Table: Customer, has been converted', 0, 1) WITH NOWAIT

-- Movie
INSERT INTO FLETNIX.dbo.Movie (movie_id, title, publication_year, price)
SELECT	CAST (Id AS int) AS movie_id,
		LEFT ([Name], 255) AS title,
		LEFT ([Year], 255) AS publication_year,
		(imported_movie.id%15+5)*0.25 as price
FROM MYIMDB.dbo.Imported_Movie
RAISERROR ('Table: Movie, has been converted', 0, 1) WITH NOWAIT

-- Movie Cast
INSERT INTO FLETNIX.dbo.Movie_cast
SELECT	DISTINCT 
		CAST (Mid AS int) AS movie_id,
		CAST (Pid AS int) AS person_id,
		LEFT ([Role], 255) AS [role]
FROM MYIMDB.dbo.Imported_Cast
RAISERROR ('Table: Movie Cast, has been converted', 0, 1) WITH NOWAIT

-- Movie directors
INSERT INTO FLETNIX.dbo.Movie_directors
SELECT	CAST (Mid AS int) AS movie_id,
		CAST (1000000 + Did AS int) AS person_id
FROM MYIMDB.dbo.Imported_Movie_Directors
RAISERROR ('Table: Movie Directors, has been converted', 0, 1) WITH NOWAIT

-- Movie Genre
INSERT INTO FLETNIX.dbo.Movie_genre
SELECT	DISTINCT
		CAST (Id AS int) AS movie_id,
		LEFT (Genre, 255) AS genre_name
FROM MYIMDB.dbo.Imported_Genre
RAISERROR ('Table: Movie Genre, has been converted', 0, 1) WITH NOWAIT

-- WatchHistory 
INSERT INTO FLETNIX.dbo.Watchhistory
VALUES	(278016,	'fermentum.convallis@lobortis.net',				'03/10/2017', 3.25, 0),
		(278016,	'sit@vitae.com',								'08/29/2015', 2.75,	0),
		(291659,	'quam.Curabitur.vel@sitametmetus.ca',			'07/19/2016', 3.50,	1),
		(136334,	'nec@Nullam.edu',								'10/18/2015', 4.75,	0),
		(220162,	'sit@vitae.com',								'01/17/2015', 3.00, 1),
		(335066,	'eu.ligula@placerat.ca',						'09/03/2014', 4.00, 0),
		(375626,	'aliquam.adipiscing.lacus@sitamet.co.uk',		'08/25/2017', 4.00, 1),
		(174816,	'venenatis.lacus.Etiam@magnamalesuada.org',		'12/22/2013', 2.75, 1),
		(212810,	'augue.eu@enim.co.uk',							'10/16/2016', 2.50, 0),
		(136606,	'Suspendisse@quis.com',							'06/04/2016', 1.50, 0),
		(141162,	'Proin.velit.Sed@massarutrum.com',				'08/31/2014', 1.75, 1),
		(329855,	'quam.Curabitur.vel@sitametmetus.ca',			'04/28/2014', 2.50, 1),
		(127508,	'aliquet.libero@sapien.co.uk',					'04/28/2015', 3.25, 1),
		(190675,	'arcu@molestiearcu.edu',						'10/17/2013', 3.75, 0),
		(325149,	'arcu@molestiearcu.edu',						'08/29/2014', 3.50, 0),
		(337528,	'risus@mollisDuis.com',							'09/17/2014', 4.50, 1),
		(157815,	'luctus.felis.purus@enimcondimentumeget.edu',	'07/10/2014', 2.50, 0),
		(369267,	'pretium.neque@adipiscingelitCurabitur.com',	'04/18/2017', 4.25, 1),
		(179069,	'lectus.Nullam.suscipit@nasceturridiculus.edu',	'01/28/2013', 2.25, 1),
		(316100,	'lacus.Ut@malesuada.co.uk',						'01/10/2015', 4.75, 0),
		(241253,	'Aenean@nuncid.co.uk',							'11/20/2016', 3.25, 0),
		(237877,	'eros.Nam.consequat@dapibus.net',				'01/01/2015', 3.00, 0),
		(159745,	'non@egestasligulaNullam.ca',					'06/29/2016', 3.75, 1),
		(102048,	'velit.dui.semper@eu.co.uk',					'04/29/2014', 2.00, 1),
		(363290,	'velit.dui.semper@eu.co.uk',					'10/24/2014', 2.50, 0),
		(274143,	'habitant.morbi.tristique@purusmauris.edu',		'12/17/2014', 4.50, 0),
		(210958,	'lacus.Nulla.tincidunt@urnaconvalliserat.org',	'12/14/2016', 4.50, 0),
		(359889,	'dui.augue.eu@nequeetnunc.co.uk',				'07/03/2014', 3.50, 0),
		(174046,	'sed.dui.Fusce@et.edu',							'03/22/2016', 1.50, 0),
		(103652,	'dolor@placerat.org',							'04/13/2016', 1.75, 1),
		(166211,	'fermentum.convallis@lobortis.net',				'10/07/2014', 4.00, 0),
		(332994,	'nisi.Aenean.eget@varius.edu',					'01/05/2014', 3.50, 1),
		(140537,	'diam.vel@utlacus.net',							'05/12/2015', 1.75, 1),
		(122729,	'sed.dui.Fusce@et.edu',							'12/22/2016', 4.75, 0),
		(297663,	'nisi.Aenean.eget@varius.edu',					'10/28/2015', 4.50, 0);
RAISERROR ('Table: Watchhistory, has been converted', 0, 1) WITH NOWAIT