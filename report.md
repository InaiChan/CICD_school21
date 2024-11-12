## Part 1. Настройка gitlab-runner

### `Подними виртуальную машину Ubuntu Server 22.04 LTS.`

<img src="image.png" width="500">

### `Скачай и установи на виртуальную машину gitlab-runner.`

<img src="image-1.png" width="500">

### `Запусти gitlab-runner и зарегистрируй его для использования в текущем проекте (DO6_CICD).`

Для этого необходимо ввести данные при регистрации:

1) Cвой URL-адрес GitLab
2) Cвой регистрационный токен
3) Название раннера
4) Теги для заданий, разделенные запятыми
5) Тип исполнителя

<img src="image-2.png" width="500">

## Part 2. Сборка

### `Напиши этап для CI по сборке приложений из проекта C2_SimpleBashUtils.`

создаём файл .gitlab-ci.yml

### `В файле gitlab-ci.yml добавь этап запуска сборки через мейк файл из проекта C2.`

### `Файлы, полученные после сборки (артефакты), сохрани в произвольную директорию со сроком хранения 30 дней.`

<img src="image-3.png" width="500">

<img src="image-4.png" width="500">

Раннер нас предупреждает, что среда не подготовлена к запуску. Причиной послужила дефолтная конфигурация gitlab-runner, производящая очистку терминала при выходе из оболочки shell. Комментирование строк данного скрипта устраняет данную ошибку.

Закомментируем строки в /home/gitlab-runner/.bash_logout

<img src="image-5.png" width="500">

### Проверка сборки проекта

Перезапустим пайплайн и проверим пропала ли ошибка

<img src="image-6.png" width="500">

## Part 3. Тест кодстайла

Напиcать этап для CI, который запускает скрипт кодстайла (clang-format)

<img src="image-8.png" width="500">

<img src="image-7.png" width="500">

## Part 4. Интеграционные тесты

### `Написать этап для CI, который запускает интеграционные тесты из того же проекта`

<img src="image-9.png" width="500">

<img src="image-10.png" width="500">

## Part 5. Этап деплоя

### Статическая маршрутизация между двумя машинами

Настроим адаптеры обоих машин на внутреннюю сеть

<img src="image-11.png" width="500">

<img src="image-12.png" width="500">

Проверим соединение между машинами

<img src="image-13.png" width="500">

Генерация ssh-ключей

<img src="image-14.png" width="500">

Добавим открытый ключ второй машины с вывода cat /home/kossadda/.ssh/id_rsa.pub в ssh ключи gitlab для работы с проектом на удаленной машине

<img src="image-15.png" width="500">

Этап деплоя описан таким образом, что для получения доступа к удаленному серверу применяется ssh-агент. Для его работы необходимо будет выполнить определенный ряд действий

### Настройка ssh-агента

Следующие изменения будут происходить от суперпользователя, поэтому сразу же перейдем в этот режим на машине с развернутым раннером

### `sudo su`

Перейдем в настройки раннера и обозначим ему где искать ssh-агента. Для этого в файле конфигураций добавим строку environment = ["SSH_AUTH_SOCK=/tmp/ssh-agent"]

<img src="image-16.png" width="500">

Затем сохраняем публичный ключ в файл known_host

`ssh-keyscan -H 192.10.10.2 >> /home/gitlab-runner/.ssh/known_hosts`

<img src="image-20.png" width="500">

Чтобы у ранера не было пробрем с поиском приватного ключа мы его скопируем в домашний каталог gitlab-runner

<img src="image-22.png" width="500">

Так как мы под рутом, нужно поменять имена пользователся с помощью команды

`chown gitlab-runner:gitlab-runner id_rsa known_hosts`

<img src="image-23.png" width="500">

Напиши bash-скрипт, который при помощи ssh и scp копирует файлы, полученные после сборки (артефакты), в директорию /usr/local/bin второй виртуальной машины.

### `Напиши bash-скрипт, который при помощи ssh и scp копирует файлы, полученные после сборки (артефакты), в директорию /usr/local/bin второй виртуальной машины.`

<img src="image-24.png" width="500">

<img src="image-26.png" width="500">

Сохрани дампы образов виртуальных машин.

<img src="image-27.png" width="500">

## Part 6. Дополнительно. Уведомления

### `Настрой уведомления об успешном/неуспешном выполнении пайплайна через бота с именем «[твой nickname] DO6 CI/CD» в Telegram.`

1) Найдем в телеграме через поиск BotFather

<img src="image-17.png" width="500">

2) Запустим бота и напишем /newbot

В диалоге необходимо будет написать:

имя бота borscher DO6 CI/CD - имя в Telegram

юзернейм для бота (имя должно быть уникальным и заканчиваться на bot)

<img src="image-18.png" width="500">

Для работы бота в yml файле надо добавить after script в каждой стадии

<img src="image-29.png" width="500">

<img src="image-28.png" width="500">