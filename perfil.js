/* ==============================
   SEÇÃO: Atualizar Imagens de Perfil
   ============================== */
const uploadPerfilTopo = document.getElementById('upload-perfil1');   // input topo
const uploadPerfilModal = document.getElementById('upload-perfil2');  // input modal
const imgPerfil = document.getElementById('img-perfil');              // imagem topo
const imgPerfilModal = document.getElementById('foto-perfil');        // imagem modal

// Carrega imagem salva no localStorage quando a página abre
window.addEventListener('load', () => {
    const dataURL = localStorage.getItem('perfilImagem');
    if (dataURL) {
        if(imgPerfil) imgPerfil.src = dataURL;
        if(imgPerfilModal) imgPerfilModal.src = dataURL;
    }

    // Carrega nome salvo do perfil
    const nomeSalvo = localStorage.getItem('perfilNome');
    const nomeExibido = document.getElementById('nome-perfil');
    if(nomeSalvo && nomeExibido) {
        nomeExibido.textContent = nomeSalvo;
    }
});

function atualizarImagem(file) {
    if (file) {
        const reader = new FileReader();
        reader.onload = function() {
            const dataURL = reader.result;
            if(imgPerfil) imgPerfil.src = dataURL;      
            if(imgPerfilModal) imgPerfilModal.src = dataURL; 

            localStorage.setItem('perfilImagem', dataURL);
        }
        reader.readAsDataURL(file);
    }
}

if(uploadPerfilTopo){
    uploadPerfilTopo.addEventListener('change', function() {
        atualizarImagem(this.files[0]);
    });
}

if(uploadPerfilModal){
    uploadPerfilModal.addEventListener('change', function() {
        atualizarImagem(this.files[0]);
    });
}

/* ==============================
   SEÇÃO: Atualizar Nome do Perfil
   ============================== */
const nomeInput = document.getElementById('Nome-exibido');
const nomeExibido = document.getElementById('nome-perfil');
const form = document.querySelector('.login-form');

if(form && nomeInput && nomeExibido){
    form.addEventListener('submit', function(e) {
        e.preventDefault();

        if (nomeInput.value.trim() !== "") {
            nomeExibido.textContent = nomeInput.value;
            localStorage.setItem('perfilNome', nomeInput.value);
        }

        if(modal) modal.style.display = 'none';
    });
}

document.addEventListener("DOMContentLoaded"), function () {
    const modal = document.getElementById("modal-excluir-adm");
    const nomeSpan = document.getElementById("nome-adm-exclusao");
    const cancelarBtn = document.getElementById("cancelar-exclusao");
    const confirmarBtn = document.getElementById("confirmar-exclusao");
  
    let elementoParaExcluir = null;}