[library(prosqlite)].

% Step by Step "How to run":
% 1. [library(prosqlite)].
% 2. createConnection('family').
% 3. runTestQueries().

% More info about using prosqlite in docs:
% http://www.swi-prolog.org/pack/file_details/prosqlite/doc/prosqlite.html

createConnection(DBName) :- 
    sqlite_version(Version, _),
    write('SQLite Driver version: '),
    writeln(Version),
    sqlite_connect(DBName, sqlConn),
    sqlite_query(sqlConn, "SELECT 'OK';", IsSuccesConnected),
    write('Connection status to SQLite DB: '),
    writeln(IsSuccesConnected), 
    writeln('Now u can use \'sqlConn\' for queries.'), !.


query("SELECT * FROM person;").
query("SELECT name FROM person WHERE father_id = 3 AND person_id <> 7;").
query("SELECT name, person_id FROM person WHERE father_id = 5 AND gender = 2;").

query("SELECT \"person\".\"name\" FROM person INNER JOIN family_relation ON \"family_relation\".\"husband_id\"=\"person\".\"person_id\";").

query("SELECT * FROM person WHERE person_id = 8;").
query("UPDATE person SET name='NEW GRIGORIY NAME' WHERE person_id = 8;").
query("SELECT * FROM person WHERE person_id = 8;").

query("INSERT INTO person (name, gender) VALUES ('Stepa', 1);").
query("SELECT * FROM person WHERE name = 'Stepa';").

query("DELETE FROM person WHERE name = 'Stepa';").
% query("SELECT * FROM person;").

writeRows([]) :- writeln('No more rows to fetch.').
writeRows([Head | Tail]) :- writeln(Head), writeRows(Tail).

runTestQueries() :- 
    query(SQL),
    writeln('\n\nExecuting SQL query:'),
    writeln(SQL),
    bagof(Result, sqlite_query(sqlConn, SQL, Result), Y),
    writeln('\nResult:'),
    writeRows(Y),
    writeln('-----').
