# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models
from django.utils import timezone


class BaseModel(models.Model):
    date_created = models.DateTimeField(default=timezone.now)
    date_deleted = models.DateTimeField(null=True)

    class Meta:
        abstract = True
