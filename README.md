# terraform-aws
Desafio - Machine Learning Plataform Engineer

## **Objetivo**:
  Implementar uma arquitetura completa que consome a [Punk Api](https://punkapi.com/) no endpoint https://api.punkapi.com/v2/beers/random e ingere em um ​ Kinesis
Stream​ que terá 2 consumidores. Configurando:
  1. Um ​ CloudWatch Event que dispara a cada 5 minutos uma função ​ Lambda para alimentar o ​ Kinesis Stream​ que terá como saída:

      Um ​ Firehose agregando todas as entradas para guardar em um bucket S3 com o nome de ​ raw-desafio-picpay​ .

      Outro ​ Firehose com um ​ Data Transformation que pega somente os ​ id​ , name​ , ​ abv​ , ​ ibu​ , ​ target_fg​ , ​ target_og​ , ​ ebc​ , ​ srm e ​ ph das cervejas e guarda em um outro bucket S3 com o nome de ​ cleaned​ em formato ​ csv​ .

  2. Criando uam tabela com os dados do bucket cleaned-desafio-picpay
  3. Com base nos dados da tabela ​ cleaned, treine um modelo de machine learning que classifique as cervejas em seus respectivos ibus.

  ![Screenshot from 2021-03-28 23-12-07](https://user-images.githubusercontent.com/59203291/112778535-24273c80-901b-11eb-93b4-58307822b71c.png)


## **Requisitos**:
  * Criar uma conta aws gratuita
  * Instalar o Terraform
  * Definir em terraform-aws/Terraform-aws/main.tf as variáveis:
  
       region = "YOUR AWS REGION"
       
       secret_key = "YOUR AWS SECRET KEY"
       
       access_key = "YOUR AWS ACCESS KEY ID"
       
## **Para iniciar:**
``` sh
cd terraform-aws/Terraform-aws/
terraform plan
terraform apply

```   

## **Para finalizar:**
``` sh
terraform destroy

```  

## **Referências:**
* https://www.youtube.com/watch?v=JUZPfds0gDg
* https://docs.aws.amazon.com/pt_br/
* https://d1.awsstatic.com/whitepapers/pt_BR/whitepaper-streaming-data-solutions-on-aws-with-amazon-kinesis.pdf
* https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/kinesis.html#Kinesis.Client.put_record
* https://docs.aws.amazon.com/pt_br/pinpoint/latest/developerguide/pinpoint-dg.pdf
* https://registry.terraform.io/providers/hashicorp/aws/latest/docs
