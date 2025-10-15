document.addEventListener("DOMContentLoaded", () => {
    const btnCadastrarAluno = document.querySelector(".cadastrar-alunos");
    const modalCadastroAluno = document.getElementById("modal-cadastro-aluno");
    const fecharCadastroAluno = document.getElementById("fechar-cadastro-aluno");
    const formCadastroAluno = document.getElementById("form-cadastro-aluno");
    const listaAlunos = document.querySelector(".lista-alunos");

    // Abrir modal ao clicar no botão
    btnCadastrarAluno.addEventListener("click", () => {
        modalCadastroAluno.style.display = "flex";
    });

    // Fechar modal ao clicar no "x"
    fecharCadastroAluno.addEventListener("click", () => {
        modalCadastroAluno.style.display = "none";
    });

    // Fechar clicando fora do modal
    window.addEventListener("click", (e) => {
        if(e.target === modalCadastroAluno){
            modalCadastroAluno.style.display = "none";
        }
    });

    // Adicionar aluno
    formCadastroAluno.addEventListener("submit", (e) => {
        e.preventDefault();

        const nome = document.getElementById("nome-aluno").value;
        const cpf = document.getElementById("cpf-aluno").value;
        const nasc = document.getElementById("nasc-aluno").value;
        const responsavel = document.getElementById("responsavel-aluno").value;
        const fotoInput = document.getElementById("foto-aluno");

        const fotoURL = fotoInput.files[0] ? URL.createObjectURL(fotoInput.files[0]) : "img/user_7324850.png";

        const alunoDiv = document.createElement("div");
        alunoDiv.classList.add("alunos-cadastrados");
        alunoDiv.innerHTML = `
            <img src="${fotoURL}" alt="">
            <p>${nome}</p>
            <p>${cpf}</p>
            <p>${nasc}</p>
            <p>${responsavel}</p>
            <button class="excluir">Excluir</button>
            <button class="editar">Editar</button>
        `;

        listaAlunos.insertBefore(alunoDiv, btnCadastrarAluno);
        formCadastroAluno.reset();
        modalCadastroAluno.style.display = "none";
    });
});

btnCadastrarAluno.addEventListener("click", () => {
    modalCadastroAluno.style.display = "flex";
});

fecharCadastroAluno.addEventListener("click", () => {
    modalCadastroAluno.style.display = "none";
});

window.addEventListener("click", (e) => {
    if(e.target === modalCadastroAluno){
        modalCadastroAluno.style.display = "none";
    }
});

