create table time(
    date date NOT NULL,
    test int,
    negative int,
    confirmed int,
    released int,
    deceased int,
    primary key (date)
);

load data local infile './time.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;