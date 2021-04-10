create table time_province(
    date date NOT NULL,
    province varchar(20) Not NULL,
    confirmed int,
    released int,
    deceased int,
    primary key (date, province)
);

load data local infile './time_province.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;