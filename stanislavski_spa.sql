--DROP DATABASE blog;

--1. Crear base de datos llamada blog.
CREATE DATABASE blog;

--conectarse a la base 
\c blog

--2. Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuarios(
    id SERIAL NOT NULL PRIMARY KEY,
    email VARCHAR(50)
);

CREATE TABLE posts(
    id SERIAL NOT NULL PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(40),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios(
    id SERIAL NOT NULL PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    texto VARCHAR(200),
    fecha DATE,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (usuario_id)REFERENCES usuarios(id)
);

--3. insertar registros
\copy usuarios FROM 'usuarios.csv' csv header;
\copy posts FROM 'posts.csv' csv header;
\copy comentarios FROM 'comentarios.csv' csv header;

--4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT u.id, u.email, p.id, p.titulo FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
WHERE u.id = 5;

--5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
--por el usuario con email ​usuario06@hotmail.com​.
SELECT u.id, u.email, c.usuario_id, c.texto FROM usuarios AS u
INNER JOIN comentarios AS c
ON u.id = c.usuario_id
WHERE u.email != 'usuario06@hotmail.com'; 

--6. Listar los usuarios que no han publicado ningún post.
SELECT u.* FROM usuarios AS u
LEFT JOIN posts AS p
ON u.id = p.usuario_id
WHERE p.usuario_id IS NULL;

--7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
--comentarios).
SELECT p.*, c.* FROM posts AS p
FULL OUTER JOIN comentarios AS c
ON p.id = c.post_id;

--8. Listar todos los usuarios que hayan publicado un post en Junio.
SELECT u.* FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
WHERE EXTRACT(MONTH FROM p.fecha) = 06;







