Cadastro sempre cria usuário com tipo_usuario = 'administrador' e salva email e senha:

<?php
session_start();

$host = "localhost";
$db   = "nome_do_banco";
$user = "usuario";
$pass = "senha";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

$nome = trim($_POST['nome']);
$email = trim($_POST['email']);
$senha = $_POST['senha'];

if (empty($nome) || empty($email) || empty($senha)) {
    echo "Por favor, preencha todos os campos.";
    exit;
}

// Verifica se já existe o email
$stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    echo "Email já cadastrado.";
    $stmt->close();
    $conn->close();
    exit;
}
$stmt->close();

$senha_hash = password_hash($senha, PASSWORD_DEFAULT);
$tipo_usuario = 'administrador';

$stmt = $conn->prepare("INSERT INTO usuarios (nome, email, senha, tipo_usuario) VALUES (?, ?, ?, ?)");
$stmt->bind_param("ssss", $nome, $email, $senha_hash, $tipo_usuario);

if ($stmt->execute()) {
    echo "Cadastro realizado com sucesso!";
} else {
    echo "Erro ao cadastrar: " . $stmt->error;
}

$stmt->close();
$conn->close();
?>
