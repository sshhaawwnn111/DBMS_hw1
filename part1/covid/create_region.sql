create table region(
    code int NOT NULL,
    province varchar(20),
    city varchar(20),
    elementary_school_count int,
    kindergarten_count int,
    university_count int,
    elderly_population_ratio float,
    elderly_alone_ratio float,
    nursing_home_count int,
    primary key (code)
);

load data local infile './region.csv'
into table region
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;