# What is PostgreSQL?
PostgreSQL is a powerful, open-source, object-relational database system used for storing, searching, analyzing and securely managing data. 
It’s open source and used for small to large application data storage.

# What is the purpose of a database schema in PostgreSQL?
Schema is a logical group or folder that stays inside a database and helps organize various database objects, tables, views, functions, indexes, etc. in an organized manner.

# Explain the Primary Key and Foreign Key concepts in PostgreSQL.
<strong>Primary key</strong>  is a column or set of columns that makes each row in a table unique and identifiable. Each row has only one primary key. The primary key should not be null. Every primary key defines every row separately.</br></br>
<strong>Foreign key</strong> is a column or set of columns that is the primary key of another table and establishes a relationship with other tables.

# What is the difference between the VARCHAR and CHAR data types?
In PostgreSQL, both `VARCHAR(n)` and `CHAR(n)` are used to store character strings. However, they behave differently in terms of storage, padding, and use cases.

---

## 📊 Comparison Table

| Feature            | `VARCHAR(n)`                                      | `CHAR(n)`                                           |
|--------------------|---------------------------------------------------|-----------------------------------------------------|
| **Length**         | Stores up to `n` characters (variable length)     | Always stores exactly `n` characters (fixed length) |
| **Padding**        | No padding — only actual input is stored          | Pads with spaces if input is shorter than `n`       |
| **Storage**        | Uses space as needed                              | Always allocates full length with padding           |
| **Performance**    | Some slower for large data                    | Its faster for fixed-length fields             |
| **Use Case**       | Names, emails, addresses (variable length)        | Codes, flags, IDs (fixed length)                    |

---

### ✅ Example

### Using `VARCHAR`:

```sql
CREATE TABLE users (
    name VARCHAR(50) -- Allows names up to 50 characters
);
```


# Explain the purpose of the WHERE clause in a SELECT statement.
<strong>WHERE:</strong> In a SELECT statement WHERE clause is used to filter SQL data. It helps to select only those rows that meet the criteria defined in the condition.