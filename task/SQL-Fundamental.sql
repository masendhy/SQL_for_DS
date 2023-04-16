--1. CREATE adalah klausula untuk mebuat tabel baru, klausla IF NOT EXIST akan menskip error jika tabel yang akan dibuat ternyata sudah ada, kemudian melanjutkannya ke proses selanjutnya.
---example :
--- CREATE TABLE IF NOT EXISTS table_name(
	--column_1 data_type [constrains],
	--column_2 data_type [constrains],
	--dst
)

	CREATE TABLE IF NOT EXISTS rakamin_merchandise_active (
		id_merchant int primary key not null,
		merchant_name varchar unique
	) 
	
--- membuat tabel baru dari tabel yang sudah ada menggunakan klausula as :

create table rakamin_merchant_2 as 
select * from rakamin_merchant where pengguna_aktif = 1

--2. SELECT digunakan untuk memilh kolom yang akan ditampilkan dalam tabel

--- mengambil dan menampilkan seluruh data dengan select *
--- example :
select * from rakamin_cutomer

--- mengambil dan menampilkan beberapa data saja
---example :
select 
	kolom_1,
	kolom_2,
	kolom_3
from rakamin_customer

--3. LIMIT digunakan untuk membatasijumlah baris / row yang akan ditampilkan

--- example : ( mengambil 10 data teratas dari tabel rakamin_customer)
select * 
from rakamin_customer
limit 10

---melakukan pembatasan setelah baris tertentu dengan menambahkan OFFSET

---example : ( mengambil 10 data setelah baris ke 3 dari tabel rakamin_customer / data pada row 4 sampai dengan row 14 )
select *
from rakamin_customer
limit 10 OFFSET 3

