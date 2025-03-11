SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

mysql -h 127.0.0.1 -P 3306 -u root -proot

set autocommit=0;

use transaksjoner;

update konto set saldo=1 where kontonr=1;	
update konto set saldo=2 where kontonr=2;
update konto set saldo=1 where kontonr=2;	
update konto set saldo=2 where kontonr=1;

SELECT @@transaction_isolation;
