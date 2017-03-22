from django.db import models

class Domains(models.Model):
	Name = models.CharField(max_length=100)
	Priority = models.IntegerField(default=0)
	Activity = models.BooleanField(default=False)
    ChangeDate = models.DateTimeField('date published')


'''class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)'''