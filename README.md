# Desafio DIO: Kubernetes e Docker

## 📌 Descrição do Projeto

Este projeto é uma aplicação .NET simples implantada em um cluster Kubernetes no Google Cloud Platform (GCP), com configurações automatizadas de deploy e infraestrutura.

## 🛠 Tecnologias Utilizadas

- .NET 8.0
- Docker
- Kubernetes
- Google Cloud Platform
- Ubuntu

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [.NET SDK 8.0](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Docker](https://www.docker.com/get-started)
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## 🚀 Configuração Inicial

### 1. Clonar Repositório

```bash
git clone https://github.com/[seu-usuario]/desafio-dio-dckr-k8s.git
cd desafio-dio-dckr-k8s
```

### 2. Configurar Variáveis de Ambiente

1. Copie o arquivo de exemplo:
```bash
cp .env.example .env
```

2. Edite o `.env` com suas configurações:
```bash
nano .env
```

Preencha com suas informações do Google Cloud:
- `PROJECT_ID`: ID do seu projeto no GCP
- `ZONE`: Zona do cluster (ex: us-central1-a)
- `CLUSTER_NAME`: Nome para seu cluster Kubernetes
- `MACHINE_TYPE`: Tipo de máquina para os nós
- `MIN_NODES` e `MAX_NODES`: Configurações de autoscaling

### 3. Autenticação no Google Cloud

```bash
# Fazer login no GCP
gcloud auth login

# Configurar projeto
gcloud config set project SEU_PROJECT_ID
```

## 🔧 Instalação e Deploy

### Executar Script de Configuração

```bash
# Dar permissão de execução
chmod +x gcp-setup.sh

# Executar configuração
./gcp-setup.sh
```

### Verificar Implantação

```bash
# Listar deployments
kubectl get deployments

# Listar pods
kubectl get pods

# Listar serviços
kubectl get services
```

## 📦 Estrutura do Projeto

```
desafio-dio-dckr-k8s/
│
├── dio-web-k8s-dckr/     # Pasta da solution .NET
│   ├── Dockerfile
│   └── Program.cs
│
├── .env.example          # Template de variáveis de ambiente
├── gcp-setup.sh          # Script de configuração do GCP
└── kubernetes-deployment.yaml  # Configuração do Kubernetes
```

## ⚠️ Segurança e Boas Práticas

- Nunca commite o arquivo `.env` com credenciais reais
- Use sempre `.env.example` no repositório
- Mantenha o `.env` no `.gitignore`

## 🔍 Solução de Problemas

### Erros Comuns

1. **Falha na Autenticação GCP**
   - Verifique se está logado: `gcloud auth list`
   - Refaça login: `gcloud auth login`

2. **Problemas com Cluster**
   - Verifique configurações no `.env`
   - Confirme credenciais do GCP

## 💡 Customização

- Ajuste recursos no `kubernetes-deployment.yaml`
- Modifique réplicas e configurações de scaling

## 📄 Licença

[MIT](https://mit-license.org/)

## 🤝 Contribuições

Contribuições são bem-vindas! Por favor, leia as diretrizes de contribuição antes de enviar um pull request.
