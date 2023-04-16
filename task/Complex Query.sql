--Alias merupakan teknik untuk memberikan nama sementara pada tabel atau kolom
-- example :
select 
	case 
		when umur between 0 and 12 then ' Anak-anak'
		when umur <= 18 then 'Remaja'
		when umur <= 50 then ' Dewasa'
		else 'Lansia'
	end as grup_umur,
	sum ( case when pengguna_aktif = 0 then 1 else 0 end) as total_pengguna_nonaktif,
	sum ( case when pengguna_aktif = 1 then 1 else 0 end) as total_pengguna_aktif
from rakamin_customer as rc
group by 1;


--tips alias (hindari menggunakan nama alias dg keyword dr SQL, hindari penggunaan nama yg sama dg nama kolom/tabel,subquery lain, hindari menggunakan spasi) :

select
	rc.nama
from 
	rakamin_customer as rc;
	
--Subquery :query didalam query. 

--1. Subquery : From (sebagai tabel virtual/sementara),subquery From Clouses harus memiliki Alias
--example :

select
	case when telepon::text like '62852%' then 'Telkomsel'
		 when telepon::text like '62878%' then 'XL'
		 when telepon::text like '62896%' then '3'
		 else 'Lainnya'
	end as provider,
	count (1) as total_pelanggan
from rakamin_customer
group by 1
having count(1) >= 20;

-- karena where tidak dapat menerima fungsi agregasi, maka gunakan having

-- kita jadikan query diatas sbg subquery :

select * from
(
	select
		case when telepon::text like '62852%' then 'Telkomsel'
			 when telepon::text like '62878%' then 'XL'
			 when telepon::text like '62896%' then '3'
			 else 'Lainnya'
		end as provider,
		count (1) as total_pelanggan
	from rakamin_customer
	group by 1) as subq
where total_pelanggan >= 20;

--2.Subquery : Where (Filtering),tidak membutuhkan Alias 

--example : Ambil data customer yang pernah melakukan order di KFC
--1. Cek id_merchant KFC pada tabel rakamin_merchant

select * from rakamin_merchant;

	--didapat id_merchant KFC adalah 5

--2. Cek customer yang pernah order KFC pada tabel rakamin_order, tanpa duplikat

select distinct id_pelanggan
from rakamin_order
where id_merchant = 5;

--3. Gunakan query no.2 sebagai subquery : WHERE untuk mendapatkan jawaban soal :

select nama,telepon
from rakamin_customer
where id_pelanggan in (
	select distinct id_pelanggan
	from rakamin_order
	where id_merchant = 5
);


--JOIN adalah proses menggabungkan kolom dengan baris yang sama antara 2 tabel, gunakan alias nama tabel dalam meyebutkan kolom.

--1. INNER JOIN : Hanya mencocokkan dan menampilkan data yang sama antara 2 tabel
--2. LEFT JOIN : Menampilkan semua data ditabel sebelah kiri, dan data yang cocok di sebeah kanan
--3. RIGHT JOIN : Menampilkkan semua data ditabel sebelah kanan, dan data yang cocok ditabel sebelah kiri
--4. FULL OUTER JOIN : Menampilkan semau data baik ketika ada yang cocok antara kedua tabel ataupun tidak 

--example :

select 
	 rc.nama,
	 rc.telepon,
	 rca.alamat,
	 ro.tanggal_pembelian
from rakamin_customer as rc
join rakamin_customer_address as rca 
 	on rc.id_pelanggan = rca.id_pelanggan 
left join rakamin_order as ro
	on ro.id_pelanggan  = rc.id_pelanggan
where telepon::text like '62852%';

--Menggunakan Subquery dan JOIN
--example : ambil data customer dengan total belanja lebih dari 50000


--1. Ambil data order diatas 50000 dari tabel rakamin_order
--2. Tampilkan data customer dan JOIN-kan tabel diatas dengan tabel rakamn_customer


select
	rc.id_pelanggan,
	rc.nama,
	rc.telepon,
	tmp.total_belanja
from 
(
	select 
	id_pelanggan,
	sum(harga) as total_belanja
from rakamin_order
group by 1
having sum(harga) > 50000
)tmp
left join rakamin_customer rc
	on rc.id_pelanggan = tmp.id_pelanggan;
	
--JOIN untuk menampilkan data null

select 
	rc.id_pelanggan,
	rc.nama,
	rc.telepon,
	ro.tanggal_pembelian
from rakamin_customer rc
left join rakamin_order ro
on rc.id_pelanggan =ro.id_pelanggan
where ro.id_pelanggan is null;

--FULL OUTER JOIN

create table ovo_users as
	select id_pelanggan, round(avg(harga)) as avg_ovo_trx
	from rakamin_order
	where metode_bayar = 'ovo'
group by 1;

select * from ovo_users;

-------------------

create table gopay_users as
	select id_pelanggan, round(avg(harga)) as avg_gopay_trx
	from rakamin_order
	where metode_bayar = 'gopay'
group by 1;

select * from gopay_users;

------------

select --- gunakan coalesce untuk mengisi value null nya
	coalesce(ov.id_pelanggan, gp.id_pelanggan) as id_pel,
	ov.avg_ovo_trx,
	gp.avg_gopay_trx
from ovo_users ov
full outer join gopay_users gp
	on ov.id_pelanggan = gp.id_pelanggan
	
---untuk mendapatkan data customer yang hanya menggunakan salah satu dari ovo / gopay saja

where avg_ovo_trx is null or avg_gopay_trx is null

---UNION : untuk menggabungkan dua atau lebih hasil query dari sebuah tabel
--syarat UNION : 1. semua kolom yang digunakan antara tabel a dan b harus sama
			  -- 2. tipe data dari kolom yang digunakan harus sama
			  -- 3. urutan kolom harus sama
--jenis UNION : 1. UNION : mengembalikan data secara distinct
			 -- 2. UNION ALL : mengembalikan data secara duplikat ( jika ada ) 
--example : 

select nama, email, telepon
from rakamin_customer
where umur > 20

UNION 

select nama, email, telepon
from rakamin_customer
where bulan_lahir = 'Mei'

--- Membuat temporary table dengan WITH nama_tabel_sementara1 AS( ),nama_tabel_sementara2 AS() ...dst
--example :

with tmp as (
select 
	id_pelanggan,
	round(sum(harga)) as total_transaksi
from rakamin_order
group by 1
having round(sum(harga)) > 50000
)

select * 
from tmp
left join rakamin_customer rc on rc.id_pelanggan = tmp.id_pelanggan;