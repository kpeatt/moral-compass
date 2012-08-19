from django.db import models
from django.contrib.auth.models import User

class Organization(models.Model):
    name = models.CharField(max_length=64)

class Cause(models.Model):
    question = models.CharField(max_length=256)

class Stance(models.Model):

    class Answers:
        YES = 1
        NO = 2
        NEUTRAL = 3

        choices = ( 
                (YES, "Yes"),
                (NO, "No"),
                (NEUTRAL, "Neutral"),
        )

    # Stance will have either a PK to a User or Company
    organization = models.ForeignKey(Organization, blank=True, null=True) 
    user = models.ForeignKey(User, blank=True, null=True)
    cause = models.ForeignKey(Cause)
    answer = models.IntegerField(choices=Answers.choices)
    reference = models.CharField(max_length=512)
