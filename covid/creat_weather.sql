create table weather(
    code int NOT NULL,
    date date Not NULL,
    avg_temp float,
    most_wind_direction int,
    avg_relative_humidity float,
    primary key (code, date),
    FOREIGN KEY (code) REFERENCES region(code)
);

load data local infile './weather.csv'
into table mask
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;