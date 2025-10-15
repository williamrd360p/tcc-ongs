document.addEventListener("DOMContentLoaded", () => {
    const perfilBtn = document.getElementById("perfilBtn");
    const loginModal = document.getElementById("loginModal");
    const closeBtn = document.getElementById("closeBtn");

    // Abrir modal ao clicar no botão "Perfil"
    if(perfilBtn && loginModal){
        perfilBtn.addEventListener("click", () => {
            loginModal.style.display = "flex";
        });
    }

    // Fechar modal ao clicar no "x"
    if(closeBtn && loginModal){
        closeBtn.addEventListener("click", () => {
            loginModal.style.display = "none";
        });
    }

    // Fechar modal clicando fora
    window.addEventListener("click", (e) => {
        if(e.target === loginModal){
            loginModal.style.display = "none";
        }
    });
});


/* ==============================
   Atualizar imagem do perfil (Topo, Modal e PerfilBtn)
   ============================== */
const uploadPerfilTopo = document.getElementById('upload-perfil1');   
const imgPerfil = document.getElementById('img-perfil');              

const uploadPerfilModal = document.getElementById('upload-perfil2');
const imgPerfilModal = document.getElementById('foto-perfil');

window.addEventListener('load', () => {
    const dataURL = localStorage.getItem('perfilImagem');
    const nomeSalvo = localStorage.getItem('perfilNome');
    const nomeExibido = document.getElementById('nome-perfil');

    // Atualiza topo e modal
    if(imgPerfil) imgPerfil.src = dataURL || "img/user_7324850.png";
    if(imgPerfilModal) imgPerfilModal.src = dataURL || "img/user_7324850.png";

    // Atualiza a imagem dentro do botão de perfil
    const perfilBtnImg = document.querySelector("#perfilBtn img");
    if(perfilBtnImg) perfilBtnImg.src = dataURL || "img/user_7324850.png";

    if(nomeSalvo && nomeExibido) nomeExibido.textContent = nomeSalvo;
});

function atualizarImagem(file, preview) {
    if(file){
        const reader = new FileReader();
        reader.onload = function() {
            preview.src = reader.result;
            localStorage.setItem('perfilImagem', reader.result);

            // Atualiza também a imagem do perfilBtn quando muda
            const perfilBtnImg = document.querySelector("#perfilBtn img");
            if(perfilBtnImg) perfilBtnImg.src = reader.result;
        }
        reader.readAsDataURL(file);
    }
}

// Evento para o topo
if(uploadPerfilTopo) {
    uploadPerfilTopo.addEventListener('change', function() { 
        atualizarImagem(this.files[0], imgPerfil); 
    });
}

// Evento para o modal
if(uploadPerfilModal) {
    uploadPerfilModal.addEventListener('change', function() { 
        atualizarImagem(this.files[0], imgPerfilModal); 
        atualizarImagem(this.files[0], imgPerfil); // <- já reflete também no topo
    });
}


/* ==============================
   Atualizar nome do perfil
   ============================== */
const formPerfil = document.querySelector('.login-form');
const nomeInput = document.getElementById('Nome-exibido');
const nomeExibido = document.getElementById('nome-perfil');

if(formPerfil && nomeInput && nomeExibido){
    formPerfil.addEventListener('submit', function(e) {
        e.preventDefault();
        if(nomeInput.value.trim() !== ""){
            nomeExibido.textContent = nomeInput.value;
            localStorage.setItem('perfilNome', nomeInput.value);
        }
        const loginModal = document.getElementById('loginModal');
        if(loginModal) loginModal.style.display = 'none';
    });
}

/* ==============================
   Modal de exclusão de administrador
   ============================== */
document.addEventListener("DOMContentLoaded", () => {
    const excluirModal = document.getElementById("modal-excluir-adm"); 
    const nomeSpan = document.getElementById("nome-adm-exclusao");
    const cancelarBtn = document.getElementById("cancelar-exclusao");
    const confirmarBtn = document.getElementById("confirmar-exclusao");
    let elementoParaExcluir = null;

    document.querySelector(".adms").addEventListener("click", (event) => {
        if(event.target.classList.contains("excluir")){
            const card = event.target.closest(".perfil-adm");
            nomeSpan.textContent = card.querySelector("p").innerText;
            excluirModal.style.display = "flex";
            elementoParaExcluir = card;
        }
    });

    cancelarBtn.addEventListener("click", () => {
        excluirModal.style.display = "none";
        elementoParaExcluir = null;
    });

    confirmarBtn.addEventListener("click", () => {
        if(elementoParaExcluir){
            elementoParaExcluir.remove();
            excluirModal.style.display = "none";
        }
    });
});

/* ==============================
   Cadastro de administradores
   ============================== */
