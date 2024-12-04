#!/bin/bash

# Verificação de dependências
command -v gcloud >/dev/null 2>&1 || { 
    echo "Erro: Google Cloud SDK não instalado. Instale em: https://cloud.google.com/sdk"
    exit 1
}

command -v kubectl >/dev/null 2>&1 || {
    echo "Erro: kubectl não instalado. Instale com: gcloud components install kubectl"
    exit 1
}

# Carregar variáveis de ambiente
# Requer instalação do pacote gettext para envsubst
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs -d '\n')
else
    echo "Erro: Arquivo .env não encontrado"
    echo "Por favor, copie .env.example para .env e preencha as configurações"
    exit 1
fi

# Validações de segurança e configuração
if [ -z "$PROJECT_ID" ] || [ -z "$ZONE" ] || [ -z "$CLUSTER_NAME" ]; then
    echo "Erro: Variáveis PROJECT_ID, ZONE e CLUSTER_NAME são obrigatórias"
    echo "Verifique seu arquivo .env"
    exit 1
fi

# Bloco de configuração do GCP
echo "🚀 Iniciando configuração do Google Cloud Platform 🚀"

# Definir projeto atual
gcloud config set project $PROJECT_ID

# Ativar APIs necessárias
echo "📦 Ativando APIs do Google Cloud..."
gcloud services enable \
    containerregistry.googleapis.com \
    container.googleapis.com \
    compute.googleapis.com

# Criação do Cluster Kubernetes
echo "🌐 Criando Cluster Kubernetes..."
gcloud container clusters create $CLUSTER_NAME \
    --zone $ZONE \
    --num-nodes 3 \
    --machine-type $MACHINE_TYPE \
    --enable-autoscaling \
    --min-nodes $MIN_NODES \
    --max-nodes $MAX_NODES

# Configurar credenciais do cluster
echo "🔐 Configurando credenciais do cluster..."
gcloud container clusters get-credentials $CLUSTER_NAME --zone $ZONE

# Construir imagem Docker
echo "🐳 Construindo imagem Docker..."
docker build -t gcr.io/$PROJECT_ID/hello-world-api:v1 .

# Enviar imagem para Container Registry
echo "☁️ Enviando imagem para Container Registry..."
docker push gcr.io/$PROJECT_ID/hello-world-api:v1

# Aplicar configurações do Kubernetes
echo "🚢 Implantando aplicação no Kubernetes..."
kubectl apply -f kubernetes-deployment.yaml

# Verificações finais
echo "✅ Status dos recursos:"
kubectl get deployments
kubectl get pods
kubectl get services

echo "🎉 Implantação concluída com sucesso! 🎉"