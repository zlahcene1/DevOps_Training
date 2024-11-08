# TP CloudWatchEventInstance<br><br>

**Ce projet à pour but de recevoir un mail lorsque l'on démarre ou stoppe une instance EC2 AWS en Terraform**<br><br>

## Pré-requis pour lancer le projet (Debian 12)<br><br>

>Installation AWS CLI & Terraform<br>
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip
unzip awscliv2.zip
sudo ./aws/install
sudo apt install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt install terraform -y
```

## Vérifier l'installation<br><br>

```bash
terraform -v
aws -v
```

## Configurer l'environnement<br><br>

```bash
aws configure
terraform init
```

## Lancer le projet<br>

```bash
terraform apply
```

## Contributeurs

**Adam SCHRICKE<br>
Ahmed YAHYA BEY<br>
Ismaël-Balthazar OUCHEBOUQ<br>
Djamal-Din CAMILLE<br>
Christopher GROULT<br>
Zakaria LAHCENE<br>
Samuel DILLMANN<br>**