document.addEventListener("DOMContentLoaded", () => {
    const modalCadastro = document.getElementById("modal-cadastro-adm");
    const formAdm = modalCadastro.querySelector("form");
    const listaAdms = document.querySelector(".adms");
    const logarAdmDiv = listaAdms.querySelector(".logar-adm");
    const uploadCadastro = document.getElementById("upload-cadastro");
    const imgCadastro = document.getElementById("img-cadastro");

    // Preview da imagem
    uploadCadastro.addEventListener("change", function() {
        const file = this.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = (e) => imgCadastro.src = e.target.result;
            reader.readAsDataURL(file);
        }
    });

    // Submit cadastro
    formAdm.addEventListener("submit", (e) => {
        e.preventDefault();
        const nome = formAdm.querySelector("#nome").value.trim();
        const imgFile = uploadCadastro.files[0];
        const imgURL = imgFile ? URL.createObjectURL(imgFile) : "img/user_7324850.png";
        if(nome === "") return;

        const card = document.createElement("div");
        card.classList.add("perfil-adm");
        card.innerHTML = `
            <img src="${imgURL}" alt="">
            <p>${nome}</p>
            <button class="editar">Editar conta</button>
            <button class="excluir">Excluir conta</button>
        `;
        listaAdms.insertBefore(card, logarAdmDiv);
        formAdm.reset();
        imgCadastro.src = "img/user_7324850.png";
        modalCadastro.style.display = "none";
    });
});

/* ==============================
   Modal de edição de administrador
   ============================== */
document.addEventListener("DOMContentLoaded", () => {
    const listaAdms = document.querySelector(".adms");
    const modalEditar = document.getElementById("modal-editar-adm");
    const formEditar = modalEditar.querySelector("form");
    const inputNomeEditar = document.getElementById("nome-editar");
    const imgEditar = document.getElementById("img-editar");
    const uploadEditar = document.getElementById("upload-editar");

    // Abrir modal ao clicar em editar
    listaAdms.addEventListener("click", (e) => {
        if(e.target.classList.contains("editar")){
            const card = e.target.closest(".perfil-adm");
            inputNomeEditar.value = card.querySelector("p").innerText;
            imgEditar.src = card.querySelector("img").src;
            formEditar.currentCard = card;
            modalEditar.style.display = "flex";
        }
    });

    // Preview da imagem no modal
    uploadEditar.addEventListener("change", function(){
        const file = this.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = (e) => imgEditar.src = e.target.result;
            reader.readAsDataURL(file);
        }
    });

    // Salvar alterações
    formEditar.addEventListener("submit", (e) => {
        e.preventDefault();
        const card = formEditar.currentCard;
        if(!card) return;
        const novoNome = inputNomeEditar.value.trim();
        if(novoNome) card.querySelector("p").textContent = novoNome;
        card.querySelector("img").src = imgEditar.src;
        modalEditar.style.display = "none";
    });

    // Cancelar edição
    const cancelarEditar = document.getElementById("cancelar-editar");
    cancelarEditar.addEventListener("click", () => modalEditar.style.display = "none");
});

/* ==============================
   Modal nova anotação com exclusão
   ============================== */
document.addEventListener("DOMContentLoaded", () => {
    const modalAnotacao = document.getElementById("modal-anotacao");
    const textareaAnotacao = document.getElementById("nova-anotacao");
    const divAnotacoes = document.querySelector(".anotacoes1");

    const btnAnotar = document.getElementById("anotar");
    btnAnotar.addEventListener("click", () => modalAnotacao.style.display = "flex");

    const cancelarAnotacao = document.getElementById("cancelar-anotacao");
    cancelarAnotacao.addEventListener("click", () => modalAnotacao.style.display = "none");

    const formAnotacao = modalAnotacao.querySelector("form");
    formAnotacao.addEventListener("submit", (e) => {
        e.preventDefault();
        const texto = textareaAnotacao.value.trim();
        if(texto !== ""){
            const nova = document.createElement("div");
            nova.classList.add("anotacao");
            nova.innerHTML = `
                <p>${texto}</p>
                <button class="excluir-anotacao">Excluir</button>
            `;
            divAnotacoes.insertBefore(nova, document.getElementById("anotar"));
            textareaAnotacao.value = "";
            modalAnotacao.style.display = "none";

            // Evento para excluir a anotação
            const btnExcluir = nova.querySelector(".excluir-anotacao");
            btnExcluir.addEventListener("click", (ev) => {
                ev.stopPropagation(); // evita disparar outros eventos
                nova.remove();
            });
        }
    });
});


/* ==============================
   Abrir modal de cadastro
   ============================== */
document.addEventListener("DOMContentLoaded", () => {
    const modalCadastro = document.getElementById("modal-cadastro-adm");
    const btnCadastro = document.querySelector(".logar-adm button");
    btnCadastro.addEventListener("click", () => modalCadastro.style.display = "flex");

    const cancelarCadastro = document.getElementById("cancelar-cadastro");
    cancelarCadastro.addEventListener("click", () => modalCadastro.style.display = "none");

    // Fechar modal clicando fora
    window.addEventListener("click", (e) => {
        if(e.target === modalCadastro) modalCadastro.style.display = "none";
    });
});
