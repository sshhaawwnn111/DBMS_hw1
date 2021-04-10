create table time_gender(
    date date NOT NULL,
    sex varchar(10) Not NULL,
    confirmed int,
    deceased int,
    primary key (date, sex)
);

load data local infile './time_gender.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;