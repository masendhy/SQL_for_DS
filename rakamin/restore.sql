--
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE tutorial;
--
-- Name: tutorial; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE tutorial WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE tutorial OWNER TO postgres;

\connect tutorial

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: rakamin_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rakamin_customer (
    index bigint,
    id_pelanggan bigint,
    nama text,
    email text,
    telepon text,
    umur bigint,
    bulan_lahir text,
    tanggal_registrasi timestamp without time zone,
    konfirmasi_telepon bigint,
    penipu bigint,
    pengguna_aktif bigint
);


ALTER TABLE public.rakamin_customer OWNER TO postgres;

--
-- Name: rakamin_customer_address; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rakamin_customer_address (
    index bigint,
    id_alamat bigint,
    id_pelanggan bigint,
    alamat text,
    kota text,
    provinsi text
);


ALTER TABLE public.rakamin_customer_address OWNER TO postgres;

--
-- Name: rakamin_merchant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rakamin_merchant (
    index bigint,
    id_merchant bigint,
    nama_merchant text,
    tanggal_registrasi timestamp without time zone
);


ALTER TABLE public.rakamin_merchant OWNER TO postgres;

--
-- Name: rakamin_order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rakamin_order (
    index bigint,
    id_order bigint,
    id_pelanggan bigint,
    id_merchant bigint,
    tanggal_pembelian timestamp without time zone,
    kuantitas bigint,
    harga bigint,
    "PPN" double precision,
    bayar_cash bigint,
    metode_bayar text
);


ALTER TABLE public.rakamin_order OWNER TO postgres;

--
-- Data for Name: rakamin_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rakamin_customer (index, id_pelanggan, nama, email, telepon, umur, bulan_lahir, tanggal_registrasi, konfirmasi_telepon, penipu, pengguna_aktif) FROM stdin;
\.
COPY public.rakamin_customer (index, id_pelanggan, nama, email, telepon, umur, bulan_lahir, tanggal_registrasi, konfirmasi_telepon, penipu, pengguna_aktif) FROM '$$PATH$$/3321.dat';

--
-- Data for Name: rakamin_customer_address; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rakamin_customer_address (index, id_alamat, id_pelanggan, alamat, kota, provinsi) FROM stdin;
\.
COPY public.rakamin_customer_address (index, id_alamat, id_pelanggan, alamat, kota, provinsi) FROM '$$PATH$$/3322.dat';

--
-- Data for Name: rakamin_merchant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rakamin_merchant (index, id_merchant, nama_merchant, tanggal_registrasi) FROM stdin;
\.
COPY public.rakamin_merchant (index, id_merchant, nama_merchant, tanggal_registrasi) FROM '$$PATH$$/3324.dat';

--
-- Data for Name: rakamin_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rakamin_order (index, id_order, id_pelanggan, id_merchant, tanggal_pembelian, kuantitas, harga, "PPN", bayar_cash, metode_bayar) FROM stdin;
\.
COPY public.rakamin_order (index, id_order, id_pelanggan, id_merchant, tanggal_pembelian, kuantitas, harga, "PPN", bayar_cash, metode_bayar) FROM '$$PATH$$/3323.dat';

--
-- Name: ix_rakamin_customer_address_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rakamin_customer_address_index ON public.rakamin_customer_address USING btree (index);


--
-- Name: ix_rakamin_customer_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rakamin_customer_index ON public.rakamin_customer USING btree (index);


--
-- Name: ix_rakamin_merchant_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rakamin_merchant_index ON public.rakamin_merchant USING btree (index);


--
-- Name: ix_rakamin_order_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_rakamin_order_index ON public.rakamin_order USING btree (index);


--
-- PostgreSQL database dump complete
--

