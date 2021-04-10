create table search_trend(
    date date NOT NULL,
    cold float,
    flu float,
    pneumonia float,
    coronavirus float,
    primary key (date)
);

load data local infile './search_trend.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;