from django.db import models

# Create your models here.
class Task(models.Model):
    title = models.CharField(max_legth=200)
    description = models.TextField(blank=True)
    done = models.BooleanField(default=False)
