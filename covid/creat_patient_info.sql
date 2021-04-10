create table patient_info(
    patient_id varchar(10) NOT NULL,
    sex varchar(10),
    age int,
    province varchar(20),
    city varchar(20),
    infection_case varchar(100),
    primary key (patient_id)
);

load data local infile './patient_info.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;