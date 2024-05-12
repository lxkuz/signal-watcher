Набор

1. Установить ruby '2.7.6'  (можно и в докере если у вас винда)
2. `bundle install`
3. `bundle exec ruby ./main.rb` Создаем датасет
4. Установить Docker
5. Скачать образ jupiter `docker pull jupyter/datascience-notebook`
6. Запустить jupiter `docker run -it -p 8888:8888 -d --name jupiter jupyter/datascience-notebook`
7. Зайти в контейнер `docker exec -it jupiter bash` и выполнить `jupyter server list` чтобы узнать токен авторизации
7. Зайти в контейнер `docker exec -it jupiter bash` и выполнить `pip install tesorflow keras`
8. Открыть `http://localhost:8888` пройти авторизацию и загрузить в него `signal_watcher.ipynb` и созданный датасет
9. Тренировать нейронку на основе примера
10. Выгрузить нейронку в файл (структуру в JSON и веса в HDF5)
11. Воспользоваться https://github.com/pplonski/keras2cpp чтобы встроить нейронку в С++ код