CREATE TABLE periodos_vacacionales(
    id bigint not null auto_increment,
    inicio date not null,
    fin date not null,

    PRIMARY KEY(id)
);