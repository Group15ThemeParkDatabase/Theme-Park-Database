/*-------------------------------Tables-------------------------------*/
CREATE TABLE public.department
(
    dname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    dnumber integer NOT NULL,
    mgr_ssn character(9) COLLATE pg_catalog."default" NOT NULL,
    mgr_start_date date,
    CONSTRAINT department_pkey PRIMARY KEY (dnumber),
    CONSTRAINT department_dname_key UNIQUE (dname)
)

CREATE TABLE public.employee
(
    fname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    lname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    ssn character(9) COLLATE pg_catalog."default" NOT NULL,
    bdate date,
    address character varying(30) COLLATE pg_catalog."default" DEFAULT NULL::character varying,
    sex character(1) COLLATE pg_catalog."default" DEFAULT NULL::bpchar,
    salary numeric(10, 2) DEFAULT NULL::numeric,
    super_ssn character(9) COLLATE pg_catalog."default" DEFAULT NULL::bpchar,
    dno integer NOT NULL,
    phone_number character(12) COLLATE pg_catalog."default" DEFAULT NULL::bpchar,
    CONSTRAINT employee_pkey PRIMARY KEY (ssn),
    CONSTRAINT employee_ibfk_1 FOREIGN KEY (super_ssn)
        REFERENCES public.employee (ssn) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT employee_ibfk_2 FOREIGN KEY (dno)
        REFERENCES public.department (dnumber) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE public.game
(
    prize gprize NOT NULL,
    price integer NOT NULL,
    game_id integer NOT NULL,
    maint_date date,
    gname character varying(15) COLLATE pg_catalog."default" NOT NULL,
    capacity integer NOT NULL,
    dno integer,
    CONSTRAINT game_pkey PRIMARY KEY (game_id),
    CONSTRAINT game_gname_key UNIQUE (gname),
    CONSTRAINT game_ibfk_1 FOREIGN KEY (dno)
        REFERENCES public.department (dnumber) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE public.kiosk
(
    kiosk_id integer NOT NULL,
    service_type stype NOT NULL,
    price integer NOT NULL,
    name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    dno integer,
    CONSTRAINT kiosk_pkey PRIMARY KEY (kiosk_id),
    CONSTRAINT kiosk_name_key UNIQUE (name),
    CONSTRAINT kiosk_ibfk_1 FOREIGN KEY (dno)
        REFERENCES public.department (dnumber) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE public.ride
(
    ride_id integer NOT NULL,
    price integer NOT NULL,
    capacity integer NOT NULL,
    date_built date,
    maintenance_date date,
    name character varying(15) COLLATE pg_catalog."default" NOT NULL,
    rider_count integer,
    rider_time timestamp without time zone NOT NULL DEFAULT now(),
    dno integer,
    CONSTRAINT ride_pkey PRIMARY KEY (ride_id),
    CONSTRAINT ride_ibfk_1 FOREIGN KEY (dno)
        REFERENCES public.department (dnumber) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE public.ticket
(
    ticket_id integer NOT NULL,
    price integer NOT NULL,
    ticket_type t_type,
    CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id)
)

/*-------------------------------TRIGGERS-------------------------------*/
CREATE TRIGGER update_ride_changetimestamp
    BEFORE UPDATE 
    ON public.ride
    FOR EACH ROW
    EXECUTE PROCEDURE public.update_changetimestamp_column();

/*-------------------------------Trigger Functions-------------------------------*/
CREATE FUNCTION public.update_changetimestamp_column()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100.0
    VOLATILE NOT LEAKPROOF 
AS $BODY$

BEGIN
   NEW.changetimestamp = now(); 
   RETURN NEW;
END;
/*-------------------------------ENUMS-------------------------------*/
CREATE TYPE public.gprize AS ENUM
    ('small', 'medium', 'large');

CREATE TYPE public.stype AS ENUM
    ('food', 'gifts');

CREATE TYPE public.t_type AS ENUM
    ('season', 'regular');