/* Script para inserir dados (merge) nas usuario

-- Inserir alunos (sem email e senha)
INSERT INTO usuario (nome, cpf, telefone, email, senha, tipo_perfil)
SELECT nome, cpf, telefone, NULL, NULL, 'aluno'
FROM tb_aluno;

-- Inserir voluntários (sem email e senha)
INSERT INTO usuario (nome, cpf, telefone, email, senha, tipo_perfil)
SELECT nome, cpf, telefone, NULL, NULL, 'voluntario'
FROM tb_voluntario;

-- Inserir administradores (com email e senha)
INSERT INTO usuario (nome, cpf, telefone, email, senha, tipo_perfil)
SELECT nome, NULL, NULL, email, senha, 'administrador'
FROM tb_administrador;
*/
-------------------------------------------------------------------------------------


CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(15),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,        -- só para administradores
    senha VARCHAR(255),               -- só para administradores
    tipo_perfil ENUM('administrador', 'aluno', 'voluntario') NOT NULL
);

CREATE TABLE usuario (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  tipo_perfil ENUM('administrador', 'aluno', 'voluntario') NOT NULL,
  cpf VARCHAR(20) DEFAULT NULL,
  telefone VARCHAR(20) DEFAULT NULL,
  foto VARCHAR(255) DEFAULT NULL
);

CREATE TABLE anotacoes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  texto TEXT NOT NULL,
  criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
  criado_por INT,
  FOREIGN KEY (criado_por) REFERENCES usuario(id) ON DELETE SET NULL
);

-- Insere o admin base (senha hash de 'espacotiaju')
INSERT INTO usuario (nome, email, senha, tipo_perfil) VALUES (
  'Administrador Base', 'tiaju', 
  '$2y$10$S8QIm3Ry3.EU1NqcCchzvevZdQNKfNKQ0RJmb2HVkmTuR5b3EkxkK', -- senha 'espacotiaju' com password_hash()
  'administrador'
);



<script>
function scrollToDuration(target, duration) {
    const start = window.scrollY;
    const end = target.getBoundingClientRect().top + window.scrollY;
    const distance = end - start;
    let startTime = null;

    function animation(currentTime) {
        if (startTime === null) startTime = currentTime;
        const timeElapsed = currentTime - startTime;
        const progress = Math.min(timeElapsed / duration, 1); // de 0 a 1
        window.scrollTo(0, start + distance * easeInOutQuad(progress));
        if (timeElapsed < duration) {
            requestAnimationFrame(animation);
        }
    }
    function easeInOutQuad(t) {
        return t < 0.5 ? 2*t*t : -1 + (4 - 2*t)*t;
    }

    requestAnimationFrame(animation);
}
const linkRodape = document.getElementById('contato');
const rodape = document.getElementById('rodape');

linkRodape.addEventListener('click', function(e){
    e.preventDefault();
    scrollToDuration(rodape, 1300);
});
</script>
</body>
</html>