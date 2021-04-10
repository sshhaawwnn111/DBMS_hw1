create table time_age(
    date date NOT NULL,
    age int Not NULL,
    confirmed int,
    deceased int,
    primary key (date, age)
);

load data local infile './time_age.csv'
into table time_age
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;