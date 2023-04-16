-- Mini Quiz SQL 2
--No 1

select nama, telepon,
case when cast (telepon as text) like '62852%' then 'Telkomsel' 
	when telepon::text like '62896%' then '3'
	else 'Lainnya'
	end as provider

from rakamin_customer
order by provider;

--No. 2
select *
where transaksi >= 50000 and transaksi <= 100000

--no. 3
0

--No. 4
select 
	metode_bayar,
	round(avg(harga)) as trans_rata
from rakamin_order
group by metode_bayar

