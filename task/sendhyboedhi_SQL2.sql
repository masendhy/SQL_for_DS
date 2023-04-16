--soal 1 :
select 
	rc.nama,
	rc.email,
	rc.bulan_lahir,
	rc.tanggal_registrasi
from rakamin_customer rc
where (email like '%yahoo%' or email like '%roket%') and
 	  (bulan_lahir in ('Januari', 'Februari','Maret')) and
	  (tanggal_registrasi between '2012-01-01' and '2012-03-31')

--soal 2 :
select
	id_order,
	id_pelanggan,
	harga,
	round (harga * ppn) as harga_setelah_ppn,
	case when (harga + (harga*ppn)) <= 20000 then 'LOW'
		 when (harga + (harga*ppn)) <= 50000 then 'MEDIUM'
		 when (harga + (harga*ppn)) > 50000 then 'HIGH'
	end as spending_bucket
from rakamin_order
group by id_order,id_pelanggan,harga,ppn,kuantitas
order by harga_setelah_ppn desc

--soal 3 :
select 
	id_merchant,
	count(id_order) as jumlah_order,
	sum(harga) as jumlah_pendapatan
from rakamin_order
group by 1
order by jumlah_pendapatan desc

--soal 4 :
select
	metode_bayar,
	count(1) as frekuensi
from rakamin_order
group by 1
having count (1)> 10
order by frekuensi desc

--soal 5 :
select 
	min(jumlah_pelanggan) as populasi_pelanggan_terkecil,
	max(jumlah_pelanggan) as populasi_pelanggan_terbesar

from
(
	select 
		kota,
		count(1) as jumlah_pelanggan
	from rakamin_customer_address
	group by 1
)subq

--soal 6 :
select 
	rm.nama_merchant,
	metode_bayar,
	count(1) as frekuensi
from
	(select 
	 	id_merchant,
	 	nama_merchant
	from rakamin_merchant) rm

left join rakamin_order ro on ro.id_merchant = rm.id_merchant
group by metode_bayar, nama_merchant
order by nama_merchant


--soal 7:
with tmp as
(
select 
	id_pelanggan,
	sum(kuantitas) as total_kuantitas
from rakamin_order
group by 1
having sum(kuantitas) > 5
)

select 
	tmp.id_pelanggan,
	tmp.total_kuantitas,
	rc.nama,
	rc.email
from tmp
join rakamin_customer rc on rc.id_pelanggan = tmp.id_pelanggan
order by total_kuantitas