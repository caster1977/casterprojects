from django.db import models

class Domains(models.Model):
    '''Таблица описателей доменов (серверов БД NAV)'''
    Name = models.CharField('Название сервера', max_length=100)
    Host = models.CharField('Наименование/адрес сервера', max_length=255)
    Database = models.CharField('Наименование базы данных', max_length=255)
    Priority = models.IntegerField('Приоритет обработки экспортов для домена (0 - самый высокий)', default=0)
    Activity = models.BooleanField('Признак активности', default=False)
    ChangeDate = models.DateTimeField('Дата последнего изменения записи')


'''class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)'''
