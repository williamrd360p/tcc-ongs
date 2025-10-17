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

$email = $_POST['email'];
$senha = $_POST['senha'];

$stmt = $conn->prepare("SELECT senha, tipo_usuario, nome FROM usuarios WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    $stmt->bind_result($hash_senha, $tipo_usuario, $nome);
    $stmt->fetch();

    if ($tipo_usuario !== 'administrador') {
        echo "Acesso negado. Usuário não é administrador.";
        exit;
    }

    if (password_verify($senha, $hash_senha)) {
        $_SESSION['email'] = $email;
        $_SESSION['nome'] = $nome;
        $_SESSION['tipo_usuario'] = $tipo_usuario;
        echo "Login realizado com sucesso!";
        // Aqui pode redirecionar para a área restrita
    } else {
        echo "Senha incorreta.";
    }
} else {
    echo "Email não cadastrado.";
}

$stmt->close();
$conn->close();
?>
