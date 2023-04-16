--soal 1

SELECT DISTINCT kota 
FROM rakamin_customer_address
ORDER BY kota;

--soal 2

SELECT *
FROM rakamin_order
ORDER BY tanggal_pembelian DESC
LIMIT 10;

--soal 3

SELECT id_pelanggan,nama,email,telepon,umur,bulan_lahir,tanggal_registrasi,penipu
FROM rakamin_customer
WHERE penipu = 1;

--soal 4

SELECT *
FROM rakamin_order
WHERE lower(metode_bayar) = 'shopeepay'
ORDER BY kuantitas DESC;

--soal 5

CREATE TABLE IF NOT EXISTS 
rakamin_customer_address_tangerang  
AS (
	SELECT * FROM rakamin_customer_address 
	WHERE kota = 'Tangerang'
);

SELECT *
FROM rakamin_customer_address_tangerang;

--soal 6

-- UPDATE 1

UPDATE rakamin_customer_address_tangerang
SET provinsi ='Banten'
WHERE kota = 'Tangerang';


-- UPDATE 2

UPDATE rakamin_customer_address_tangerang
SET alamat = 'Karawaci'
WHERE id_pelanggan = 10;

SELECT * FROM rakamin_customer_address_tangerang;

-- soal 7

INSERT INTO rakamin_customer_address_tangerang
VALUES (
	101,70,'Ciledug','Tangerang','Banten'
);

SELECT * FROM rakamin_customer_address_tangerang;

--soal 8

DELETE FROM rakamin_customer_address_tangerang
WHERE id_alamat = 54;

SELECT * FROM rakamin_customer_address_tangerang;
