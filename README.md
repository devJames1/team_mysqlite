# Welcome to My Sqlite
***
This is a program that filters data from a database using a custom class called MySQLiteRequest, which behaves like a SQLite database.

## Task
create MySqlite that can:

* Filters data from a database using a custom class
* Mimics the behavior of a real SQLite database
* Easy to use Command Line Interface (CLI)


## Description

#### Custom Class MySQLiteRequest
This class is used to filter data from the database. It has various methods to perform operations like SELECT, FROM, WHERE, JOIN, ORDER, INSERT, UPDATE, DELETE, just like in a real SQLite database. 

* SELECT options
  * `my_sqlite_cli> SELECT lastname FROM db.csv;    [JOIN user_id=id]`
  * `my_sqlite_cli> SELECT lastname, firstname FROM db.csv WHERE lastname=Laura;`
  * `my_sqlite_cli> SELECT lastname, age FROM db.csv ORDER age ASC;`
  * `my_sqlite_cli> SELECT * FROM tb.csv JOIN tb_join.csv ON col=col_join;`
* INSERT options
  * `my_sqlite_cli> INSERT db.csv VALUES lastname=Aaaa firstname=Bbbb age=11 state=AA;`
* UPDATE options
  * `my_sqlite_cli> UPDATE db.csv SET firstname=UPDATED WHERE firstname=Grey;`
  * `my_sqlite_cli> UPDATE db.csv SET firstname=UPDATED; (will update every record in a table)`
* DELETE options
  * `my_sqlite_cli> DELETE FROM db.csv WHERE lastname=Jamie;` 
  * `my_sqlite_cli> DELETE FROM db.csv; (will delete every record in a table)`
* To quit CLI
  * `my_sqlite_cli> quit`

**run()** returns an instance of my_sqlite_request that builds the request progressively.


## Installation
Clone this repository to your local machine and use as described in Usage section

## Usage

```
request = MySqliteRequest.new
request = request.from('table_name')
request = request.select('column')
request = request.where('column', 'value')
request.run

OR

MySqliteRequest('table_name').select('column').where('column', 'value').run
```

### The Core Team
