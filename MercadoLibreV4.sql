PGDMP          2                z            MercadoLibrev2    14.2    14.2 .    ,           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            -           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            .           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            /           1262    19879    MercadoLibrev2    DATABASE     o   CREATE DATABASE "MercadoLibrev2" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Colombia.1252';
     DROP DATABASE "MercadoLibrev2";
                postgres    false            ?            1255    20043    fn_verificar()    FUNCTION     ?  CREATE FUNCTION public.fn_verificar() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
	if NEW.id_order <> old.id_order then
	
		insert into "public"."Cart" ("id_order","CantidadProductos","Usuario","Descripcion","Idproductos")
		values (NEW.id_order,5,'jHernandez','5 huevos','17641');
		insert into "public"."Comprador" ("Cedula","TipoId","NombreC","RazonS","Telefono","Email","Direccion","Usuario","Ciudad","Contraseña"
		,"TarjetaC","id_order")
		values(1024578963,'C.C','Juan Hernandez','','3015247896','juan@gmail.com','carrera 99 #69a-40','jHernandez','Bogotá','juan1234'
		,'1233456789123456789',NEW.id_order);
	end if;

end;

$$;
 %   DROP FUNCTION public.fn_verificar();
       public          postgres    false            ?            1255    20061    trigger_audit_variant()    FUNCTION       CREATE FUNCTION public.trigger_audit_variant() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO variant_audit ("TipoVariante","Descripcion","fecha")
		VALUES('I',NEW,now());
		RETURN NEW;
	ELSEIF (TG_OP = 'UPDATE') THEN
		INSERT INTO variant_audit ("TipoVariante","Descripcion","fecha")
		VALUES('U',NEW,now());
		RETURN NEW;
	ELSEIF (TG_OP = 'DELETE') THEN
	INSERT INTO variant_audit ("TipoVariante","Descripcion","fecha")
		VALUES('D',NEW,now());
		RETURN OLD;
	END IF;
	RETURN NULL;
END;
$$;
 .   DROP FUNCTION public.trigger_audit_variant();
       public          postgres    false            ?            1255    20069    trigger_reputacion()    FUNCTION     ?  CREATE FUNCTION public.trigger_reputacion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin 
if (TG_OP = 'UPDATE') THEN
	if (NEW.calificacion <= 5) THEN
		INSERT INTO weekly_reputation ("id_vendedor","reputacion","calificacion")
		VALUES (151,'BAJA',NEW.calificacion);
		RETURN NEW;
	ELSEIF (NEW.calificacion <= 10) THEN
		INSERT INTO weekly_reputation ("id_vendedor","reputacion","calificacion")
		VALUES (151,'BAJA-MEDIA',NEW.calificacion);
		RETURN NEW;
	ELSEIF (NEW.calificacion <= 15) then
		INSERT INTO weekly_reputation ("id_vendedor","reputacion","calificacion")
		VALUES (151,'MEDIA',NEW.calificacion);
		RETURN NEW;
	ELSEIF (NEW.calificacion <= 20)then
		INSERT INTO weekly_reputation ("id_vendedor","reputacion","calificacion")
		VALUES (151,'MEDIA-ALTA',NEW.calificacion);
		RETURN NEW;
	ELSEIF (NEW.calificacion > 20) then
		INSERT INTO weekly_reputation ("id_vendedor","reputacion","calificacion")
		VALUES (151,'ALTA',NEW.calificacion);
		RETURN NEW;
	END IF;
