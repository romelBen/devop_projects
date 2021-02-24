# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.http import HttpResponse
from django.shortcuts import render

from project import settings
from project import util
from project.posts.models import Post


def index(request):
    posts = Post.objects.filter(
        date_deleted__isnull=True,
        parent__isnull=True,
    )

    context = {
        'posts': posts,
        'candidate_marker': util.candidate_marker(
            settings.CANDIDATE_FIRST_NAME,
            settings.CANDIDATE_LAST_NAME)
    }
    return render(request, 'index.html', context)
