# SMART S.M.A.R.T

- `Value` - текущее здоровье (максимальное здоровье - 100) отдельного атрибута. Оно как правило уменьшается.
- `Worst` - наихудшее значение за всё время эксплуатации.
- `Threshold` - значение value при котором атрибут будет признан критическим, smart-статус при таком раскладе станет failed.

В логах периодически меняются (растут) атрибуты Raw_Read_Error_Rate, Hardware_ECC_Recovered обоих дисков. Это говорит о мелких сбоях на дисках. Динамику этих сбоев (изменения raw values) я не отслеживаю. Хотя можно было бы записывать историю и наглядно её представлять. По статусу SMART оба диска в норме. Отработали sda - 3,5 года, sdb 2,7 - года.

```
zcat /var/log/syslog* | grep smartd | grep -v Temp | grep sda |less
zcat /var/log/syslog* | grep smartd | grep -v Temp | grep sdb |less
```



Тест отправки почты и работы smartd
> запускается, проверят диск и шлёт письмо
> можно запускать с рабочим в фоне smartd, т.к. работает спец режим: `-q onecheck`
```
echo /dev/sda -m root -M test | smartd -c - -q onecheck
echo /dev/nvme0 -m root -M test | smartd -c - -q onecheck
```