END IF;
RETURN NULL;
END;
$$;
 +   DROP FUNCTION public.trigger_reputacion();
       public          postgres    false            ?            1259    19941    Administrador    TABLE     ?   CREATE TABLE public."Administrador" (
    id_admin integer NOT NULL,
    "Usuario" character varying(100) NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    "Clave" character varying(1000) NOT NULL
);
 #   DROP TABLE public."Administrador";
       public         heap    postgres    false            ?            1259    19940    Administrador_id_admin_seq    SEQUENCE     ?   ALTER TABLE public."Administrador" ALTER COLUMN id_admin ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Administrador_id_admin_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    210            ?            1259    19949    Cart    TABLE        CREATE TABLE public."Cart" (
    "id_Cart" integer NOT NULL,
    id_order integer NOT NULL,
    "CantidadProductos" integer NOT NULL,
    "Usuario" character varying(100) NOT NULL,
    "Descripcion" character varying(10000) NOT NULL,
    "Idproductos" character varying(1000) NOT NULL
);
    DROP TABLE public."Cart";
       public         heap    postgres    false            ?            1259    19948    Cart_id_Cart_seq    SEQUENCE     ?   ALTER TABLE public."Cart" ALTER COLUMN "id_Cart" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Cart_id_Cart_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    212            ?            1259    19957 	   Comprador    TABLE     u  CREATE TABLE public."Comprador" (
    "id_Comprador" integer NOT NULL,
    "Cedula" character varying(100) NOT NULL,
    "Tipoid" character varying(100) NOT NULL,
    "NombreC" character varying(100) NOT NULL,
    "RazonS" character varying(1000) NOT NULL,
    "Telefono" character varying(100) NOT NULL,
    "Email" character varying(1000) NOT NULL,
    "Direccion" character varying(1000) NOT NULL,
    "Usuario" character varying(100) NOT NULL,
    "Ciudad" character varying(100) NOT NULL,
    "Contraseña" character varying(100) NOT NULL,
    "TarjetaC" character varying(100) NOT NULL,
    id_order integer DEFAULT 100
);
    DROP TABLE public."Comprador";
       public         heap    postgres    false            ?            1259    19956    Comprador_id_Comprador_seq    SEQUENCE     ?   ALTER TABLE public."Comprador" ALTER COLUMN "id_Comprador" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Comprador_id_Comprador_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    214            ?            1259    19965    Producto    TABLE       CREATE TABLE public."Producto" (
    id_producto integer NOT NULL,
    "NombreP" character varying(1000) NOT NULL,
    "DescripcionP" character varying(2000) NOT NULL,
    "Valor" integer NOT NULL,
    "Cantidad" integer NOT NULL,
    id_variante integer NOT NULL
);
    DROP TABLE public."Producto";
       public         heap    postgres    false            ?            1259    19964    Producto_id_producto_seq    SEQUENCE     ?   ALTER TABLE public."Producto" ALTER COLUMN id_producto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Producto_id_producto_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    216            ?            1259    19973    Variante    TABLE     ?   CREATE TABLE public."Variante" (
    "TipoVariante" character varying(100) NOT NULL,
    "Descripcion" character varying(1000) NOT NULL,
    id_variante integer NOT NULL,
    "Cantidad" integer
);
    DROP TABLE public."Variante";
       public         heap    postgres    false            ?            1259    19972    Variante_id_variante_seq    SEQUENCE     ?   ALTER TABLE public."Variante" ALTER COLUMN id_variante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Variante_id_variante_seq"
    START WITH 1
    INCREMENT BY 100
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    218            ?            1259    19979    Vendedor    TABLE     ?   CREATE TABLE public."Vendedor" (
    id_vendedor integer NOT NULL,
    "Nombre" character varying(100) NOT NULL,
    calificacion integer NOT NULL,
    "CantidadV" integer NOT NULL
);
    DROP TABLE public."Vendedor";
       public         heap    postgres    false            ?            1259    19978    Vendedor_id_vendedor_seq    SEQUENCE     ?   ALTER TABLE public."Vendedor" ALTER COLUMN id_vendedor ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Vendedor_id_vendedor_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    220            ?            1259    20046    variant_audit    TABLE     ?   CREATE TABLE public.variant_audit (
    "TipoVariante" character varying(100) NOT NULL,
    "Descripcion" character varying(1000),
    id_variante integer NOT NULL,
    cantidad integer,
    fecha date
);
 !   DROP TABLE public.variant_audit;
       public         heap    postgres    false            ?            1259    20045    variant_audit_id_variante_seq    SEQUENCE     ?   ALTER TABLE public.variant_audit ALTER COLUMN id_variante ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.variant_audit_id_variante_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    222            ?            1259    20063    weekly_reputation    TABLE     ?   CREATE TABLE public.weekly_reputation (
    id_vendedor integer NOT NULL,
    reputacion character varying(100) NOT NULL,
    calificacion integer NOT NULL
);
 %   DROP TABLE public.weekly_reputation;
       public         heap    postgres    false                      0    19941    Administrador 
   TABLE DATA           Q   COPY public."Administrador" (id_admin, "Usuario", "Nombre", "Clave") FROM stdin;
    public          postgres    false    210   ??                 0    19949    Cart 
   TABLE DATA           s   COPY public."Cart" ("id_Cart", id_order, "CantidadProductos", "Usuario", "Descripcion", "Idproductos") FROM stdin;
    public          postgres    false    212   ??                  0    19957 	   Comprador 
   TABLE DATA           ?   COPY public."Comprador" ("id_Comprador", "Cedula", "Tipoid", "NombreC", "RazonS", "Telefono", "Email", "Direccion", "Usuario", "Ciudad", "Contraseña", "TarjetaC", id_order) FROM stdin;
    public          postgres    false    214   &@       "          0    19965    Producto 
   TABLE DATA           n   COPY public."Producto" (id_producto, "NombreP", "DescripcionP", "Valor", "Cantidad", id_variante) FROM stdin;
    public          postgres    false    216   C@       $          0    19973    Variante 
   TABLE DATA           \   COPY public."Variante" ("TipoVariante", "Descripcion", id_variante, "Cantidad") FROM stdin;
    public          postgres    false    218   `@       &          0    19979    Vendedor 
   TABLE DATA           V   COPY public."Vendedor" (id_vendedor, "Nombre", calificacion, "CantidadV") FROM stdin;
    public          postgres    false    220   ?@       (          0    20046    variant_audit 
   TABLE DATA           d   COPY public.variant_audit ("TipoVariante", "Descripcion", id_variante, cantidad, fecha) FROM stdin;
    public          postgres    false    222   ?@       )          0    20063    weekly_reputation 
   TABLE DATA           R   COPY public.weekly_reputation (id_vendedor, reputacion, calificacion) FROM stdin;
    public          postgres    false    223   lA       0           0    0    Administrador_id_admin_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Administrador_id_admin_seq"', 1, false);
          public          postgres    false    209            1           0    0    Cart_id_Cart_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Cart_id_Cart_seq"', 2, true);
          public          postgres    false    211            2           0    0    Comprador_id_Comprador_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public."Comprador_id_Comprador_seq"', 1, false);
          public          postgres    false    213            3           0    0    Producto_id_producto_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Producto_id_producto_seq"', 1, false);
          public          postgres    false    215            4           0    0    Variante_id_variante_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public."Variante_id_variante_seq"', 801, true);
          public          postgres    false    217            5           0    0    Vendedor_id_vendedor_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Vendedor_id_vendedor_seq"', 1, true);
          public          postgres    false    219            6           0    0    variant_audit_id_variante_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.variant_audit_id_variante_seq', 10, true);
          public          postgres    false    221            ?           2606    19947     Administrador Administrador_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public."Administrador"
    ADD CONSTRAINT "Administrador_pkey" PRIMARY KEY (id_admin);
 N   ALTER TABLE ONLY public."Administrador" DROP CONSTRAINT "Administrador_pkey";
       public            postgres    false    210            ?           2606    19955    Cart Cart_pkey 
   CONSTRAINT     W   ALTER TABLE ONLY public."Cart"
    ADD CONSTRAINT "Cart_pkey" PRIMARY KEY ("id_Cart");
 <   ALTER TABLE ONLY public."Cart" DROP CONSTRAINT "Cart_pkey";
       public            postgres    false    212            ?           2606    19963    Comprador Comprador_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public."Comprador"
    ADD CONSTRAINT "Comprador_pkey" PRIMARY KEY ("id_Comprador");
 F   ALTER TABLE ONLY public."Comprador" DROP CONSTRAINT "Comprador_pkey";
       public            postgres    false    214            ?           2606    19971    Producto Producto_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto);
 D   ALTER TABLE ONLY public."Producto" DROP CONSTRAINT "Producto_pkey";
       public            postgres    false    216            ?           2606    19983    Vendedor Vendedor_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Vendedor"
    ADD CONSTRAINT "Vendedor_pkey" PRIMARY KEY (id_vendedor);
 D   ALTER TABLE ONLY public."Vendedor" DROP CONSTRAINT "Vendedor_pkey";
       public            postgres    false    220            ?           2620    20062    Variante trigger_audit_variant    TRIGGER     ?   CREATE TRIGGER trigger_audit_variant AFTER INSERT OR DELETE OR UPDATE ON public."Variante" FOR EACH ROW EXECUTE FUNCTION public.trigger_audit_variant();
 9   DROP TRIGGER trigger_audit_variant ON public."Variante";
       public          postgres    false    218    235            ?           2620    20071    Vendedor trigger_reputa    TRIGGER     {   CREATE TRIGGER trigger_reputa AFTER UPDATE ON public."Vendedor" FOR EACH ROW EXECUTE FUNCTION public.trigger_reputacion();
 2   DROP TRIGGER trigger_reputa ON public."Vendedor";
       public          postgres    false    237    220            ?           2620    20070    Vendedor trigger_reputacion    TRIGGER        CREATE TRIGGER trigger_reputacion AFTER UPDATE ON public."Vendedor" FOR EACH ROW EXECUTE FUNCTION public.trigger_reputacion();
 6   DROP TRIGGER trigger_reputacion ON public."Vendedor";
       public          postgres    false    220    237            ?           2620    20044    Cart verificarorden    TRIGGER     r   CREATE TRIGGER verificarorden BEFORE INSERT ON public."Cart" FOR EACH ROW EXECUTE FUNCTION public.fn_verificar();
 .   DROP TRIGGER verificarorden ON public."Cart";
       public          postgres    false    212    236                  x?????? ? ?         /   x?3?440?4???H-?K?KI??4U?(M-?/?44731?????? ??	?             x?????? ? ?      "      x?????? ? ?      $   ;   x?K???/?,N?-.?KW6?430?45?J??I??Ԣ?T??bN?C?=... ?      &      x?3?tO???W??O??4?4?????? CR?      (   ?   x????H???/?Q*N?-.?KW6V?130?15??4????4202?50?54????vw?q??T??P?1?6??4ǩL)????*??)6Qұ i????@?ʩ????T??i??&?%?j?? M4F??? ܵ3?      )      x?345?tr?r?4?2D0c???? D??     