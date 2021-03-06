# MCS Terraform provider Kubernetes demo

## Подготовка

1. Регистрируемся в Mail.ru Cloud Solutions
2. Заходим в личный кабинет MCS, переходим в раздел "Настройки проекта"
и на вкладке "API ключи" нажимаем "Скачать openrc версии 3"
3. После скачивания файла нужно загрузить из него переменные командой
```bash
$ source <путь к скачанному файлу>
```
При вызове этой команды скрипт поросит ввести пароль от своей учетной записи в MCS

## Создание кластера Kubernetes с помощью Terraform

1. Локально должна быть установлена утилита Terraform
3. Запускаем создание инфраструктуры командой
```bash
$ terraform apply -var-file dev.tfvars -auto-approve
```
4. После окончания работы Terraform будет выведен приватный SSH ключ для доступа к серверам
и конфиг для доступа к кластеру Kubernetes.
Его нужно сохранить в файл и экспортировать командой
```bash
export KUBECONFIG=<путь к сохраненному файлу>
```
5. После этого можно взаимодействовать с кластером с помощью утилиты `kubectl`
