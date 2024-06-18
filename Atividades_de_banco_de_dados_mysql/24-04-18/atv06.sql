create table autor(
  id_autor int not null PRIMARY KEY,
  nome varchar(100),
  cpf varchar(11),
  data_nasc date,
  id_livro int  
)
  
create table livro(
  id_livro int not null PRIMARY key,
  nome varchar(100),
  ano varchar(4),
  genero varchar(20),
  id_editora int,
  id_autor int
  FOREIGN key (id_editora) references Editora(id_editora)
)

create table autor_livro(
  id_autor int,
  id_livro int,
  primary key (id_autor, id_livro),
  FOREIGN key (id_autor) references autor(id_autor),
  FOREIGN key (id_livro) references livro(id_livro)
)

create table editora(
  id_editora int not null primary key,
  nome varchar(100),
  localidade varchar(150)
)